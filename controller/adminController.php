<?php
// Incluir el archivo de conexión
include '../config/conexion.php';

// Inicializar un array para almacenar los usuarios
$usuarios = [];

// Manejar la acción enviada por el formulario
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['accion'])) {
    $accion = $_POST['accion'];

    // Agregar nuevo usuario
    if ($accion === 'agregar' && isset($_POST['usuario'])) {
        $usuario = mysqli_real_escape_string($conn, $_POST['usuario']);
        $clave = mysqli_real_escape_string($conn, $_POST['clave']);
        $nit = mysqli_real_escape_string($conn, $_POST['nit']);
        $telefono = mysqli_real_escape_string($conn, $_POST['telefono']);
        $direccion = mysqli_real_escape_string($conn, $_POST['direccion']);
        $estado = mysqli_real_escape_string($conn, $_POST['estado']);

        // Encriptar la clave usando password_hash
        $clave_encriptada = password_hash($clave, PASSWORD_DEFAULT);

        $query = "INSERT INTO usuario (usuario, clave, nit, telefono, direccion, estado) 
                  VALUES ('$usuario', '$clave_encriptada', '$nit', '$telefono', '$direccion', '$estado')";
        mysqli_query($conn, $query);
        header("Location: ../view/admin.php");
        exit();

    // Actualizar usuario existente
    } elseif ($accion === 'actualizar' && isset($_POST['id_usuario'])) {
        $id_usuario = (int)$_POST['id_usuario'];
        $usuario = mysqli_real_escape_string($conn, $_POST['usuario']);
        $nueva_clave = mysqli_real_escape_string($conn, $_POST['nueva_clave']);
        $nit = mysqli_real_escape_string($conn, $_POST['nit']);
        $telefono = mysqli_real_escape_string($conn, $_POST['telefono']);
        $direccion = mysqli_real_escape_string($conn, $_POST['direccion']);
        $estado = mysqli_real_escape_string($conn, $_POST['estado']);

        // Construir la consulta de actualización
        $query = "UPDATE usuario 
                  SET usuario='$usuario', nit='$nit', telefono='$telefono', direccion='$direccion', estado='$estado'";

        // Si se ingresó una nueva clave, encriptarla
        if (!empty($nueva_clave)) {
            $nueva_clave_encriptada = password_hash($nueva_clave, PASSWORD_DEFAULT);
            $query .= ", clave='$nueva_clave_encriptada'";
        }

        $query .= " WHERE idusuario=$id_usuario";
        mysqli_query($conn, $query);
        header("Location: ../view/admin.php");
        exit();

    // Eliminar (marcar como inactivo) usuario
    } elseif ($accion === 'eliminar' && isset($_POST['id_usuario'])) {
        $id_usuario = (int)$_POST['id_usuario'];
        $query = "UPDATE usuario SET estado='Inactivo' WHERE idusuario=$id_usuario";
        mysqli_query($conn, $query);
        header("Location: ../view/admin.php");
        exit();
    }
}

// Listar usuarios
$query = "SELECT * FROM usuario";
$result = mysqli_query($conn, $query);

while ($row = mysqli_fetch_assoc($result)) {
    $usuarios[] = $row;
}
