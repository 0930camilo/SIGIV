<?php
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

include '../config/conexion.php';

// Verificar si el usuario está autenticado
if (!isset($_SESSION['usuario'])) {
    echo json_encode(['error' => 'Por favor, inicie sesión.']);
    exit();
}

// Verificar si 'usuario_id' está definido en la sesión
if (!isset($_SESSION['usuario_id'])) {
    echo json_encode(['error' => 'No se pudo obtener el ID de usuario.']);
    exit();
}

$usuario_id = $_SESSION['usuario_id']; // Guardar el ID del usuario en una variable

// Solicitud para obtener categorías
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['accion']) && $_POST['accion'] === 'cargarCategorias') {
    $sql = "SELECT idcategoria, nombre FROM categoria WHERE usuario_idusuario = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $usuario_id);
    $stmt->execute();
    $result = $stmt->get_result();

    $categorias = [];
    while ($row = $result->fetch_assoc()) {
        $categorias[] = $row;
    }

    echo json_encode(['success' => true, 'categorias' => $categorias]);
    $stmt->close();
    $conn->close();
    exit();
}

if (isset($_POST['accion']) && $_POST['accion'] === 'actualizar_carrito') {
    // Verificar que el carrito no esté vacío
    if (!isset($_SESSION['carrito']) || empty($_SESSION['carrito'])) {
        echo json_encode(['html' => '<p>El carrito está vacío.</p>']);
        exit();
    }

    // Generar HTML para la tabla del carrito
    ob_start(); // Comienza la captura de la salida
    ?>
    <table class="carr" border="1">
        <thead class="carr">
            <tr>
                <th>id</th>
                <th>Producto</th>
                <th>Descripción</th>
                <th>Cantidad</th>
                <th>Precio</th>
                <th>Subtotal</th>
                <th>Eliminar</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($_SESSION['carrito'] as $index => $item): ?>
                <tr>
                <td class="td"><?= htmlspecialchars($item['idproducto']) ?></td>
                    <td class="td"><?= htmlspecialchars($item['nombre']) ?></td>
                    <td class="td"><?= htmlspecialchars($item['descripcion']) ?></td>
                    <td class="td"><?= htmlspecialchars($item['cantidad']) ?></td>
                    <td class="td">$<?= number_format($item['precio'], 0, ',', '.') ?></td>
                    <td class="td">$<?= number_format($item['subtotal'], 0, ',', '.') ?></td>
                    <td>
                        <form class="eliminar-producto-form" method="post">
                            <input type="hidden" name="accion" value="eliminar_producto">
                            <input type="hidden" name="index" value="<?= $index ?>">
                            <button type="submit" class="btn-eliminar">Eliminar</button>
                        </form>
                    </td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    <?php
    $html = ob_get_clean(); // Captura el contenido generado
    echo json_encode(['html' => $html]); // Retorna como JSON
    exit();
}
// Filtrar productos por nombre
function filtrarProductosPorNombre($nombre_producto) {
    global $conn, $usuario_id;
    $sql = "SELECT idproducto, nombre, descripcion, precio, cantidad FROM producto WHERE usuario_idusuario = ? AND nombre LIKE ? AND estado = 'activo'";
    
    $nombre_producto = "%" . $nombre_producto . "%"; // Para realizar una búsqueda parcial

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("is", $usuario_id, $nombre_producto);
    $stmt->execute();
    $result = $stmt->get_result();
    $productos = $result->fetch_all(MYSQLI_ASSOC);

    // Formatear precios
    foreach ($productos as &$producto) {
        $producto['precio'] = number_format($producto['precio'], 0, ',', '.'); // Formatear sin decimales
    }
    return $productos;
}

// Solicitud para obtener productos filtrados por nombre
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['accion']) && $_POST['accion'] === 'buscarPorNombre') {
    $nombre_producto = isset($_POST['nombre_producto']) ? trim($_POST['nombre_producto']) : '';
    $productos = filtrarProductosPorNombre($nombre_producto);
    echo json_encode(['success' => true, 'productos' => $productos]);
    exit();
}


// Listar productos disponibles
function listarProductos($categoria_id = null) {
    global $conn, $usuario_id;
    $sql = "SELECT idproducto, nombre, descripcion, precio, cantidad FROM producto WHERE usuario_idusuario = ? AND estado = 'activo'";
    
    if ($categoria_id !== null && $categoria_id != 'todos') {
        $sql .= " AND categoria_idcategoria = ?";
    }

    $stmt = $conn->prepare($sql);
    if ($categoria_id !== null && $categoria_id != 'todos') {
        $stmt->bind_param("ii", $usuario_id, $categoria_id);
    } else {
        $stmt->bind_param("i", $usuario_id);
    }
    
    $stmt->execute();
    $result = $stmt->get_result();
    $productos = $result->fetch_all(MYSQLI_ASSOC);

    // Formatear precios
    foreach ($productos as &$producto) {
        $producto['precio'] = number_format($producto['precio'], 0, ',', '.'); // Formatear sin decimales
    }
    return $productos;
}

