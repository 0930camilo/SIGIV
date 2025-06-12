<?php
session_start();

// Verificar si el usuario está autenticado
if (!isset($_SESSION['usuario'])) {
    echo "<script>alert('Por favor, inicie sesión.'); window.location.href='../login.php';</script>";
    exit();
}

if (!isset($_SESSION['usuario_id'])) {
    echo "<script>alert('No se pudo obtener el ID de usuario.'); window.location.href='../login.php';</script>";
    exit();
}

$usuario_id = $_SESSION['usuario_id'];

include '../config/conexion.php';

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
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="../css/categorias.css">
    <title>Gestión de Categorías</title>

    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   
</head>
<body>
    <div class="container py-0">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-md-11 col-sm-12 offset-lg-1">
                <div class="row g-4">
                    <!-- Formulario -->
                    <div class="col-lg-4">
                        <div class="form-fixed">
                            <h1 class="h3 mb-3 text-center">Gestión Categoría</h1>
                            <form id="formCategoria" class="card p-3 shadow-sm">
                                <input type="hidden" id="idcategoria" name="idcategoria" />
                                <input type="hidden" id="usuario_idusuario" name="usuario_idusuario" value="<?php echo htmlspecialchars($usuario_id); ?>" />
                                
                                <div class="mb-3">
                                    <label for="nombre" class="form-label">Nombre de la Categoría:</label>
                                    <input type="text" id="nombre" name="nombre" class="form-control" required />
                                </div>
                                <button type="submit" class="btn btn-primary w-100">Guardar</button>
                            </form>
                        </div>
                    </div>

                    <!-- Lista de Categorías -->
                    <div class="col-lg-8">
                        <h1 class="h3 mb-3 text-center">Categorías</h1>

                        <div class="input-group mb-2">
                      <input type="text" id="buscarNombre" name="buscarNombre" class="form-control form-control-sm" placeholder="Nombre de Categoría" aria-label="Buscar categoría" />

                            <button id="buscarCategoriaBtn" class="btn btn-outline-secondary" type="button">Buscar</button>
                        </div>

                        <div id="categoriasTable" class="table-responsive shadow-sm rounded scroll-area">
                            <!-- Tabla cargada dinámicamente -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<script>
$(document).ready(function() {
    cargarCategorias();

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

    $(document).on('click', '.btn-eliminar', function(e) {
        e.preventDefault();
        const idcategoria = $(this).data('id');
        if (!confirm('¿Está seguro de eliminar esta categoría?')) return;
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

    $(document).on('click', '.btn-editar', function() {
        const row = $(this).closest('tr');
        $('#idcategoria').val(row.find('.categoria-id').text());
        $('#nombre').val(row.find('.categoria-nombre').text());
    });

    function cargarCategorias(nombre = '') {
        $.ajax({
            url: '../controller/CategoriaController.php',
            method: 'POST',
            data: { accion: 'cargar', nombre },
            success: function(response) {
                try {
                    const data = JSON.parse(response);
                    if (data.status === 'success') {
                        const categorias = data.categorias;
                        let html = `<table class="table table-striped table-hover">
                            <thead class="table-dark">
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
                                    <div class="btn-group" role="group">
                                       <button class="btn btn-sm btn-warning btn-editar" title="Actualizar">
                                          <i class="bi bi-pencil-square"></i>
                                  </button>
                                  <button class="btn btn-sm btn-danger btn-eliminar" data-id="${categoria.idcategoria}" title="Eliminar">
                                  <i class="bi bi-trash"></i>
                                </button>

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

    $('#buscarCategoriaBtn').on('click', function() {
        const nombre = $('#buscarNombre').val();
        cargarCategorias(nombre);
    });

    $('#buscarNombre').on('keypress', function(e) {
        if (e.which == 13) {
            const nombre = $(this).val();
            cargarCategorias(nombre);
        }
    });
});
</script>

<!-- Bootstrap JS Bundle (Popper + Bootstrap JS) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
