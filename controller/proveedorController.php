<?php
session_start();

// Verificar si el usuario está autenticado
if (!isset($_SESSION['usuario_id'])) { // Asegurarse de que 'usuario_id' esté en la sesión
    echo json_encode(['status' => 'error', 'message' => 'Por favor, inicie sesión.']);
    exit();
}

include '../config/conexion.php';

$response = [];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $accion = $_POST["accion"] ?? '';
    $usuario_id = $_SESSION['usuario_id']; // Obtener el ID del usuario desde la sesión

    // Campos comunes
    $idproveedor = $_POST["idproveedor"] ?? null;
    $nombre = $_POST["nombre"] ?? '';
    $telefono = $_POST["telefono"] ?? '';

    switch ($accion) {
        case 'guardar':
            if (empty($idproveedor)) {
                // Insertar nuevo proveedor
                $sql = "INSERT INTO proveedor (nombre, telefono, usuario_idusuario) VALUES (?, ?, ?)";
                $stmt = mysqli_prepare($conn, $sql);
                mysqli_stmt_bind_param($stmt, "ssi", $nombre, $telefono, $usuario_id); // Agregar usuario_id
            } else {
                // Actualizar proveedor existente
                $sql = "UPDATE proveedor SET nombre=?, telefono=? WHERE idproveedor=? AND usuario_idusuario=?";
                $stmt = mysqli_prepare($conn, $sql);
                mysqli_stmt_bind_param($stmt, "ssii", $nombre, $telefono, $idproveedor, $usuario_id); // Agregar usuario_id
            }

            if (mysqli_stmt_execute($stmt)) {
                $response['status'] = 'success';
                $response['message'] = empty($idproveedor) ? 'Proveedor agregado correctamente.' : 'Proveedor actualizado correctamente.';
            } else {
                $response['status'] = 'error';
                $response['message'] = 'Error al guardar el proveedor.';
            }

            mysqli_stmt_close($stmt);
            break;

        case 'cargar':
            // Consultar todos los proveedores de forma descendente para el usuario autenticado
            $sql = "SELECT idproveedor, nombre, telefono 
                    FROM proveedor 
                    WHERE estado = 'activo' 
                    AND usuario_idusuario = ?  -- Filtrar solo los proveedores activos del usuario
                    ORDER BY idproveedor DESC";

            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "i", $usuario_id); // Pasar usuario_id a la consulta
            mysqli_stmt_execute($stmt);
            $result = mysqli_stmt_get_result($stmt);

            $proveedores = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $proveedores[] = $row;
            }

            $response['status'] = 'success';
            $response['proveedores'] = $proveedores;

            mysqli_stmt_close($stmt);
            break;

        case 'buscar':
            $nombreBuscar = $_POST["nombreBuscar"] ?? '';

            // Consultar proveedores cuyo nombre coincida parcialmente con el valor buscado
            $sql = "SELECT idproveedor, nombre, telefono 
                    FROM proveedor 
                    WHERE nombre LIKE ? 
                    AND estado = 'activo'  
                    AND usuario_idusuario = ?  -- Filtrar solo los proveedores activos del usuario
                    ORDER BY idproveedor DESC";

            $stmt = mysqli_prepare($conn, $sql);
            $nombreBuscar = "%{$nombreBuscar}%"; // Agregar comodines para la búsqueda
            mysqli_stmt_bind_param($stmt, "si", $nombreBuscar, $usuario_id); // Pasar nombreBuscar y usuario_id
            mysqli_stmt_execute($stmt);
            $result = mysqli_stmt_get_result($stmt);

            $proveedores = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $proveedores[] = $row;
            }

            $response['status'] = 'success';
            $response['proveedores'] = $proveedores;

            mysqli_stmt_close($stmt);
            break;

            case 'eliminar':
                if (!empty($idproveedor)) {
                    // Actualizar el estado del proveedor a 'inactivo' en lugar de eliminarlo físicamente
                    $sql = "UPDATE proveedor SET estado = 'inactivo' WHERE idproveedor = ?";
                    $stmt = mysqli_prepare($conn, $sql);
                    mysqli_stmt_bind_param($stmt, "i", $idproveedor);
                    
                    if (mysqli_stmt_execute($stmt)) {
                        $response['status'] = 'success';
                        $response['message'] = 'Proveedor marcado como inactivo exitosamente.';
                    } else {
                        $response['status'] = 'error';
                        $response['message'] = 'Error al marcar el proveedor como inactivo.';
                    }
                    
                    mysqli_stmt_close($stmt);
                } else {
                    $response['status'] = 'error';
                    $response['message'] = 'ID de proveedor no proporcionado.';
                }
                break;

        // Otros casos según la lógica que estés implementando
    }

    echo json_encode($response);
    mysqli_close($conn);
    exit();
}
?>
