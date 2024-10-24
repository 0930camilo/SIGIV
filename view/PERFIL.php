<?php
session_start();
include '../config/conexion.php'; // Incluir el archivo de conexión

// Verificar si el usuario está autenticado
if (!isset($_SESSION['usuario_id'])) {
    echo "<script>alert('Por favor, inicie sesión.'); window.location.href='../login.php';</script>";
    exit();
}

// Obtener el ID del usuario desde la sesión
$usuario_id = $_SESSION['usuario_id'];

// Obtener los datos del usuario que inició sesión
$sql = "SELECT idusuario, usuario, nit, telefono, direccion FROM usuario WHERE idusuario = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $usuario_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result && $result->num_rows > 0) {
    $row = $result->fetch_assoc(); // Obtener el registro
} else {
    echo "<script>alert('No se encontró el usuario.'); window.location.href='dashboard.php';</script>";
    exit();
}
?><!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Actualizar Usuario</title>
    <link rel="stylesheet" href="../css/perfil.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<div class="perfil">
<div class="info">
<h2>Datos del Usuario</h2>
<div class="usuario-info">
    <p><strong>Usuario:</strong> <?php echo htmlspecialchars($row['usuario']); ?></p>
    <p><strong>NIT:</strong> <?php echo htmlspecialchars($row['nit']); ?></p>
    <p><strong>Teléfono:</strong> <?php echo htmlspecialchars($row['telefono']); ?></p>
    <p><strong>Dirección:</strong> <?php echo htmlspecialchars($row['direccion']); ?></p>
</div>
</div>

<div class="container">
   
    <h1>Actualizar Datos</h1>
    <form id="formActualizarUsuario">
        <input type="hidden" id="usuario_id" name="usuario_id" value="<?php echo htmlspecialchars($row['idusuario']); ?>"> <!-- Asignar el id del usuario -->
        <label for="usuario">Nombre de Usuario:</label>
        <input type="text" id="usuario" name="usuario" required value="<?php echo htmlspecialchars($row['usuario']); ?>"> <!-- Asignar el nombre de usuario -->
        <label for="clave">Contraseña:</label>
        <input type="password" id="clave" name="clave" placeholder="Ingrese nueva contraseña (opcional)"> <!-- Campo para nueva contraseña -->
        <label for="nit">NIT:</label>
        <input type="number" id="nit" name="nit" required value="<?php echo htmlspecialchars($row['nit']); ?>" step="any"> <!-- Asignar el NIT -->
        <label for="telefono">Teléfono:</label>
        <input type="number" id="telefono" name="telefono" required value="<?php echo htmlspecialchars($row['telefono']); ?>" step="any"> <!-- Asignar el teléfono -->
        <label for="direccion">Dirección:</label>
        <input type="text" id="direccion" name="direccion" required value="<?php echo htmlspecialchars($row['direccion']); ?>"> <!-- Asignar la dirección -->
        <button type="submit">Actualizar</button>
    </form>

 </div>
</div>

<script>
    $(document).ready(function() {
        // Manejo del formulario de actualización
        $('#formActualizarUsuario').on('submit', function(e) {
            e.preventDefault();
            $.ajax({
                url: '../controller/perfilController.php',
                method: 'POST',
                data: $(this).serialize() + '&accion=actualizar',
                success: function(response) {
                    try {
                        const data = JSON.parse(response);
                        if (data.status === 'success') {
                            alert('Datos de usuario actualizados con éxito.');

                            // SOLUCIÓN 1: Recargar la página para ver los cambios
                            // location.reload(); 

                            // SOLUCIÓN 2: Actualizar los campos dinámicamente sin recargar
                            $('.usuario-info p strong:contains("Usuario:")').parent().html('<strong>Usuario:</strong> ' + $('#usuario').val());
                            $('.usuario-info p strong:contains("NIT:")').parent().html('<strong>NIT:</strong> ' + $('#nit').val());
                            $('.usuario-info p strong:contains("Teléfono:")').parent().html('<strong>Teléfono:</strong> ' + $('#telefono').val());
                            $('.usuario-info p strong:contains("Dirección:")').parent().html('<strong>Dirección:</strong> ' + $('#direccion').val());

                            // Limpiar el campo de la contraseña
                            $('#clave').val('');

                        } else {
                            alert('Error: ' + (data.message || 'No se pudo actualizar el usuario.'));
                        }
                    } catch (error) {
                        console.error('Respuesta no válida del servidor: ' + response);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error en AJAX: ' + error);
                }
            });
        });
    });
</script>
</body>
</html>
