<?php
session_start();

// Verificar si el usuario está autenticado y tiene ID
if (!isset($_SESSION['usuario']) || !isset($_SESSION['usuario_id'])) {
    echo "<script>alert('Sesión inválida. Por favor, inicie sesión.'); window.location.href='../login.php';</script>";
    exit();
}

$usuario_id = $_SESSION['usuario_id']; // Guardar el ID del usuario

include '../config/conexion.php';

// Obtener categorías activas del usuario
$sql_categoria = "SELECT idcategoria, nombre 
                  FROM categoria 
                  WHERE usuario_idusuario = ? AND estado = 'activo'"; 
$stmt = mysqli_prepare($conn, $sql_categoria);
mysqli_stmt_bind_param($stmt, "i", $usuario_id);
mysqli_stmt_execute($stmt);
$result_categoria = mysqli_stmt_get_result($stmt);

$categorias = mysqli_fetch_all($result_categoria, MYSQLI_ASSOC);
mysqli_stmt_close($stmt);

// Obtener proveedores activos del usuario
$sql_proveedor = "SELECT idproveedor, nombre 
                  FROM proveedor 
                  WHERE usuario_idusuario = ? AND estado = 'activo'";
$stmt = mysqli_prepare($conn, $sql_proveedor);
mysqli_stmt_bind_param($stmt, "i", $usuario_id);
mysqli_stmt_execute($stmt);
$result_proveedor = mysqli_stmt_get_result($stmt);

$proveedores = mysqli_fetch_all($result_proveedor, MYSQLI_ASSOC);
mysqli_stmt_close($stmt);
mysqli_close($conn);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Gestión de Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        .container {
            width: 90%;
            margin-left: 11%;
        }

        /* Limita el área visible y agrega scroll */
        .scroll-area {
            max-height: 400px;
            overflow-y: auto;
        }

        /* Fijar encabezado */
        .fixed-header-table thead th {
            position: sticky;
            top: 0;
            z-index: 2;
            background-color: #212529; /* fondo oscuro como Bootstrap */
            color: #fff;
        }
    </style>
</head>

