<?php
session_start();
if (!isset($_SESSION['usuario_id'])) {
    echo json_encode(['status' => 'error', 'message' => 'Debe iniciar sesión']);
    exit();
}
include '../config/conexion.php';

$accion = $_POST['accion'] ?? '';
$usuario_id = $_SESSION['usuario_id'];
$response = [];

switch ($accion) {
    case 'guardar':
        $idpersona = $_POST['idpersona'] ?? null;
        $idnomina = $_POST['idnomina'] ?? null;
        $dias_trabajados = $_POST['dias_trabajados'] ?? null;
        $valor_dia = $_POST['valor_dia'] ?? null;

        if ($idpersona && $idnomina && is_numeric($dias_trabajados) && is_numeric($valor_dia)) {
            $check = $conn->prepare("SELECT * FROM persona_nomina WHERE idpersona = ? AND idnomina = ?");
            $check->bind_param("ii", $idpersona, $idnomina);
            $check->execute();
            $exists = $check->get_result()->num_rows > 0;
            $check->close();

            if ($exists) {
                $stmt = $conn->prepare("UPDATE persona_nomina SET dias_trabajados = ?, valor_dia = ? WHERE idpersona = ? AND idnomina = ?");
                $stmt->bind_param("ddii", $dias_trabajados, $valor_dia, $idpersona, $idnomina);
                $message = "Registro actualizado correctamente.";
            } else {
                $stmt = $conn->prepare("INSERT INTO persona_nomina (idpersona, idnomina, dias_trabajados, valor_dia) VALUES (?, ?, ?, ?)");
                $stmt->bind_param("iiid", $idpersona, $idnomina, $dias_trabajados, $valor_dia);
                $message = "Registro guardado correctamente.";
            }

            if ($stmt->execute()) {
                $response = ['status' => 'success', 'message' => $message];
            } else {
                $response = ['status' => 'error', 'message' => 'Error al guardar'];
            }
            $stmt->close();
        } else {
            $response = ['status' => 'error', 'message' => 'Datos incompletos o inválidos'];
        }
        break;

    case 'listar':  // Cambié de 'cargar' a 'listar' para coincidir con el JS
        $sql = "SELECT pn.*, p.nombre AS nombre_persona, n.descripcion AS descripcion_nomina
                FROM persona_nomina pn
                JOIN persona p ON p.idpersona = pn.idpersona
                JOIN nomina n ON n.idnomina = pn.idnomina
                WHERE n.usuario_idusuario = ?
                ORDER BY p.nombre ASC";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $usuario_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $datos = [];
        while ($row = $result->fetch_assoc()) {
            $datos[] = $row;
        }
        $response = $datos;  // Devolvemos directamente el array para que JS lo reciba sin "status"
        $stmt->close();
        break;

    case 'eliminar':
        $idpersona = $_POST['idpersona'] ?? null;
        $idnomina = $_POST['idnomina'] ?? null;

        if ($idpersona && $idnomina) {
            $stmt = $conn->prepare("DELETE FROM persona_nomina WHERE idpersona = ? AND idnomina = ?");
            $stmt->bind_param("ii", $idpersona, $idnomina);
            if ($stmt->execute()) {
                $response = ['status' => 'success', 'message' => 'Registro eliminado correctamente'];
            } else {
                $response = ['status' => 'error', 'message' => 'Error al eliminar'];
            }
            $stmt->close();
        } else {
            $response = ['status' => 'error', 'message' => 'Datos inválidos'];
        }
        break;

    default:
        $response = ['status' => 'error', 'message' => 'Acción no válida'];
        break;
}

echo json_encode($response);
