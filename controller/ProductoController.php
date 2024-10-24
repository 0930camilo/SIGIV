<?php
session_start();
include '../config/conexion.php';

// Verificar si el usuario ha iniciado sesión
if (!isset($_SESSION['usuario_id'])) {
    echo json_encode(['status' => 'error', 'message' => 'Usuario no autenticado.']);
    exit();
}

// Obtener el ID del usuario desde la sesión
$usuario_id = $_SESSION['usuario_id'];

// Manejo de operaciones para productos
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["accion"])) {
    $accion = $_POST["accion"];
    $idproducto = $_POST["idproducto"] ?? null;
    $nombre = $_POST["nombre"] ?? '';
    $descripcion = $_POST["descripcion"] ?? '';
    $cantidad = $_POST["cantidad"] ?? 0;
    $precioCompra = $_POST["precioCompra"] ?? 0.0;
    $precio = $_POST["precio"] ?? 0.0;
    $categoria_idcategoria = $_POST["categoria_idcategoria"] ?? null;
    $proveedor_idproveedor = $_POST["proveedor_idproveedor"] ?? null;

    $response = [];

    if ($accion === 'eliminar') {
        if (!$idproducto) {
            $response['status'] = 'error';
            $response['message'] = 'ID de producto no proporcionado.';
        } else {
            // Cambiar el estado del producto de 'activo' a 'inactivo'
            $sql = "UPDATE producto SET estado='inactivo' WHERE idproducto=? AND usuario_idusuario=?";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "ii", $idproducto, $usuario_id);
    
            if (mysqli_stmt_execute($stmt)) {
                $response['status'] = 'success';
                $response['message'] = 'El producto se ha marcado como inactivo.';
            } else {
                $response['status'] = 'error';
                $response['message'] = 'No se pudo actualizar el estado del producto.';
            }
            mysqli_stmt_close($stmt);
        }
    
    
    } elseif ($accion === 'guardar') {
        if (empty($idproducto)) {
            // Insertar nuevo producto
            $sql = "INSERT INTO producto (nombre, descripcion, cantidad, precioCompra, precio, usuario_idusuario, categoria_idcategoria, proveedor_idproveedor) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "ssiddiii", $nombre, $descripcion, $cantidad, $precioCompra, $precio, $usuario_id, $categoria_idcategoria, $proveedor_idproveedor);
        } else {
            // Actualizar producto existente
            $sql = "UPDATE producto SET nombre=?, descripcion=?, cantidad=?, precioCompra=?, precio=?, categoria_idcategoria=?, proveedor_idproveedor=? WHERE idproducto=? AND usuario_idusuario=?";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "ssiddiiii", $nombre, $descripcion, $cantidad, $precioCompra, $precio, $categoria_idcategoria, $proveedor_idproveedor, $idproducto, $usuario_id);
        }

        if (mysqli_stmt_execute($stmt)) {
            $response['status'] = 'success';
        } else {
            $response['status'] = 'error';
            $response['message'] = 'No se pudieron guardar los datos del producto.';
        }
        mysqli_stmt_close($stmt);
        
    } elseif ($accion === 'cargar') {
        // Consulta para obtener los productos del usuario actual con filtros opcionales
        $categoriaFiltro = $_POST["categoriaFiltro"] ?? null;
        $nombreBuscar = $_POST["nombreBuscar"] ?? '';
    
        $sql_producto = "SELECT p.idproducto, p.nombre, p.descripcion, p.cantidad, p.precioCompra, p.precio, c.nombre AS categoriaNombre, p.categoria_idcategoria, pr.nombre AS proveedorNombre
        FROM producto p
        LEFT JOIN categoria c ON p.categoria_idcategoria = c.idcategoria
        LEFT JOIN proveedor pr ON p.proveedor_idproveedor = pr.idproveedor
        WHERE p.usuario_idusuario = ? AND p.estado = 'activo'";

// Agregar condiciones de filtrado
if ($categoriaFiltro && $categoriaFiltro !== "todos") {
$sql_producto .= " AND p.categoria_idcategoria = ?";
}

if (!empty($nombreBuscar)) {
$sql_producto .= " AND p.nombre LIKE CONCAT('%', ?, '%')";
}

// Agregar la cláusula ORDER BY para ordenar de forma descendente
$sql_producto .= " ORDER BY p.idproducto DESC"; // Cambia 'p.precio' por la columna que desees

    
        $stmt = mysqli_prepare($conn, $sql_producto);
    
        // Binding de parámetros
        if ($categoriaFiltro && $categoriaFiltro !== "todos" && !empty($nombreBuscar)) {
            mysqli_stmt_bind_param($stmt, "iis", $usuario_id, $categoriaFiltro, $nombreBuscar);
        } elseif ($categoriaFiltro && $categoriaFiltro !== "todos") {
            mysqli_stmt_bind_param($stmt, "ii", $usuario_id, $categoriaFiltro);
        } elseif (!empty($nombreBuscar)) {
            mysqli_stmt_bind_param($stmt, "is", $usuario_id, $nombreBuscar);
        } else {
            mysqli_stmt_bind_param($stmt, "i", $usuario_id);
        }
    
        mysqli_stmt_execute($stmt);
        $result_producto = mysqli_stmt_get_result($stmt);
    
        $productos = [];
        while ($row_producto = mysqli_fetch_assoc($result_producto)) {
            // Formatear los precios eliminando los decimales si son cero
            $row_producto['precioCompra'] = rtrim(rtrim(number_format($row_producto['precioCompra'], 2, ',', '.'), '0'), ',');
            $row_producto['precio'] = rtrim(rtrim(number_format($row_producto['precio'], 2, ',', '.'), '0'), ',');
            $productos[] = $row_producto;
        }
        $response['productos'] = $productos;
        $response['status'] = 'success';
        mysqli_stmt_close($stmt);
    }
    
    
    elseif ($accion === 'editar') {
        // Cargar datos de un producto específico para ser editado
        if (!$idproducto) {
            $response['status'] = 'error';
            $response['message'] = 'ID de producto no proporcionado.';
        } else {
            $sql = "SELECT idproducto, nombre, descripcion, cantidad, precioCompra, precio, categoria_idcategoria, proveedor_idproveedor FROM producto WHERE idproducto=? AND usuario_idusuario=?";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "ii", $idproducto, $usuario_id);
            mysqli_stmt_execute($stmt);
            $result_producto = mysqli_stmt_get_result($stmt);
            $producto = mysqli_fetch_assoc($result_producto);

            if ($producto) {
                $response['status'] = 'success';
                $response['producto'] = $producto;
            } else {
                $response['status'] = 'error';
                $response['message'] = 'Producto no encontrado.';
            }

            mysqli_stmt_close($stmt);
        }
    }


    mysqli_close($conn);
    echo json_encode($response);
    exit();
}
?>
