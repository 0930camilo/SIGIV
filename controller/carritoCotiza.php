<?php
session_start();

if (!isset($_SESSION['carritoCotiza']) || empty($_SESSION['carritoCotiza'])) {
    echo "<div class='alert alert-warning'>El carrito está vacío.</div>";
    exit();
}

include '../controller/cotizacionController.php';

// Total de la compra
$totalCompra = array_sum(array_column($_SESSION['carritoCotiza'], 'subtotal'));

// Manejo de la cotizacion
if (isset($_POST['registrar_cotizacion'])) {
    $nombreCliente = trim($_POST['nombre_cliente']);
    $telefonoCliente = trim($_POST['telefono_cliente']);

    // Validar datos del cliente
    if (empty($nombreCliente) || empty($telefonoCliente)) {
        echo json_encode(['error' => 'El nombre y el teléfono son obligatorios.']);
        exit();
    }

    // Aquí puedes agregar la lógica para registrar la cotizacion
}
?>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<style>
.sticky-header th {
    position: sticky;
    top: 0;
    background-color: #f8f9fa; /* color de fondo para encabezado */
    color: #212529;
    z-index: 1;
}
</style>

<div class="container py-3">

    <!-- Formulario para cliente -->
    <form method="post" id="registrar-cotizacion-form" class="row g-3 align-items-end">
        <input type="hidden" name="registrar_cotizacion" value="1">

        <div class="col-md-4">
            <label for="nombre_cliente" class="form-label small">Nombre</label>
            <input type="text" id="nombre_cliente" name="nombre_cliente" class="form-control form-control-sm" required>
        </div>

        <div class="col-md-4">
            <label for="telefono_cliente" class="form-label small">Teléfono</label>
            <input type="tel" id="telefono_cliente" name="telefono_cliente" class="form-control form-control-sm" required>
        </div>

        <div class="col-auto">
            <button type="submit" class="btn btn-primary btn-sm">Registrar Cotización</button>
        </div>
    </form>

    <!-- Total de la compra -->
    <p class="mt-3 fs-5 fw-semibold">Total: $<?= number_format($totalCompra, 0, ',', '.') ?></p>

    <!-- Tabla del carrito -->
    <div style="max-height: 400px; overflow-y: auto;">
        <table class="table table-bordered table-striped align-middle text-center mt-3 mb-0 w-100">
            <thead class="table-light sticky-header">
                <tr>
                    <th class="p-1">ID</th>
                    <th class="p-1">Producto</th>
                    <th class="p-1">Descripción</th>
                    <th class="p-1">Cantidad</th>
                    <th class="p-1">Precio</th>
                    <th class="p-1">Subtotal</th>
                    <th class="p-1">Eliminar</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($_SESSION['carritoCotiza'] as $index => $item): ?>
                <tr>
                    <td class="p-1"><?= htmlspecialchars($item['idproducto']) ?></td>
                    <td class="p-1"><?= htmlspecialchars($item['nombre']) ?></td>
                    <td class="p-1"><?= htmlspecialchars($item['descripcion']) ?></td>
                    <td class="p-1"><?= htmlspecialchars($item['cantidad']) ?></td>
                    <td class="p-1">$<?= number_format($item['precio'], 0, ',', '.') ?></td>
                    <td class="p-1">$<?= number_format($item['subtotal'], 0, ',', '.') ?></td>
                    <td class="p-1">
                        <form method="post" action="../controller/cotizacionController.php" class="d-inline eliminar-producto-form">
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

<!-- jQuery y Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    $('#registrar-cotizacion-form').on('submit', function(e) {
        e.preventDefault();

        if (confirm("¿Está seguro de que desea registrar la cotización?")) {
            $.ajax({
                url: '../controller/cotizacionController.php',
                method: 'POST',
                data: $(this).serialize(),
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        actualizarCarritoCotiza();
                        $('#nombre_cliente').val('');
                        $('#telefono_cliente').val('');
                        alert('Cotización registrada exitosamente.');
                    } else if (response.error) {
                        alert(response.error);
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error al registrar la cotización:", status, error);
                    alert("Hubo un error al registrar la cotización.");
                }
            });
        }
    });

    function actualizarCarritoCotiza() {
        $.ajax({
            url: '../controller/cotizacionController.php',
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
