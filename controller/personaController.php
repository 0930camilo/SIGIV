<?php
session_start();
header('Content-Type: application/json');

if (!isset($_SESSION['usuario_id'])) {
    echo json_encode(['status' => 'error', 'message' => 'Por favor, inicie sesión.']);
    exit();
}

include '../config/conexion.php';
$usuario_id = $_SESSION['usuario_id'];

$response = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $accion = $_POST['accion'] ?? '';
    $idpersona = $_POST['idpersona'] ?? null;
    $nombre = trim($_POST['nombre'] ?? '');
    $correo = trim($_POST['correo'] ?? '');
    $telefono = trim($_POST['telefono'] ?? '');
    $direccion = trim($_POST['direccion'] ?? '');
    $fecha_nac = $_POST['fecha_nacimiento'] ?? null;
    $fecha_ing = $_POST['fecha_ingreso'] ?? null;

    switch ($accion) {
      case 'guardar':
    if (empty($nombre) || empty($correo)) {
        $response = ['status' => 'error', 'message' => 'Nombre y correo son obligatorios.'];
        break;
    }

    if (!filter_var($correo, FILTER_VALIDATE_EMAIL)) {
        $response = ['status' => 'error', 'message' => 'Correo no válido.'];
        break;
    }

    // Verificar si es insert o update (basado en si existe ese ID en la BD)
    if (!empty($idpersona)) {
        // Verificar si el ID existe
        $verificar_sql = "SELECT idpersona FROM persona WHERE idpersona = ? AND usuario_idusuario = ?";
        $verificar_stmt = mysqli_prepare($conn, $verificar_sql);
        mysqli_stmt_bind_param($verificar_stmt, "ii", $idpersona, $usuario_id);
        mysqli_stmt_execute($verificar_stmt);
        mysqli_stmt_store_result($verificar_stmt);

        if (mysqli_stmt_num_rows($verificar_stmt) > 0) {
            // El ID existe → hacer update
            $sql = "UPDATE persona SET 
                    nombre=?, correo=?, telefono=?, direccion=?, fecha_nacimiento=?, fecha_ingreso=? 
                    WHERE idpersona=? AND usuario_idusuario=?";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "ssssssii",
                $nombre, $correo, $telefono, $direccion, $fecha_nac, $fecha_ing, $idpersona, $usuario_id
            );
            $msg = 'Persona actualizada correctamente.';
        } else {
            // El ID no existe → hacer insert con ID manual
            $sql = "INSERT INTO persona 
                    (idpersona, nombre, correo, telefono, direccion, fecha_nacimiento, fecha_ingreso, usuario_idusuario, estado)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'activo')";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "issssssi",
                $idpersona, $nombre, $correo, $telefono, $direccion, $fecha_nac, $fecha_ing, $usuario_id
            );
            $msg = 'Persona agregada con ID manual.';
        }
        mysqli_stmt_close($verificar_stmt);
    } else {
        // Insert automático sin ID
        $sql = "INSERT INTO persona 
                (nombre, correo, telefono, direccion, fecha_nacimiento, fecha_ingreso, usuario_idusuario, estado)
                VALUES (?, ?, ?, ?, ?, ?, ?, 'activo')";
        $stmt = mysqli_prepare($conn, $sql);
        mysqli_stmt_bind_param($stmt, "ssssssi",
            $nombre, $correo, $telefono, $direccion, $fecha_nac, $fecha_ing, $usuario_id
        );
        $msg = 'Persona agregada con ID automático.';
    }

    if (mysqli_stmt_execute($stmt)) {
        $response = ['status' => 'success', 'message' => $msg];
    } else {
        $response = ['status' => 'error', 'message' => 'Error al guardar en la base de datos.'];
    }

    mysqli_stmt_close($stmt);
    break;


        case 'cargar':
            $sql = "SELECT idpersona, nombre, correo, telefono, direccion, fecha_nacimiento, fecha_ingreso
                    FROM persona
                    WHERE estado='activo' AND usuario_idusuario=?
                    ORDER BY idpersona DESC";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "i", $usuario_id);
            mysqli_stmt_execute($stmt);
            $res = mysqli_stmt_get_result($stmt);
            $lista = mysqli_fetch_all($res, MYSQLI_ASSOC);
            mysqli_stmt_close($stmt);
            $response = ['status' => 'success', 'personas' => $lista];
            break;

        case 'buscar':
            $nb = "%" . trim($_POST['nombreBuscar'] ?? '') . "%";
            $sql = "SELECT idpersona, nombre, correo, telefono, direccion, fecha_nacimiento, fecha_ingreso
                    FROM persona
                    WHERE estado='activo' AND usuario_idusuario=? AND nombre LIKE ?
                    ORDER BY idpersona DESC";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "is", $usuario_id, $nb);
            mysqli_stmt_execute($stmt);
            $res = mysqli_stmt_get_result($stmt);
            $lista = mysqli_fetch_all($res, MYSQLI_ASSOC);
            mysqli_stmt_close($stmt);
            $response = ['status' => 'success', 'personas' => $lista];
            break;

        case 'eliminar':
            if (empty($idpersona)) {
                $response = ['status' => 'error', 'message' => 'ID de persona no proporcionado.'];
                break;
            }
            $sql = "UPDATE persona SET estado='inactivo' 
                    WHERE idpersona=? AND usuario_idusuario=?";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "ii", $idpersona, $usuario_id);
            if (mysqli_stmt_execute($stmt)) {
                $response = ['status' => 'success', 'message' => 'Persona eliminada correctamente.'];
            } else {
                $response = ['status' => 'error', 'message' => 'Error al eliminar la persona.'];
            }
            mysqli_stmt_close($stmt);
            break;

        default:
            $response = ['status' => 'error', 'message' => 'Acción no válida.'];
    }
}

mysqli_close($conn);
echo json_encode($response);
