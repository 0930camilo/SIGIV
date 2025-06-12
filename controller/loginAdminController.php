<?php
include '../config/conexion.php'; // Incluir el archivo de conexión

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Obtener y sanitizar los datos del formulario
    $usuario = mysqli_real_escape_string($conn, $_POST['Nombre']);
    $clave = mysqli_real_escape_string($conn, $_POST['Clave']); // Sanitizar la contraseña para evitar inyecciones SQL

    // Consulta SQL para obtener el usuario y la contraseña no encriptada
    $sql = "SELECT * FROM admin WHERE Nombre = '$usuario' AND Clave = '$clave'";
    $result = mysqli_query($conn, $sql);

    // Verificar si la consulta se ejecuta correctamente
    if (!$result) {
        die('Error en la consulta: ' . mysqli_error($conn));
    }

    // Verificar si el usuario existe y la clave coincide
    if (mysqli_num_rows($result) == 1) {
        $user_data = mysqli_fetch_assoc($result);

        // Iniciar sesión exitosa
        session_start();
        $_SESSION['Nombre'] = $user_data['Nombre'];
       
        // Redirigir a la página principal
        header("Location: ../view/admin.php");
  
    } else {
        // Usuario o clave incorrectos
        echo "<script>alert('Usuario o clave incorrecta.'); window.location.href='../loginAdmin.php';</script>";
    }

    // Cerrar la conexión a la base de datos
    mysqli_close($conn);
} else {
    echo "Método de solicitud no válido.";
}
