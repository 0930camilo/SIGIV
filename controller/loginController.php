<?php
session_start(); // Inicia la sesión
echo session_id(); // Muestra el ID de sesión

// Aquí puedes continuar con tu lógica de inicio de sesión

include '../config/conexion.php'; // Incluir el archivo de conexión

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Obtener y sanitizar los datos del formulario
    $usuario = mysqli_real_escape_string($conn, $_POST['usuario']);
    $clave = $_POST['clave']; // No sanitizar la contraseña aquí, ya que vamos a verificarla con password_verify()

    // Consulta SQL para obtener el usuario y la contraseña encriptada
    $sql = "SELECT * FROM usuario WHERE usuario = '$usuario' AND estado = 'Activo'";
    $result = mysqli_query($conn, $sql);

    // Verificar si el usuario existe y su estado es activo
    if (mysqli_num_rows($result) == 1) {
        $user_data = mysqli_fetch_assoc($result);
        
        // Verificar la contraseña encriptada
        if (password_verify($clave, $user_data['clave'])) {
            session_regenerate_id(true);
            
            // Almacenar el ID del usuario en la sesión
            $_SESSION['usuario'] = $user_data['usuario'];
            $_SESSION['usuario_id'] = $user_data['idusuario']; 
            
            // Redirigir a la página de usuario
            header("Location: ../view/PRINCIPAL.php");
            exit();
        } else {
            // Credenciales incorrectas
            echo "<script>alert('Usuario o clave incorrecta.'); window.location.href='../login.php';</script>";
        }
    } else {
        // Usuario no encontrado o no activo
        echo "<script>alert('Usuario no encontrado o inactivo.'); window.location.href='../login.php';</script>";
    }

    // Cerrar la conexión a la base de datos
    mysqli_close($conn);
} else {
    echo "Método de solicitud no válido.";
}
?>
