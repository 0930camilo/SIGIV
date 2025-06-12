<?php
session_start();
include '../config/conexion.php';

// Verificar si el usuario ha iniciado sesión
if (!isset($_SESSION['usuario_id'])) {
    echo json_encode(['status' => 'error', 'message' => 'Usuario no autenticado.']);
    exit();
}

$usuario_id = $_SESSION['usuario_id'];

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["accion"])) {
    $accion = $_POST["accion"];
    $idnomina = $_POST["idnomina"] ?? null;
    $descripcion = $_POST["descripcion"] ?? '';
    $fecha_inicio = $_POST["fecha_inicio"] ?? null;
    $fecha_fin = $_POST["fecha_fin"] ?? null;

    $response = [];

    if ($accion === 'eliminar') {
        if (!$idnomina) {
            $response['status'] = 'error';
            $response['message'] = 'ID de nómina no proporcionado.';
        } else {
            // Opción: marcar como eliminada (estado), si agregas un campo `estado`, por ahora eliminamos directamente
            $sql = "DELETE FROM nomina WHERE idnomina = ? AND usuario_idusuario = ?";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "ii", $idnomina, $usuario_id);

            if (mysqli_stmt_execute($stmt)) {
                $response['status'] = 'success';
                $response['message'] = 'Nómina eliminada correctamente.';
            } else {
                $response['status'] = 'error';
                $response['message'] = 'No se pudo eliminar la nómina.';
            }
            mysqli_stmt_close($stmt);
        }

    } elseif ($accion === 'guardar') {
        if (empty($idnomina)) {
            // Insertar nueva nómina
            $sql = "INSERT INTO nomina (descripcion, fecha_inicio, fecha_fin, usuario_idusuario)
                    VALUES (?, ?, ?, ?)";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "sssi", $descripcion, $fecha_inicio, $fecha_fin, $usuario_id);
        } else {
            // Actualizar nómina existente
            $sql = "UPDATE nomina SET descripcion=?, fecha_inicio=?, fecha_fin=?
                    WHERE idnomina=? AND usuario_idusuario=?";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "sssii", $descripcion, $fecha_inicio, $fecha_fin, $idnomina, $usuario_id);
        }

        if (mysqli_stmt_execute($stmt)) {
            $response['status'] = 'success';
        } else {
            $response['status'] = 'error';
            $response['message'] = 'No se pudieron guardar los datos de la nómina.';
        }
        mysqli_stmt_close($stmt);

    } elseif ($accion === 'cargar') {
        $descripcion = $_POST['descripcion'] ?? '';
        $descripcion = "%$descripcion%";

     $sql = "SELECT 
            n.idnomina, 
            n.descripcion, 
            n.fecha_inicio, 
            n.fecha_fin, 
            IFNULL(SUM(pn.salario), 0) AS total_pago, 
            u.usuario AS usuario
        FROM nomina n
        LEFT JOIN usuario u ON n.usuario_idusuario = u.idusuario
        LEFT JOIN persona_nomina pn ON pn.idnomina = n.idnomina
        WHERE n.usuario_idusuario = ?
          AND n.descripcion LIKE ?
        GROUP BY n.idnomina
        ORDER BY n.fecha_inicio DESC";


        $stmt = mysqli_prepare($conn, $sql);
        mysqli_stmt_bind_param($stmt, "is", $usuario_id, $descripcion);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);

        $nominas = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $nominas[] = $row;
        }

        $response['nominas'] = $nominas;
        $response['status'] = 'success';
        mysqli_stmt_close($stmt);
    }

    mysqli_close($conn);
    echo json_encode($response);
    exit();
}
?>
