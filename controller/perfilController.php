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

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["accion"])) {
    $accion = $_POST["accion"];
    $nombre = $_POST["usuario"] ?? ''; 
    $clave = $_POST["clave"] ?? ''; 
    $nit = $_POST["nit"] ?? ''; // Tratar como string
    $telefono = $_POST["telefono"] ?? ''; // Tratar como string
    $direccion = $_POST["direccion"] ?? '';
    $usuario_id_actualizar = $_POST["usuario_id"] ?? null;

    $response = [];

    if ($accion === 'actualizar') {
        if (empty($usuario_id_actualizar) || empty($nombre) || empty($nit) || empty($telefono) || empty($direccion)) {
            $response['status'] = 'error';
            $response['message'] = 'Faltan datos para actualizar el usuario.';
        } else {
            // Si se proporciona una nueva contraseña, se puede actualizar
            if (!empty($clave)) {
                $clave = password_hash($clave, PASSWORD_DEFAULT); // Asegurarse de almacenar la contraseña de forma segura
                $sql = "UPDATE usuario SET usuario=?, clave=?, nit=?, telefono=?, direccion=? WHERE idusuario=?";
                $stmt = mysqli_prepare($conn, $sql);
                mysqli_stmt_bind_param($stmt, "sssssi", $nombre, $clave, $nit, $telefono, $direccion, $usuario_id_actualizar);
            } else {
                // Si no se proporciona nueva contraseña, no se actualiza
                $sql = "UPDATE usuario SET usuario=?, nit=?, telefono=?, direccion=? WHERE idusuario=?";
                $stmt = mysqli_prepare($conn, $sql);
                mysqli_stmt_bind_param($stmt, "ssssi", $nombre, $nit, $telefono, $direccion, $usuario_id_actualizar);
            }

            if (mysqli_stmt_execute($stmt)) {
                $response['status'] = 'success';
            } else {
                $response['status'] = 'error';
                $response['message'] = 'No se pudo actualizar los datos del usuario.';
            }
            mysqli_stmt_close($stmt);
        }
    } elseif ($accion === 'cargar') {
        $sql_usuario = "SELECT idusuario, usuario, nit, telefono, direccion FROM usuario WHERE idusuario = ?";
        $stmt = mysqli_prepare($conn, $sql_usuario);
        mysqli_stmt_bind_param($stmt, "i", $usuario_id);
        mysqli_stmt_execute($stmt);
        $result_usuario = mysqli_stmt_get_result($stmt);
        
        if ($row_usuario = mysqli_fetch_assoc($result_usuario)) {
            $response['usuario'] = $row_usuario;
            $response['status'] = 'success';
        } else {
            $response['status'] = 'error';
            $response['message'] = 'No se encontró el usuario.';
        }
        mysqli_stmt_close($stmt);
    }

    mysqli_close($conn);
    echo json_encode($response);
    exit();
}

?>
