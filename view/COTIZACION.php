<?php
session_start();
include '../controller/cotizacionController.php';

if (!isset($_SESSION['usuario'])) {
    echo "<script>alert('Por favor, inicie sesión.'); window.location.href='../login.php';</script>";
    exit();
}

if (!isset($_SESSION['usuario_id'])) {
    echo "<script>alert('No se pudo obtener el ID de usuario.'); window.location.href='../login.php';</script>";
    exit();
}

$usuario_id = $_SESSION['usuario_id'];
$productos = listarProductos(); // Obtener productos disponibles
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Crear Cotización</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body {
            background-color: #f8f9fa;
            font-size: 0.9rem;
        }
        .container {
            margin-left: 10%;
            padding: 10px;
        }
        .card-header,
        .card-body {
            padding: 0.5rem 1rem;
            
        }
        .table td,
        .table th {
            padding: 0.3rem;
            font-size: 0.85rem;
        }
        .table-responsive {
            max-height: 360px;
            overflow-y: auto;
        }
        .table-dark {
            position: sticky;
            top: 0;
            background-color: white;
            z-index: 10;
        }
    </style>
</head>

<body>

<div style="margin-left: 10%;" class="container mt-3">
    <div class="row">
      
         <!-- Columna de carrito -->
        <div class="col-md-5 mb-2">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">Carrito de Cotización</h4>
                </div>
                <div style="height: 500px" class="card-body" id="carrito-contenido">
                    <!-- Se carga con AJAX -->
                </div>
            </div>
        </div>

        <!-- Columna productos -->
        <div class="col-md-7">
            <div class="card shadow">
                <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
                    <h4 class="mb-0">Productos Disponibles</h4>
                </div>
                <div class="card-body">
                    <div class="row mb-3">
                        <!-- Filtro Categoría -->
                        <div class="col-md-4">
                            <select id="filtro-categoria" class="form-select">
                                <option value="todos">Todas las Categorías</option>
                                <!-- Categorías cargadas con AJAX -->
                            </select>
                        </div>

                        <!-- Buscador por nombre -->
                        <div class="col-md-8">
                            <div class="input-group">
                                <input type="text" id="buscar-nombre" class="form-control" placeholder="Buscar producto por nombre" />
                                <button class="btn btn-outline-primary" id="btn-buscar" type="button">Buscar</button>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-bordered table-hover" id="productos-table">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Descripción</th>
                                    <th>Precio</th>
                                    <th>Disponibles</th>
                                    <th>Cantidad</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Productos cargados con AJAX -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    // Cargar carrito
    function cargarCarrito() {
        $.ajax({
            url: '../controller/carritoCotiza.php',
            method: 'GET',
            success: function(response) {
                $('#carrito-contenido').html(response);
            }
        });
    }

    // Buscar productos por nombre
    function buscarProductoPorNombre() {
        var nombreProducto = $('#buscar-nombre').val();
        $.ajax({
            url: '../controller/cotizacionController.php',
            method: 'POST',
            data: { accion: 'buscarPorNombre', nombre_producto: nombreProducto },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    var tableBody = $('#productos-table tbody');
                    tableBody.empty();

                    $.each(response.productos, function(index, producto) {
                        tableBody.append(`
                            <tr>
                                <td>${producto.idproducto}</td>
                                <td>${producto.nombre}</td>
                                <td>${producto.descripcion}</td>
                                <td>$${producto.precio}</td>
                                <td>${producto.cantidad}</td>
                                <td>
                                    <form class="agregar-producto-form d-flex" data-producto-id="${producto.idproducto}">
                                        <input type="hidden" name="producto_id" value="${producto.idproducto}">
                                        <input type="number" name="cantidad" class="form-control form-control-sm me-3 w-50">
                                    <button type="submit" class="btn btn-sm btn-primary" title="Agregar al carrito">
                                    <i class="bi bi-cart-plus me-1"></i> 
                                      </button>

                                 
                                    </form>
                                </td>
                            </tr>
                        `);
                    });
                }
            }
        });
    }

    // Cargar categorías
    function cargarCategorias() {
        $.ajax({
            url: '../controller/cotizacionController.php',
            method: 'POST',
            data: { accion: 'cargarCategorias' },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    const filtro = $('#filtro-categoria');
                    filtro.empty().append('<option value="todos">Todas las Categorías</option>');
                    response.categorias.forEach(c => {
                        filtro.append(`<option value="${c.idcategoria}">${c.nombre}</option>`);
                    });
                }
            }
        });
    }

    // Cargar productos según categoría seleccionada
    function cargarProductos(categoria = 'todos') {
        $.ajax({
            url: '../controller/cotizacionController.php',
            method: 'POST',
            data: { obtener_productos: true, categoria_idcategoria: categoria },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    var tableBody = $('#productos-table tbody');
                    tableBody.empty();

                    response.productos.forEach(p => {
                        tableBody.append(`
                            <tr>
                                <td>${p.idproducto}</td>
                                <td>${p.nombre}</td>
                                <td>${p.descripcion}</td>
                                <td>$${p.precio}</td>
                                <td>${p.cantidad}</td>
                                <td>


                                
                                    <form class="agregar-producto-form d-flex" data-producto-id="${p.idproducto}">
                                        <input type="hidden" name="producto_id" value="${p.idproducto}">
                                      <input type="number" name="cantidad" class="form-control form-control-sm me-3 w-50">

                                                          <button type="submit" class="btn btn-sm btn-primary" title="Agregar al carrito">
                                                           <i class="bi bi-cart-plus me-1"></i> 
                                                        </button>
                                    </form>
                                </td>
                            </tr>
                        `);
                    });
                }
            }
        });
    }

    // Eventos
    $('#btn-buscar').on('click', buscarProductoPorNombre);
    $('#buscar-nombre').keypress(function(e) {
        if (e.which === 13) buscarProductoPorNombre();
    });
    $('#filtro-categoria').on('change', function() {
        cargarProductos($(this).val());
    });

    $(document).on('submit', '.agregar-producto-form', function(e) {
        e.preventDefault();
        var form = $(this);
        $.ajax({
            url: '../controller/cotizacionController.php',
            method: 'POST',
            data: form.serialize(),
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    cargarCarrito();
                    cargarProductos($('#filtro-categoria').val());
                } else {
                    alert(response.error);
                }
            }
        });
    });

    $(document).on('submit', '.eliminar-producto-form', function(e) {
        e.preventDefault();
        var form = $(this);
        $.ajax({
            url: '../controller/cotizacionController.php',
            method: 'POST',
            data: form.serialize(),
            success: function() {
                cargarCarrito();
            },
            error: function() {
                alert('Error al eliminar producto del carrito');
            }
        });
    });

    // Inicialización
    cargarCategorias();
    cargarProductos();
    cargarCarrito();
});
</script>

</body>
</html>
