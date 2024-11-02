<?php
session_start();

if (!isset($_SESSION['carrito']) || empty($_SESSION['carrito'])) {
    echo "<p>El carrito está vacío.</p>";
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
    // Por ejemplo, guardar la información del cliente y el total en la base de datos.
}
?>

<link rel="stylesheet" href="../css/carro.css">

<div>

    
    <!-- Campo para ingresar el monto pagado -->
    <form method="post" id="registrar-venta-form">
        <input type="hidden" name="registrar_venta" value="1">
        <div>
            <label for="nombre_cliente">Nombre</label>
            <input type="text" id="nombre_cliente" name="nombre_cliente">
        </div>

        <div>
            <label for="telefono_cliente">Teléfono</label>
            <input type="tel" id="telefono_cliente" name="telefono_cliente">
        </div>
        
        <label for="monto_pagado">Monto Pagado:</label>
        <input type="text" name="monto_pagado" id="monto_pagado" value="<?= isset($montoPagado) ? number_format($montoPagado, 0, ',', '.') : '' ?>" oninput="updateCambio()">
        
        <button class="btng" type="submit">Registrar Venta</button>
    </form>

        <!-- Total del carrito -->
        <p >Total: $<?= number_format($totalCompra, 0, ',', '.') ?></p>
    <!-- Cambio calculado -->
    <p>Cambio: $<span id="cambio"><?= number_format($cambio, 0, ',', '.') ?></span></p>

    <div class="carros">
        <!-- Tabla del carrito -->
        <table class="carr" border="1">
            <thead class="carr">
                <tr>
                    <th>id</th>
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
                    <td class="td"><?= htmlspecialchars($item['idproducto']) ?></td>
                        <td class="td"><?= htmlspecialchars($item['nombre']) ?></td>
                        <td class="td"><?= htmlspecialchars($item['descripcion']) ?></td>
                        <td class="td"><?= htmlspecialchars($item['cantidad']) ?></td>
                        <td class="td">$<?= number_format($item['precio'], 0, ',', '.') ?></td>
                        <td class="td">$<?= number_format($item['subtotal'], 0, ',', '.') ?></td>
                        <td>
                            <form class="eliminar-producto-form" method="post" action="../controller/ventasController.php">
                                <input type="hidden" name="accion" value="eliminar_producto">
                                <input type="hidden" name="index" value="<?= $index ?>">
                                <button type="submit" class="btn-eliminar">Eliminar</button>
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
    // Función para actualizar el cambio en tiempo real
    function updateCambio() {
        const montoPagado = parseFloat(document.getElementById('monto_pagado').value.replace(/,/g, '')) || 0;
        const totalCompra = <?= $totalCompra ?>;
        const cambio = montoPagado - totalCompra;
        document.getElementById('cambio').innerText = cambio < 0 ? 0 : cambio.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    // Manejar el registro de la venta y vaciar los campos
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
                        // Recargar el carrito después de registrar la venta
                        actualizarCarrito();
                        
                        // Vaciar los campos de nombre y teléfono del cliente
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
            url: '../controller/ventasController.php', // Asegúrate de que esta ruta sea correcta
            method: 'POST',
            data: {accion: 'actualizar_carrito'},
            dataType: 'json',
            success: function(response) {
                // Reemplazar el HTML del carrito
                $('#carrito-contenido').html(response.html); // Usa el ID correcto aquí
            },
            error: function(xhr, status, error) {
                console.error("Error al actualizar el carrito:", status, error);
                alert("Hubo un error al actualizar el carrito.");
            }
        });
    }
</script>
