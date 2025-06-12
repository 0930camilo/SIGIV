<?php
session_start();

if (!isset($_SESSION['carrito']) || empty($_SESSION['carrito'])) {
    echo "<div class='alert alert-warning'>El carrito está vacío.</div>";
    exit();
}

include '../controller/ventasController.php';

// Total de la compra
$totalCompra = array_sum(array_column($_SESSION['carrito'], 'subtotal'));
$cambio = 0;

// Manejo del monto pagado para el carrito
if (isset($_POST['monto_pagado'])) {
    $montoPagado = floatval(str_replace(',', '', $_POST['monto_pagado'])); // Eliminar comas
    $cambio = $montoPagado - $totalCompra;
}

// Manejo de la venta
if (isset($_POST['registrar_venta'])) {
    $nombreCliente = trim($_POST['nombre_cliente']);
    $telefonoCliente = trim($_POST['telefono_cliente']);

    // Validar datos del cliente
    if (empty($nombreCliente) || empty($telefonoCliente)) {
        echo json_encode(['error' => 'El nombre y el teléfono son obligatorios.']);
        exit();
    }

    // Aquí puedes agregar la lógica para registrar la venta
}
?>

<style>
.sticky-header th {
    position: sticky;
    top: 0;
    background-color: #343a40; /* Color fondo tabla oscura */
    color: white;
    z-index: 1;
}
</style>

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<div>
    <form method="post" id="registrar-venta-form" class="row g-3">
        <input type="hidden" name="registrar_venta" value="1">

        <div class="col-md-4">
            <label for="nombre_cliente" class="form-label">Nombre</label>
            <input type="text" id="nombre_cliente" name="nombre_cliente" class="form-control" required>
        </div>

        <div class="col-md-4">
            <label for="telefono_cliente" class="form-label">Teléfono</label>
            <input type="tel" id="telefono_cliente" name="telefono_cliente" class="form-control" required>
        </div>

        <div class="col-md-4">
            <label for="monto_pagado" class="form-label">Monto Pagado</label>
            <input type="text" name="monto_pagado" id="monto_pagado" class="form-control"
                value="<?= isset($montoPagado) ? number_format($montoPagado, 0, ',', '.') : '' ?>"
                oninput="updateCambio()">
        </div>

        <div class="col-md-6 d-flex gap-3 align-items-center mt-2">
            <p class="fs-6 mb-0">Total: <strong>$<?= number_format($totalCompra, 0, ',', '.') ?></strong></p>
            <p class="fs-6 mb-0">Cambio: <strong>$<span id="cambio"><?= number_format($cambio, 0, ',', '.') ?></span></strong></p>
        </div>

        <div class="col-auto mt-2">
            <button class="btn btn-sm btn-primary" type="submit">Registrar Venta</button>
        </div>
    </form>

    <div class="table-responsive mt-3" style="max-height: 250px; overflow-y: auto;">
        <table class="table table-bordered table-hover align-middle text-center">
            <thead class="table-dark sticky-header">
                <tr>
                    <th>ID</th>
                    <th>Producto</th>
                    <th>Descripción</th>
                    <th>Cantidad</th>
                    <th>Precio</th>
                    <th>Subtotal</th>
                    <th>Eliminar</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($_SESSION['carrito'] as $index => $item): ?>
                    <tr>
                        <td><?= htmlspecialchars($item['idproducto']) ?></td>
                        <td><?= htmlspecialchars($item['nombre']) ?></td>
                        <td><?= htmlspecialchars($item['descripcion']) ?></td>
                        <td><?= htmlspecialchars($item['cantidad']) ?></td>
                        <td>$<?= number_format($item['precio'], 0, ',', '.') ?></td>
                        <td>$<?= number_format($item['subtotal'], 0, ',', '.') ?></td>
                        <td>
                            <form class="eliminar-producto-form" method="post" action="../controller/ventasController.php">
                                <input type="hidden" name="accion" value="eliminar_producto">
                                <input type="hidden" name="index" value="<?= $index ?>">
                                <button type="submit" class="btn btn-sm btn-danger" title="Eliminar del carrito">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // Actualiza el cambio en tiempo real al ingresar monto pagado
    function updateCambio() {
        const montoPagado = parseFloat(document.getElementById('monto_pagado').value.replace(/,/g, '')) || 0;
        const totalCompra = <?= $totalCompra ?>;
        const cambio = montoPagado - totalCompra;
        document.getElementById('cambio').innerText = cambio < 0 ? 0 : cambio.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    // Manejo de submit para registrar venta vía AJAX
    $('#registrar-venta-form').on('submit', function(e) {
        e.preventDefault();

        if (confirm("¿Está seguro de que desea registrar la venta?")) {
            $.ajax({
                url: '../controller/ventasController.php',
                method: 'POST',
                data: $(this).serialize(),
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        actualizarCarrito();
                        $('#nombre_cliente').val('');
                        $('#telefono_cliente').val('');
                        alert('Venta registrada exitosamente.');
                    } else if (response.error) {
                        alert(response.error);
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error al registrar la venta:", status, error);
                    alert("Hubo un error al registrar la venta.");
                }
            });
        }
    });

    // Función para actualizar el carrito
    function actualizarCarrito() {
        $.ajax({
            url: '../controller/ventasController.php',
            method: 'POST',
            data: { accion: 'actualizar_carrito' },
            dataType: 'json',
            success: function(response) {
                $('#carrito-contenido').html(response.html);
            },
            error: function(xhr, status, error) {
                console.error("Error al actualizar el carrito:", status, error);
                alert("Hubo un error al actualizar el carrito.");
            }
        });
    }
</script>
