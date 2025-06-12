<?php
include '../controller/totalController.php'; 
session_start();

// Verificar si el usuario está autenticado
if (!isset($_SESSION['Nombre'])) {
    echo "<script>alert('Por favor, inicie sesión.');";
    echo "window.location.href='../loginAdmin.php';</script>";
    exit();
}
$usuario_sesion = htmlspecialchars($_SESSION['Nombre']);

// Incluir el controlador para listar usuarios
include '../controller/adminController.php';
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="../img/admin.gif" type="image/gif">
    <title>Panel de Administrador</title>
    <link rel="stylesheet" href="../css/header.css">
    <link rel="stylesheet" href="../css/menus.css">
    <link rel="stylesheet" href="../css/admin.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <header class="header">
        <nav class="navbar navbar-expand-lg navbar-light bg-transparent">
            <div class="container1">
                <div class="container2">
                    <img class="log" src="../img/logo.jpg" alt="Logo">
                    <div>
                        <h1 class="navbar-brand fw-bold">SIGIV</h1>
                        <h1 class="navbar-brand fw-bold">Sistema de Gestión de Inventario y Ventas</h1>
                    </div>
                </div>

                <span id="fecha-actual" class="navbar-text"></span>

                <div class="bieneve">
                    <span class="navbar-text">ADMIN, <?php echo $usuario_sesion; ?></span>
                    <a class="btn btn-primary nav-btn" href="../controller/cerrar.php">
                        <img class="btn-cerrar" src="../img/cerrar-sesion.gif" alt="Cerrar Sesión">
                        Cerrar Sesión
                    </a>
                </div>
            </div>
        </nav>
    </header>

    <div class="container mt-5">
        <h2>Agregar Usuario</h2>
        <form action="../controller/adminController.php" method="POST">
            <input type="hidden" name="accion" value="agregar">
            <div class="mb-3">
                <label for="usuario" class="form-label">Usuario:</label>
                <input type="text" class="form-control" id="usuario" name="usuario" required>
            </div>
            <div class="mb-3">
                <label for="clave" class="form-label">Clave:</label>
                <input type="password" class="form-control" id="clave" name="clave" required>
            </div>
            <div class="mb-3">
                <label for="nit" class="form-label">NIT:</label>
                <input type="text" class="form-control" id="nit" name="nit">
            </div>
            <div class="mb-3">
                <label for="telefono" class="form-label">Teléfono:</label>
                <input type="text" class="form-control" id="telefono" name="telefono">
            </div>
            <div class="mb-3">
                <label for="direccion" class="form-label">Dirección:</label>
                <input type="text" class="form-control" id="direccion" name="direccion">
            </div>
            <div class="mb-3">
                <label for="estado" class="form-label">Estado:</label>
                <select class="form-select" id="estado" name="estado" required>
                    <option value="Activo">Activo</option>
                    <option value="Inactivo">Inactivo</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Agregar Usuario</button>
        </form>

        <h2 class="mt-5">Lista de Usuarios</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Usuario</th>
                    <th>NIT</th>
                    <th>Teléfono</th>
                    <th>Dirección</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php if (!empty($usuarios)): ?>
                    <?php foreach ($usuarios as $usuario): ?>
                        <tr id="usuario_<?php echo htmlspecialchars($usuario['idusuario']); ?>">
                            <td><?php echo htmlspecialchars($usuario['idusuario']); ?></td>
                            <td><?php echo htmlspecialchars($usuario['usuario']); ?></td>
                            <td><?php echo htmlspecialchars($usuario['nit']); ?></td>
                            <td><?php echo htmlspecialchars($usuario['telefono']); ?></td>
                            <td><?php echo htmlspecialchars($usuario['direccion']); ?></td>
                            <td><?php echo htmlspecialchars($usuario['estado']); ?></td>
                            <td>
                                <!-- Formulario para marcar como inactivo -->
                                <form action="../controller/adminController.php" method="POST" style="display:inline;">
                                    <input type="hidden" name="id_usuario" value="<?php echo htmlspecialchars($usuario['idusuario']); ?>">
                                    <input type="hidden" name="accion" value="eliminar">
                                    <button type="submit" class="btn btn-danger btn-sm">Marcar como Inactivo</button>
                                </form>
                                <!-- Botón para actualizar -->
                                <button class="btn btn-warning btn-sm" onclick="mostrarFormulario(<?php echo htmlspecialchars($usuario['idusuario']); ?>)">Actualizar</button>
                            </td>
                        </tr>
                        <!-- Formulario de actualización (oculto por defecto) -->
                        <tr id="formulario_actualizar_<?php echo htmlspecialchars($usuario['idusuario']); ?>" style="display:none;">
                            <td colspan="8">
                                <form action="../controller/adminController.php" method="POST">
                                    <input type="hidden" name="id_usuario" value="<?php echo htmlspecialchars($usuario['idusuario']); ?>">
                                    <input type="hidden" name="accion" value="actualizar">
                                    <input type="text" name="usuario" id="usuario_input_<?php echo htmlspecialchars($usuario['idusuario']); ?>" required>
                                    <input type="password" name="nueva_clave" placeholder="Nueva clave (opcional)">
                                    <input type="text" name="nit" id="nit_input_<?php echo htmlspecialchars($usuario['idusuario']); ?>">
                                    <input type="text" name="telefono" id="telefono_input_<?php echo htmlspecialchars($usuario['idusuario']); ?>">
                                    <input type="text" name="direccion" id="direccion_input_<?php echo htmlspecialchars($usuario['idusuario']); ?>">
                                    <select name="estado" id="estado_input_<?php echo htmlspecialchars($usuario['idusuario']); ?>" required>
                                        <option value="Activo" <?php if ($usuario['estado'] == 'Activo') echo 'selected'; ?>>Activo</option>
                                        <option value="Inactivo" <?php if ($usuario['estado'] == 'Inactivo') echo 'selected'; ?>>Inactivo</option>
                                    </select>
                                    <button type="submit" class="btn btn-success btn-sm">Actualizar</button>
                                    <button type="button" class="btn btn-secondary btn-sm" onclick="ocultarFormulario(<?php echo htmlspecialchars($usuario['idusuario']); ?>)">Cancelar</button>
                                </form>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                <?php else: ?>
                    <tr>
                        <td colspan="8" class="text-center">No hay usuarios disponibles</td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>

        <script>
            function mostrarFormulario(id) {
                var fila = document.getElementById('usuario_' + id);
                document.getElementById('usuario_input_' + id).value = fila.children[1].textContent.trim();
                document.getElementById('nit_input_' + id).value = fila.children[2].textContent.trim();
                document.getElementById('telefono_input_' + id).value = fila.children[3].textContent.trim();
                document.getElementById('direccion_input_' + id).value = fila.children[4].textContent.trim();
                document.getElementById('estado_input_' + id).value = fila.children[5].textContent.trim();
                document.getElementById('formulario_actualizar_' + id).style.display = '';
            }

            function ocultarFormulario(id) {
                document.getElementById('formulario_actualizar_' + id).style.display = 'none';
            }
        </script>
    </div>
</body>
</html>
