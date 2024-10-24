<?php
include '../config/conexion.php'; // Incluye la conexión a la base de datos

// Función para obtener el total vendido hoy
function obtenerTotalVendidoHoy($usuario_id) {
    global $conn;
    $sql = "SELECT SUM(total) AS total_vendido FROM ventas WHERE usuario_idusuario = ? AND DATE(fecha) = CURDATE()";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $usuario_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $data = $result->fetch_assoc();
    return $data['total_vendido'] ?? 0; // Retorna 0 si no hay ventas
}

// Función para obtener la lista de ventas realizadas por el usuario
function obtenerVentas($usuario_id) {
    global $conn;
    $sql = "SELECT * FROM ventas WHERE usuario_idusuario = ? ORDER BY idventa DESC";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $usuario_id);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_all(MYSQLI_ASSOC);
}

// Si se hace una petición AJAX para obtener el total vendido hoy
if (isset($_GET['accion']) && $_GET['accion'] === 'obtener_total_vendido') {
    $usuario_id = $_GET['usuario_id']; // Obtener el ID del usuario de la petición
    $total_vendido = obtenerTotalVendidoHoy($usuario_id);
    echo json_encode(['total_vendido_hoy' => number_format($total_vendido, 0, ',', '.')]); // Cambiar el formato para mostrar sin decimales
}
?>
