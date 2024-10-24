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

// Función para obtener productos de una venta
function obtenerProductosDeVenta($venta_id) {
    global $conn;
    $sql = "SELECT dv.producto_idproducto, p.nombre, dv.cantidad, dv.precio 
            FROM detalle_ventas dv 
            JOIN producto p ON dv.producto_idproducto = p.idproducto 
            WHERE dv.venta_idventa = ?";
    
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $venta_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $productos = $result->fetch_all(MYSQLI_ASSOC);
    
    return $productos;
}

// Solicitud para obtener productos asociados a una venta
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['accion']) && $_POST['accion'] === 'cargarProductosDeVenta') {
    $venta_id = isset($_POST['venta_id']) ? intval($_POST['venta_id']) : null;

    if ($venta_id) {
        $productos = obtenerProductosDeVenta($venta_id);
        echo json_encode(['success' => true, 'productos' => $productos]);
    } else {
        echo json_encode(['error' => 'ID de venta no válido.']);
    }
    exit();
}

// Editar la factura al registrar la devolución
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['registrar_devolucion'])) {
    // Validar que se haya enviado el ID de venta y el ID de producto
    $venta_id = isset($_POST['venta_id']) ? intval($_POST['venta_id']) : null;
    $producto_id = isset($_POST['producto_id']) ? intval($_POST['producto_id']) : null;
    $cantidad = isset($_POST['cantidad']) ? intval($_POST['cantidad']) : null;
    $motivo = isset($_POST['motivo']) ? trim($_POST['motivo']) : '';

    // Verificar si los datos de devolución están completos
    if (!$venta_id || !$producto_id || !$cantidad || $cantidad <= 0) {
        echo json_encode(['error' => 'Datos de devolución incompletos.']);
        exit();
    }

    // Iniciar una transacción
    $conn->begin_transaction();

    try {
        // Actualizar la cantidad en la tabla detalle_ventas
        $sql = "UPDATE detalle_ventas SET cantidad = cantidad - ? WHERE venta_idventa = ? AND producto_idproducto = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("iii", $cantidad, $venta_id, $producto_id);
        if (!$stmt->execute()) {
            throw new Exception('Error al actualizar la factura.');
        }

        // Actualizar el inventario
        $sql_update = "UPDATE producto SET cantidad = cantidad + ? WHERE idproducto = ?";
        $stmt_update = $conn->prepare($sql_update);
        $stmt_update->bind_param("ii", $cantidad, $producto_id);
        if (!$stmt_update->execute()) {
            throw new Exception('Error al actualizar el inventario.');
        }

        // Confirmar la transacción
        $conn->commit();
        echo json_encode(['success' => true, 'message' => 'Devolución registrada correctamente.']);
    } catch (Exception $e) {
        // Revertir la transacción en caso de error
        $conn->rollback();
        echo json_encode(['error' => $e->getMessage()]);
    }
    exit();
}
?>
