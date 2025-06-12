<?php
session_start();
include '../config/conexion.php';

if (!isset($_SESSION['usuario_id'])) {
    echo "<script>alert('Por favor, inicie sesión.'); window.location.href='../login.php';</script>";
    exit();
}

$usuario_id = $_SESSION['usuario_id'];

$sql = "SELECT idusuario, usuario, nit, telefono, direccion FROM usuario WHERE idusuario = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $usuario_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result && $result->num_rows > 0) {
    $row = $result->fetch_assoc();
} else {
    echo "<script>alert('No se encontró el usuario.'); window.location.href='dashboard.php';</script>";
    exit();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="icon" href="../img/perfil.png" type="image/png" />
    <title>Perfil</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- CSS personalizado -->
    <link rel="stylesheet" href="../css/perfil.css">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<div class="perfil">
    <div class="row">
        <!-- Información del usuario -->
        <div class="col-md-6 col-12 mb-4">
            <h2>Datos del Usuario</h2>
            <div class="usuario-info">
                <p><strong>Usuario:</strong> <?php echo htmlspecialchars($row['usuario']); ?></p>
                <p><strong>NIT:</strong> <?php echo htmlspecialchars($row['nit']); ?></p>
                <p><strong>Teléfono:</strong> <?php echo htmlspecialchars($row['telefono']); ?></p>
                <p><strong>Dirección:</strong> <?php echo htmlspecialchars($row['direccion']); ?></p>
            </div>
        </div>

        <!-- Formulario de actualización -->
        <div class="col-md-6 col-12">
            <h2>Actualizar Datos</h2>
            <form id="formActualizarUsuario" class="needs-validation" novalidate>
                <input type="hidden" name="usuario_id" value="<?php echo htmlspecialchars($row['idusuario']); ?>">

                <div class="mb-3">
                    <label for="usuario" class="form-label">Nombre de Usuario:</label>
                    <input type="text" class="form-control" id="usuario" name="usuario" required value="<?php echo htmlspecialchars($row['usuario']); ?>">
                    <div class="invalid-feedback">Por favor ingrese un nombre de usuario.</div>
                </div>

                <div class="mb-3">
                    <label for="clave" class="form-label">Contraseña:</label>
                    <input type="password" class="form-control" id="clave" name="clave" placeholder="Ingrese nueva contraseña (opcional)">
                </div>

                <div class="mb-3">
                    <label for="nit" class="form-label">NIT:</label>
                    <input type="number" class="form-control" id="nit" name="nit" required value="<?php echo htmlspecialchars($row['nit']); ?>">
                    <div class="invalid-feedback">Por favor ingrese el NIT.</div>
                </div>

                <div class="mb-3">
                    <label for="telefono" class="form-label">Teléfono:</label>
                    <input type="number" class="form-control" id="telefono" name="telefono" required value="<?php echo htmlspecialchars($row['telefono']); ?>">
                    <div class="invalid-feedback">Por favor ingrese el teléfono.</div>
                </div>

                <div class="mb-3">
                    <label for="direccion" class="form-label">Dirección:</label>
                    <input type="text" class="form-control" id="direccion" name="direccion" required value="<?php echo htmlspecialchars($row['direccion']); ?>">
                    <div class="invalid-feedback">Por favor ingrese la dirección.</div>
                </div>

                <button type="submit" class="btn btn-primary">Actualizar</button>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
(() => {
    'use strict'
    const forms = document.querySelectorAll('.needs-validation')
    Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
            if (!form.checkValidity()) {
                event.preventDefault()
                event.stopPropagation()
            } else {
                event.preventDefault();
                $.ajax({
                    url: '../controller/perfilController.php',
                    method: 'POST',
                    data: $(form).serialize() + '&accion=actualizar',
                    success: function(response) {
                        try {
                            const data = JSON.parse(response);
                            if (data.status === 'success') {
                                alert('Datos de usuario actualizados con éxito.');
                                $('.usuario-info p:contains("Usuario:")').html('<strong>Usuario:</strong> ' + $('#usuario').val());
                                $('.usuario-info p:contains("NIT:")').html('<strong>NIT:</strong> ' + $('#nit').val());
                                $('.usuario-info p:contains("Teléfono:")').html('<strong>Teléfono:</strong> ' + $('#telefono').val());
                                $('.usuario-info p:contains("Dirección:")').html('<strong>Dirección:</strong> ' + $('#direccion').val());
                                $('#clave').val('');
                            } else {
                                alert('Error: ' + (data.message || 'No se pudo actualizar el usuario.'));
                            }
                        } catch (error) {
                            console.error('Respuesta no válida del servidor: ' + response);
                            alert('Error inesperado. Consulte con el administrador.');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Error en AJAX: ' + error);
                        alert('Error en la comunicación con el servidor.');
                    }
                });
            }
            form.classList.add('was-validated')
        }, false)
    })
})();
</script>

</body>
</html>
