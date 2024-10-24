<?php
session_start();
include '../controller/totalController.php'; // Asegúrate de que el controlador esté en la ruta correcta

// Verificar sesión del usuario
if (!isset($_SESSION['usuario_id'])) {
    echo "<script>alert('No se pudo obtener el ID de usuario.'); window.location.href='../login.php';</script>";
    exit();
}

$usuario_id = $_SESSION['usuario_id'];

// Obtener total vendido hoy

$ventas = obtenerVentas($usuario_id);
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Total Vendido Hoy</title>
    <link rel="stylesheet" href="../css/estilos.css"> <!-- Enlace a los estilos si los tienes -->
</head>
<body>
   
</body>
</html>
