<?php
require_once __DIR__ . '/../vendor/autoload.php';
include '../config/conexion.php';

if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Verificar si el usuario está autenticado
if (!isset($_SESSION['usuario']) || !isset($_SESSION['usuario_id'])) {
    echo json_encode(['error' => 'No autorizado.']);
    exit();
}

$usuario_id = $_SESSION['usuario_id'];

// Función para editar la cantidad de productos en una devolución y calcular el cambio
function editarCantidadProductoDevolucion($conn, $venta_id, $producto_id, $nueva_cantidad, $monto_pagado) {
    // Actualizar la cantidad del producto en detalle_ventas
    $sql = "UPDATE detalle_ventas SET cantidad = ? WHERE venta_idventa = ? AND producto_idproducto = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("iii", $nueva_cantidad, $venta_id, $producto_id);
    if (!$stmt->execute()) {
        return false;
    }

    // Calcular el nuevo total sumando el precio * cantidad de cada producto en la venta
    $sql_total = "SELECT SUM(d.cantidad * p.precio) AS nuevo_total
                  FROM detalle_ventas d
                  JOIN producto p ON d.producto_idproducto = p.idproducto
                  WHERE d.venta_idventa = ?";
    $stmt_total = $conn->prepare($sql_total);
    $stmt_total->bind_param("i", $venta_id);
    $stmt_total->execute();
    $resultado_total = $stmt_total->get_result()->fetch_assoc();
    $nuevo_total = $resultado_total['nuevo_total'];

    // Actualizar el total de la venta en la tabla ventas
    $sql_update_venta = "UPDATE ventas SET total = ? WHERE idventa = ?";
    $stmt_update_venta = $conn->prepare($sql_update_venta);
    $stmt_update_venta->bind_param("di", $nuevo_total, $venta_id);
    $stmt_update_venta->execute();

    // Calcular el cambio
    $cambio = $monto_pagado - $nuevo_total;

    // Retornar el cambio junto con el estado de éxito
    return ['success' => true, 'nuevo_total' => $nuevo_total, 'cambio' => $cambio];
}

// Procesar la solicitud de devolución
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['accion']) && $_POST['accion'] === 'devolucion') {
    $venta_id = $_POST['venta_id'];
    $producto_id = $_POST['producto_id'];
    $nueva_cantidad = $_POST['cantidad'];
    $monto_pagado = $_POST['monto_pagado'];

    $resultado = editarCantidadProductoDevolucion($conn, $venta_id, $producto_id, $nueva_cantidad, $monto_pagado);

    if ($resultado['success']) {
        echo json_encode([
            'success' => 'Cantidad y total de venta actualizados correctamente para devolución.',
            'nuevo_total' => $resultado['nuevo_total'],
            'cambio' => $resultado['cambio']
        ]);
    } else {
        echo json_encode(['error' => 'Error al actualizar la cantidad y total de venta para la devolución.']);
    }
    exit();
}
?>