<body>
<div class="container py-0">
    <div class="card mb-1">
        <div class="card-header bg-primary text-white py-2">
            <h6 class="mb-0">Gestión de Producto</h6>
        </div>
        <div class="card-body small">
            <form id="formProducto" class="row g-1 align-items-end">
                <input type="hidden" id="idproducto" name="idproducto" />

                <div class="col-md-1">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" id="nombre" name="nombre" class="form-control form-control-sm" required />
                </div>

                <div class="col-md-2">
                    <label for="descripcion" class="form-label">Descripción</label>
                    <input type="text" id="descripcion" name="descripcion" class="form-control form-control-sm" />
                </div>

                <div class="col-md-1">
                    <label for="cantidad" class="form-label">Cantidad</label>
                    <input type="number" id="cantidad" name="cantidad" class="form-control form-control-sm" required />
                </div>

                <div class="col-md-2">
                    <label for="precioCompra" class="form-label">Precio de Compra</label>
                    <input type="number" id="precioCompra" name="precioCompra" step="0.01" class="form-control form-control-sm" required />
                </div>

                <div class="col-md-2">
                    <label for="precio" class="form-label">Precio de Venta</label>
                    <input type="number" id="precio" name="precio" step="0.01" class="form-control form-control-sm" required />
                </div>

                <div class="col-md-1">
                    <label for="categoria_idcategoria" class="form-label">Categoría</label>
                    <select id="categoria_idcategoria" name="categoria_idcategoria" class="form-select form-select-sm" required>
                        <option value="">Seleccionar</option>
                        <?php foreach ($categorias as $categoria): ?>
                            <option value="<?= htmlspecialchars($categoria['idcategoria']) ?>">
                                <?= htmlspecialchars($categoria['nombre']) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="proveedor_idproveedor" class="form-label">Proveedor</label>
                    <select id="proveedor_idproveedor" name="proveedor_idproveedor" class="form-select form-select-sm" required>
                        <option value="">Seleccionar</option>
                        <?php foreach ($proveedores as $proveedor): ?>
                            <option value="<?= htmlspecialchars($proveedor['idproveedor']) ?>">
                                <?= htmlspecialchars($proveedor['nombre']) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <div class="col-md-1 d-flex align-items-end">
                    <button type="submit" class="btn btn-sm btn-primary w-100">Guardar</button>
                </div>
            </form>
        </div>
    </div>

    <div class="card">
        <div class="card-header bg-dark text-white py-2">
            <h6 class="mb-0">Lista de Productos</h6>
        </div>

        <div class="card-body py-2 px-3 row g-2 align-items-end small">
            <div class="col-md-2">
                <select id="categoriaFiltro" class="form-select form-select-sm">
                    <option value="todos">Categorías</option>
                    <?php foreach ($categorias as $categoria): ?>
                        <option value="<?= htmlspecialchars($categoria['idcategoria']) ?>">
                            <?= htmlspecialchars($categoria['nombre']) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="col-md-2">
                <input type="text" id="nombreBuscar" class="form-control form-control-sm" placeholder="Nombre del Producto" />
            </div>
            <div class="col-md-1 d-grid">
                <button id="btnBuscar" class="btn btn-sm btn-primary">Buscar</button>
            </div>
        </div>

        <div class="card-body p-3 small">
            <div class="table-responsive scroll-area">
                <table id="tablaProductos" class="table table-sm table-striped table-hover align-middle w-100 fixed-header-table">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Descripción</th>
                            <th>Cantidad</th>
                            <th>Precio Compra</th>
                            <th>Precio Venta</th>
                            <th>Categoría</th>
                            <th>Proveedor</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Datos cargados por JS -->
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
$(document).ready(function() {

    // Función para cargar productos con filtro de categoría y búsqueda
    function cargarProductos(categoriaFiltro = 'todos', nombreBuscar = '') {
        $.ajax({
            url: '../controller/ProductoController.php',
            method: 'POST',
            data: {
                accion: 'cargar',
                categoriaFiltro: categoriaFiltro,
                nombreBuscar: nombreBuscar,
                timestamp: new Date().getTime()
            },
            success: function(response) {
                try {
                    const data = JSON.parse(response);
                    if (data.status === 'success') {
                        const productos = data.productos;
                        const tbody = $('#tablaProductos tbody');
                        tbody.empty();
                        productos.forEach(function(producto) {
                            tbody.append(
                                `<tr class="product">
                                    <td>${producto.idproducto}</td>
                                    <td>${producto.nombre}</td>
                                    <td>${producto.descripcion}</td>
                                    <td>${producto.cantidad}</td>
                                    <td>${producto.precioCompra}</td>
                                    <td>${producto.precio}</td>
                                    <td>${producto.categoriaNombre}</td>
                                    <td>${producto.proveedorNombre}</td>
                                    <td>
                                        <div class="d-flex gap-2">
                                            <button class="btn btn-sm btn-warning btn-editar" 
                                                    data-id="${producto.idproducto}" 
                                                    title="Actualizar">
                                                <i class="bi bi-pencil-square"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger btn-eliminar" 
                                                    data-id="${producto.idproducto}" 
                                                    title="Eliminar">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>`
                            );
                        });
                    } else {
                        alert('Error al cargar productos: ' + data.message);
                    }
                } catch(e) {
                    alert('Error al procesar la respuesta del servidor.');
                    console.error(response);
                }
            },
            error: function() {
                alert('Error en la conexión al servidor.');
            }
        });
    }

    // Carga inicial
    cargarProductos();

    // Filtrar por categoría o nombre al hacer click en Buscar
    $('#btnBuscar').on('click', function(e) {
        e.preventDefault();
        const categoria = $('#categoriaFiltro').val();
        const nombre = $('#nombreBuscar').val();
        cargarProductos(categoria, nombre);
    });

    // Filtrar también al presionar Enter en el campo de texto de búsqueda
    $('#nombreBuscar').on('keydown', function(e) {
        if (e.key === 'Enter' || e.keyCode === 13) {
            e.preventDefault();
            $('#btnBuscar').click();
        }
    });

    // Envío de formulario para agregar o actualizar producto
    $('#formProducto').on('submit', function(e) {
        e.preventDefault();

        let formData = $(this).serializeArray();
        formData.push({ name: 'accion', value: 'guardar' });
        formData.push({ name: 'usuario_idusuario', value: <?= json_encode($usuario_id) ?> });

        $.ajax({
            url: '../controller/ProductoController.php',
            method: 'POST',
            data: $.param(formData),
            success: function(response) {
                try {
                    const data = JSON.parse(response);
                    if (data.status === 'success') {
                        alert(data.message);
                        cargarProductos();
                        $('#formProducto')[0].reset();
                        $('#idproducto').val('');
                    } else {
                        alert('Error: ' + data.message);
                    }
                } catch(e) {
                    alert('Error al procesar la respuesta del servidor.');
                    console.error(response);
                }
            },
            error: function() {
                alert('Error en la conexión al servidor.');
            }
        });
    });

    // Editar producto - cargar datos al formulario
    $('#tablaProductos').on('click', '.btn-editar', function() {
        const id = $(this).data('id');

        $.ajax({
            url: '../controller/ProductoController.php',
            method: 'POST',
            data: { accion: 'obtener', idproducto: id },
            success: function(response) {
                try {
                    const data = JSON.parse(response);
                    if (data.status === 'success') {
                        const p = data.producto;
                        $('#idproducto').val(p.idproducto);
                        $('#nombre').val(p.nombre);
                        $('#descripcion').val(p.descripcion);
                        $('#cantidad').val(p.cantidad);
                        $('#precioCompra').val(p.precioCompra);
                        $('#precio').val(p.precio);
                        $('#categoria_idcategoria').val(p.categoria_idcategoria);
                        $('#proveedor_idproveedor').val(p.proveedor_idproveedor);
                    } else {
                        alert('No se encontró el producto.');
                    }
                } catch(e) {
                    alert('Error al procesar la respuesta del servidor.');
                    console.error(response);
                }
            }
        });
    });

    // Eliminar producto
    $('#tablaProductos').on('click', '.btn-eliminar', function() {
        if (!confirm('¿Está seguro de eliminar este producto?')) return;

        const id = $(this).data('id');

        $.ajax({
            url: '../controller/ProductoController.php',
            method: 'POST',
            data: { accion: 'eliminar', idproducto: id },
            success: function(response) {
                try {
                    const data = JSON.parse(response);
                    if (data.status === 'success') {
                        alert(data.message);
                        cargarProductos();
                    } else {
                        alert('Error al eliminar: ' + data.message);
                    }
                } catch(e) {
                    alert('Error al procesar la respuesta del servidor.');
                    console.error(response);
                }
            }
        });
    });
});
</script>
</body>
</html>
