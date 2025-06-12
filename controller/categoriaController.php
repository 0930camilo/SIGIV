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

// Manejo de operaciones para categorías
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["accion"])) {
    $accion = $_POST["accion"];
    $idcategoria = $_POST["idcategoria"] ?? null;
    $nombre = $_POST["nombre"] ?? '';

    $response = [];

    if ($accion === 'eliminar') {
        if (!$idcategoria) {
            $response['status'] = 'error';
            $response['message'] = 'ID de categoría no proporcionado.';
        } else {
            // Cambiar el estado de la categoría a 'inactivo' en lugar de eliminarla físicamente
            $sql = "UPDATE categoria SET estado = 'inactivo' WHERE idcategoria = ?";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "i", $idcategoria);
    
            if (mysqli_stmt_execute($stmt)) {
                $response['status'] = 'success';
                $response['message'] = 'Categoría marcada como inactiva.';
            } else {
                $response['status'] = 'error';
                $response['message'] = 'No se pudo desactivar la categoría.';
            }
            mysqli_stmt_close($stmt);
        }
    
    
    } elseif ($accion === 'guardar') {
        if (empty($idcategoria)) {
            // Insertar nueva categoría
            $sql = "INSERT INTO categoria (nombre, usuario_idusuario) VALUES (?, ?)";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "si", $nombre, $usuario_id);
        } else {
            // Actualizar categoría existente
            $sql = "UPDATE categoria SET nombre=? WHERE idcategoria=?";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "si", $nombre, $idcategoria);
        }

        if (mysqli_stmt_execute($stmt)) {
            $response['status'] = 'success';
        } else {
            $response['status'] = 'error';
            $response['message'] = 'No se pudieron guardar los datos de la categoría.';
        }
        mysqli_stmt_close($stmt);
    } elseif ($accion === 'cargar') {
        $nombre = $_POST['nombre'] ?? '';
        
        // Modificar la consulta para incluir la búsqueda por nombre
        $sql_categoria = "SELECT c.idcategoria, c.nombre, u.usuario AS UsuarioNombre
        FROM categoria c
        LEFT JOIN usuario u ON c.usuario_idusuario = u.idusuario
        WHERE c.usuario_idusuario = ?
        AND c.nombre LIKE ?
        AND c.estado = 'activo'  -- Filtrar solo las categorías activas
        ORDER BY c.idcategoria DESC";


        
        $nombre = "%$nombre%";  // Agregar comodines para la búsqueda
        $stmt = mysqli_prepare($conn, $sql_categoria);
        mysqli_stmt_bind_param($stmt, "is", $usuario_id, $nombre);
        mysqli_stmt_execute($stmt);
        $result_categoria = mysqli_stmt_get_result($stmt);
    
        $categorias = [];
        while ($row_categoria = mysqli_fetch_assoc($result_categoria)) {
            $categorias[] = $row_categoria;
        }
        $response['categorias'] = $categorias;
        $response['status'] = 'success';
        mysqli_stmt_close($stmt);
    }
    
    

    mysqli_close($conn);
    echo json_encode($response);
    exit();
}
?>
