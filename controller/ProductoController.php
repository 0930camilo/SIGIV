<?php
session_start();
include '../config/conexion.php';

if (!isset($_SESSION['usuario_id'])) {
    echo json_encode(['status' => 'error', 'message' => 'Sesión inválida']);
    exit;
}

$usuario_id = $_SESSION['usuario_id'];

$accion = $_POST['accion'] ?? '';

switch ($accion) {
    case 'guardar':
        $id = $_POST['idproducto'] ?? '';
        $nombre = $_POST['nombre'] ?? '';
        $descripcion = $_POST['descripcion'] ?? '';
        $cantidad = $_POST['cantidad'] ?? 0;
        $precioCompra = $_POST['precioCompra'] ?? 0;
        $precio = $_POST['precio'] ?? 0;
        $categoria = $_POST['categoria_idcategoria'] ?? '';
        $proveedor = $_POST['proveedor_idproveedor'] ?? '';

        if ($id) {
            $sql = "UPDATE producto SET nombre=?, descripcion=?, cantidad=?, precioCompra=?, precio=?, categoria_idcategoria=?, proveedor_idproveedor=?
                    WHERE idproducto=? AND usuario_idusuario=?";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("ssiddiiii", $nombre, $descripcion, $cantidad, $precioCompra, $precio, $categoria, $proveedor, $id, $usuario_id);
        } else {
            $sql = "INSERT INTO producto (nombre, descripcion, cantidad, precioCompra, precio, categoria_idcategoria, proveedor_idproveedor, usuario_idusuario)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("ssiddiii", $nombre, $descripcion, $cantidad, $precioCompra, $precio, $categoria, $proveedor, $usuario_id);
        }

        if ($stmt->execute()) {
            echo json_encode(['status' => 'success', 'message' => 'Producto guardado correctamente']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Error al guardar el producto']);
        }

        $stmt->close();
        break;

    case 'cargar':
        $categoriaFiltro = $_POST['categoriaFiltro'] ?? 'todos';
        $nombreBuscar = $_POST['nombreBuscar'] ?? '';

        $sql = "SELECT p.*, c.nombre AS categoriaNombre, pr.nombre AS proveedorNombre
                FROM producto p
                JOIN categoria c ON p.categoria_idcategoria = c.idcategoria
                JOIN proveedor pr ON p.proveedor_idproveedor = pr.idproveedor
                WHERE p.usuario_idusuario = ?";

        $params = [$usuario_id];
        $types = "i";

        if ($categoriaFiltro !== 'todos') {
            $sql .= " AND p.categoria_idcategoria = ?";
            $params[] = $categoriaFiltro;
            $types .= "i";
        }

        if (!empty($nombreBuscar)) {
            $sql .= " AND p.nombre LIKE ?";
            $params[] = '%' . $nombreBuscar . '%';
            $types .= "s";
        }

        $sql .= " ORDER BY p.idproducto DESC";

        $stmt = $conn->prepare($sql);

        $stmt->bind_param($types, ...$params);
        $stmt->execute();
        $result = $stmt->get_result();

        $productos = [];
        while ($row = $result->fetch_assoc()) {
            $productos[] = $row;
        }

        echo json_encode(['status' => 'success', 'productos' => $productos]);

        $stmt->close();
        break;

    case 'obtener':
        $id = $_POST['idproducto'] ?? 0;

        $sql = "SELECT * FROM producto WHERE idproducto = ? AND usuario_idusuario = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("ii", $id, $usuario_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $producto = $result->fetch_assoc();

        if ($producto) {
            echo json_encode(['status' => 'success', 'producto' => $producto]);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Producto no encontrado']);
        }

        $stmt->close();
        break;

    case 'eliminar':
        $id = $_POST['idproducto'] ?? 0;

        $sql = "DELETE FROM producto WHERE idproducto = ? AND usuario_idusuario = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("ii", $id, $usuario_id);

        if ($stmt->execute()) {
            echo json_encode(['status' => 'success', 'message' => 'Producto eliminado']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'No se pudo eliminar']);
        }

        $stmt->close();
        break;

    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

$conn->close();