// Agregar productos al carrito
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['producto_id'])) {
    $producto_id = $_POST['producto_id'];
    $cantidad = intval($_POST['cantidad']); // Asegúrate de que sea un número entero

    // Obtener detalles del producto
    $sql = "SELECT * FROM producto WHERE idproducto = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $producto_id);
    $stmt->execute();
    $producto = $stmt->get_result()->fetch_assoc();

    if ($producto) {
        // Verificar si el producto ya está en el carrito
        $producto_en_carrito = false;
        foreach ($_SESSION['carrito'] as &$item) {
            if ($item['idproducto'] == $producto['idproducto']) {
                // Actualizar la cantidad y el subtotal
                $item['cantidad'] = $cantidad; // Actualiza a la cantidad enviada
                $item['subtotal'] = $item['precio'] * $item['cantidad'];
                $producto_en_carrito = true;
                break;
            }
        }

        if (!$producto_en_carrito) {
            // Agregar el producto al carrito
            $_SESSION['carrito'][] = [
                'idproducto' => $producto['idproducto'],
                'nombre' => $producto['nombre'],
                'descripcion' => $producto['descripcion'],
                'cantidad' => $cantidad,
                'precio' => $producto['precio'],
                'subtotal' => $producto['precio'] * $cantidad
            ];
        }

        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['error' => 'Producto no encontrado.']);
    }
    exit();
}
// Registrar la venta
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['registrar_venta'])) {
    // Validar que el carrito no esté vacío
    if (!isset($_SESSION['carrito']) || empty($_SESSION['carrito'])) {
        echo json_encode(['error' => 'No hay productos en el carrito.']);
        exit();
    }

    // Capturar el nombre, teléfono del cliente y monto pagado
    $nombre_cliente = isset($_POST['nombre_cliente']) ? trim($_POST['nombre_cliente']) : null;
    $telefono_cliente = isset($_POST['telefono_cliente']) ? trim($_POST['telefono_cliente']) : null;
    $monto_pagado = isset($_POST['monto_pagado']) ? floatval($_POST['monto_pagado']) : null;

    $total = array_sum(array_column($_SESSION['carrito'], 'subtotal'));
    
    // Verifica si el monto pagado es suficiente
    if ($monto_pagado < $total) {
        echo json_encode(['error' => 'El monto pagado es insuficiente.']);
        exit();
    }

    // Calcular el cambio
    $cambio = $monto_pagado - $total;

    // Iniciar una transacción
    $conn->begin_transaction();

    try {
        // Insertar la venta en la tabla ventas
        $sql = "INSERT INTO ventas (usuario_idusuario, total, nombre_cliente, telefono_cliente, efectivo, cambio) VALUES (?, ?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("idssdd", $usuario_id, $total, $nombre_cliente, $telefono_cliente, $monto_pagado, $cambio);
        if (!$stmt->execute()) {
            throw new Exception('Error al registrar la venta.');
        }
        $venta_id = $stmt->insert_id;

        // Insertar detalles de la venta y actualizar inventario
        $sql_detalle = "INSERT INTO detalle_ventas (venta_idventa, producto_idproducto, cantidad, precio) VALUES (?, ?, ?, ?)";
        $stmt_detalle = $conn->prepare($sql_detalle);
        $sql_update = "UPDATE producto SET cantidad = cantidad - ? WHERE idproducto = ?";
        $stmt_update = $conn->prepare($sql_update);

        // Registrar detalles y actualizar inventario
        foreach ($_SESSION['carrito'] as $item) {
            $stmt_detalle->bind_param("iiid", $venta_id, $item['idproducto'], $item['cantidad'], $item['precio']);
            if (!$stmt_detalle->execute()) {
                throw new Exception('Error al insertar detalles de la venta.');
            }
            $stmt_update->bind_param("ii", $item['cantidad'], $item['idproducto']);
            if (!$stmt_update->execute()) {
                throw new Exception('Error al actualizar el inventario.');
            }
        }

        // Vaciar el carrito
        unset($_SESSION['carrito']);

        // Confirmar la transacción
        $conn->commit();

        // Redirigir o enviar respuesta
        echo json_encode(['success' => true, 'mensaje' => 'Compra realizada con éxito.']);
    } catch (Exception $e) {
        $conn->rollback();
        echo json_encode(['error' => $e->getMessage()]);
    }
    exit();
}




// Eliminar producto del carrito
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['accion']) && $_POST['accion'] === 'eliminar_producto') {
    if (!isset($_SESSION['carrito']) || empty($_SESSION['carrito'])) {
        http_response_code(400);
        exit();
    }

    if (isset($_POST['index']) && is_numeric($_POST['index'])) {
        $index = intval($_POST['index']);

        if (isset($_SESSION['carrito'][$index])) {
            unset($_SESSION['carrito'][$index]);
            $_SESSION['carrito'] = array_values($_SESSION['carrito']);
        } else {
            http_response_code(400);
        }
    } else {
        http_response_code(400);
    }
    exit();
}


// Solicitud para obtener productos
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['obtener_productos'])) {
    $categoria_id = isset($_POST['categoria_idcategoria']) ? $_POST['categoria_idcategoria'] : null;
    $productos = listarProductos($categoria_id);
    echo json_encode(['success' => true, 'productos' => $productos]);
    exit();
}
?>
