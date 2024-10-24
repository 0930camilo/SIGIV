<?php
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Verificar si el usuario está autenticado
if (!isset($_SESSION['usuario'])) {
    header("Location: login.php");
    exit();
}

include '../config/conexion.php';
include '../controller/devolucionController.php';
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Devolución</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container mt-5">
        <h2>Registrar Devolución</h2>
        <form id="form-devolucion">
            <div class="mb-3">
                <label for="venta_id" class="form-label">ID de Venta</label>
                <input type="number" class="form-control" id="venta_id" required>
            </div>
            <button type="button" class="btn btn-primary" id="btn-cargar-productos">Cargar Productos</button>
        </form>

        <div id="productos-container" class="mt-4" style="display: none;">
            <h4>Productos de la Venta</h4>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Cantidad</th>
                        <th>Precio</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody id="productos-lista"></tbody>
            </table>
        </div>

        <div id="formulario-devolucion" class="mt-4" style="display: none;">
            <h4>Registrar Devolución</h4>
            <form id="form-registro-devolucion">
                <input type="hidden" id="producto_id" name="producto_id">
                <div class="mb-3">
                    <label for="cantidad" class="form-label">Cantidad a Devolver</label>
                    <input type="number" class="form-control" id="cantidad" name="cantidad" required>
                </div>
                <div class="mb-3">
                    <label for="motivo" class="form-label">Motivo de la Devolución</label>
                    <textarea class="form-control" id="motivo" name="motivo" rows="3"></textarea>
                </div>
                <button type="submit" class="btn btn-success">Registrar Devolución</button>
            </form>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // Cargar productos de la venta
            $('#btn-cargar-productos').click(function() {
                const ventaId = $('#venta_id').val();
                if (!ventaId) {
                    alert("Por favor, ingrese un ID de venta.");
                    return;
                }

                $.post('../controller/devolucionController.php', { 
                    accion: 'cargarProductosDeVenta', 
                    venta_id: ventaId 
                }, function(response) {
                    const data = JSON.parse(response);
                    if (data.success) {
                        $('#productos-lista').empty();
                        data.productos.forEach(producto => {
                            $('#productos-lista').append(`
                                <tr>
                                    <td>${producto.nombre}</td>
                                    <td>${producto.cantidad}</td>
                                    <td>${producto.precio}</td>
                                    <td>
                                        <button class="btn btn-info btn-devolver" data-id="${producto.producto_idproducto}" data-nombre="${producto.nombre}" data-cantidad="${producto.cantidad}">Devolver</button>
                                    </td>
                                </tr>
                            `);
                        });
                        $('#productos-container').show();
                    } else {
                        alert(data.error);
                    }
                });
            });

            // Mostrar formulario de devolución
            $(document).on('click', '.btn-devolver', function() {
                const productoId = $(this).data('id');
                const productoNombre = $(this).data('nombre');
                const cantidadDisponible = $(this).data('cantidad');

                $('#producto_id').val(productoId);
                $('#cantidad').attr('max', cantidadDisponible).val(''); // Limitar la cantidad a devolver y limpiar el campo
                $('#formulario-devolucion').show();
                $('#formulario-devolucion').find('h4').text(`Registrar Devolución para ${productoNombre}`);
            });

            // Registrar la devolución
            $('#form-registro-devolucion').submit(function(event) {
                event.preventDefault();
                const data = $(this).serialize();

                $.post('../controller/devolucionController.php', {
                    registrar_devolucion: true,
                    venta_id: $('#venta_id').val(),
                    ...data
                }, function(response) {
                    const data = JSON.parse(response);
                    if (data.success) {
                        alert(data.message);
                        location.reload(); // Recargar la página para actualizar la información
                    } else {
                        alert(data.error);
                    }
                });
            });
        });
    </script>
</body>
</html>
