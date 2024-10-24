<?php
session_start();

// Verificar si el usuario está autenticado
if (!isset($_SESSION['usuario'])) {
    echo "<script>alert('Por favor, inicie sesión.'); window.location.href='../login.php';</script>";
    exit();
}

// Verificar si 'usuario_id' está definido en la sesión
if (!isset($_SESSION['usuario_id'])) {
    echo "<script>alert('No se pudo obtener el ID de usuario.'); window.location.href='../login.php';</script>";
    exit();
}

$usuario_id = $_SESSION['usuario_id']; // Guardar el ID del usuario en una variable

// Obtener las categorías y proveedores para el selector
include '../config/conexion.php';

// Preparar la consulta de categorías
$sql_categoria = "SELECT idcategoria, nombre FROM categoria WHERE usuario_idusuario = ?";
$stmt = mysqli_prepare($conn, $sql_categoria);
if ($stmt) {
    mysqli_stmt_bind_param($stmt, "i", $usuario_id);
    mysqli_stmt_execute($stmt);
    $result_categoria = mysqli_stmt_get_result($stmt);

    $categorias = [];
    while ($row_categoria = mysqli_fetch_assoc($result_categoria)) {
        $categorias[] = $row_categoria;
    }
    mysqli_stmt_close($stmt);
} else {
    echo "Error al preparar la consulta de categorías: " . mysqli_error($conn);
}

// Consultar proveedores
$sql_proveedor = "SELECT idproveedor, nombre FROM proveedor";
$result_proveedor = $conn->query($sql_proveedor);
if ($result_proveedor) {
    $proveedores = [];
    while ($row_proveedor = $result_proveedor->fetch_assoc()) {
        $proveedores[] = $row_proveedor;
    }
} else {
    echo "Error al consultar proveedores: " . mysqli_error($conn);
}
?>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Categorías</title>
    <link rel="stylesheet" href="../css/categoria.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h1 class="h1">Gestión Categoría</h1>
            <form id="formCategoria">
                <input type="hidden" id="idcategoria" name="idcategoria">
                <label for="nombre">Nombre de la Categoría:</label>
                <input type="text" id="nombre" name="nombre" required>
                <input type="hidden" id="usuario_idusuario" name="usuario_idusuario" value="<?php echo htmlspecialchars($usuario_id); ?>">
                <button type="submit">Guardar Categorías</button>
            </form>
            <hr>
        </div>

        <div class="list-container">
            <h1>CATEGORÍAS</h1>
            <label for="buscarNombre">Buscar Categoría:</label>
            <input type="text" id="buscarNombre" name="buscarNombre" placeholder=" Nombre de Categoria">
            <button id="buscarCategoriaBtn">Buscar</button>
            <div class="catego" id="categoriasTable">
                <!-- Tabla cargada dinámicamente -->
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // Cargar categorías al iniciar
            cargarCategorias();

            // Manejo del formulario
            $('#formCategoria').on('submit', function(e) {
                e.preventDefault();
                $.ajax({
                    url: '../controller/CategoriaController.php',
                    method: 'POST',
                    data: $(this).serialize() + '&accion=guardar',
                    success: function(response) {
                        try {
                            const data = JSON.parse(response);
                            if (data.status === 'success') {
                                alert('Categoría guardada con éxito.');
                                $('#formCategoria')[0].reset();
                                cargarCategorias();
                            } else {
                                alert('Error: ' + (data.message || 'No se pudo guardar la categoría.'));
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

            // Manejo de eliminación
            $(document).on('click', '.btn-eliminar', function(e) {
                e.preventDefault();
                const idcategoria = $(this).data('id');
                $.ajax({
                    url: '../controller/CategoriaController.php',
                    method: 'POST',
                    data: { idcategoria: idcategoria, accion: 'eliminar' },
                    success: function(response) {
                        try {
                            const data = JSON.parse(response);
                            if (data.status === 'success') {
                                alert('Categoría eliminada con éxito.');
                                cargarCategorias();
                            } else {
                                alert('Error: ' + (data.message || 'No se pudo eliminar la categoría.'));
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

            // Manejo de edición
            $(document).on('click', '.btn-editar', function() {
                const row = $(this).closest('tr');
                $('#idcategoria').val(row.find('.categoria-id').text());
                $('#nombre').val(row.find('.categoria-nombre').text());
                $('#usuario_idusuario').val(row.find('.categoria-usuario').data('id'));
            });

            // Cargar categorías
            function cargarCategorias() {
    $.ajax({
        url: '../controller/CategoriaController.php',
        method: 'POST',
        data: { accion: 'cargar' },
        success: function(response) {
            try {
                const data = JSON.parse(response);
                if (data.status === 'success') {
                    const categorias = data.categorias;
                    let html = `<table class="categoria-tabla">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>`;

                    categorias.forEach(categoria => {
                        html += `<tr>
                            <td class="categoria-id">${categoria.idcategoria}</td>
                            <td class="categoria-nombre">${categoria.nombre}</td>
                            <td>
                                <div class="button-group">
                                    <button class="btn-accion btn-editar">Actualizar</button>
                                    <button class="btn-accion btn-eliminar" data-id="${categoria.idcategoria}">Eliminar</button>
                                </div>
                            </td>
                        </tr>`;
                    });

                    html += `</tbody></table>`;
                    $('#categoriasTable').html(html);
                } else {
                    $('#categoriasTable').html('<p>No se pudieron cargar las categorías.</p>');
                }
            } catch (error) {
                console.error('Respuesta no válida del servidor: ' + response);
            }
        },
        error: function(xhr, status, error) {
            console.error('Error en AJAX: ' + error);
        }
    });
}

// Implementar la búsqueda de categorías
$('#buscarCategoriaBtn').on('click', function() {
    buscarCategorias();
});

// Implementar búsqueda al presionar la tecla "Enter"
$('#buscarNombre').on('keypress', function(e) {
    if (e.which == 13) { // Código para la tecla Enter
        buscarCategorias();
    }
});

function buscarCategorias() {
    const nombre = $('#buscarNombre').val();
    $.ajax({
        url: '../controller/CategoriaController.php',
        method: 'POST',
        data: { accion: 'cargar', nombre: nombre },  // Cambia 'buscar' a 'cargar'
        success: function(response) {
            try {
                const data = JSON.parse(response);
                if (data.status === 'success') {
                    const categorias = data.categorias;
                    let html = `<table class="categoria-tabla">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>`;

                    categorias.forEach(categoria => {
                        html += `<tr>
                            <td class="categoria-id">${categoria.idcategoria}</td>
                            <td class="categoria-nombre">${categoria.nombre}</td>
                            <td>
                                <div class="button-group">
                                    <button class="btn-accion btn-editar">Actualizar</button>
                                    <button class="btn-accion btn-eliminar" data-id="${categoria.idcategoria}">Eliminar</button>
                                </div>
                            </td>
                        </tr>`;
                    });

                    html += `</tbody></table>`;
                    $('#categoriasTable').html(html);
                } else {
                    $('#categoriasTable').html('<p>No se encontraron categorías con ese nombre.</p>');
                }
            } catch (error) {
                console.error('Respuesta no válida del servidor: ' + response);
            }
        },
        error: function(xhr, status, error) {
            console.error('Error en AJAX: ' + error);
        }
    });
}

        });
    </script>
</body>
</html>
