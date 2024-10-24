<?php
session_start(); // Inicia la sesión

// Destruir la sesión
session_unset(); // Libera todas las variables de sesión
session_destroy(); // Destruye la sesión actual

// Redirigir a la página de inicio de sesión
header("Location: ../login.php");
exit();
?>
