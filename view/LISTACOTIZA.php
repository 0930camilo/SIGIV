<?php
session_start();
include '../controller/listaCotizaController.php';

if (!isset($_SESSION['usuario'])) {
    echo "<script>alert('Por favor, inicie sesión.'); window.location.href='../login.php';</script>";
    exit();
}

if (!isset($_SESSION['usuario_id'])) {
    echo "<script>alert('No se pudo obtener el ID de usuario.'); window.location.href='../login.php';</script>";
    exit();
}

$usuario_id = $_SESSION['usuario_id'];

function obtenerCotizaciones() {
    global $conn, $usuario_id;
    $sql = "SELECT * FROM cotizacion WHERE usuario_idusuario = ? ORDER BY idcotizacion DESC";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $usuario_id);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_all(MYSQLI_ASSOC);
}

$cotizacion = obtenerCotizaciones();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Cotizaciones</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
  .table-responsive-fixed {
    max-height: 400px;
    overflow-y: auto;
    position: relative;
  }

  .table-responsive-fixed thead th {
    position: sticky;
    top: 0;
    background-color: #cfe2ff; /* Mismo color que .table-primary */
    z-index: 10;
  }
</style>

</head>
<body class="bg-light">

<div class="container py-3" style="max-width: 90%; margin-left: 12%;">
    <div class="card shadow-sm rounded d-flex flex-column">
        <div class="card-body p-3 d-flex" style="gap: 1rem;">
            <!-- Columna izquierda: formulario + tabla -->
            <div style="flex: 1 1 60%; min-width: 0;">
                <h2 class="mb-3 text-primary text-center fs-5">Listado de Cotizaciones</h2>

                <form class="row g-2 mb-3" id="filtro-id-form">
                    <div class="col-md-7">
                        <label for="id_cotizacion" class="form-label small">ID de Cotización</label>
                        <input type="text" class="form-control form-control-sm" id="id_cotizacion" name="id_cotizacion" placeholder="ID" >
                    </div>
                    <div class="col-md-5 align-self-end">
                        <button class="btn btn-primary w-100 btn-sm" type="submit">
                            <i class="bi bi-search"></i> Buscar
                        </button>
                    </div>
                </form>

              <div class="table-responsive table-responsive-fixed">
  <table class="table table-bordered table-hover align-middle table-sm" id="cotizacion-table">
    <thead class="text-center small">
      <tr>
        <th>ID Cotización</th>
        <th>Fecha</th>
        <th>Total</th>
        <th>Acciones</th>
      </tr>
    </thead>
    <tbody id="cotizacion-tbody" class="text-center small">
      <!-- Aquí se cargarán las cotizaciones mediante AJAX -->
    </tbody>
  </table>
</div>

            </div>

            <!-- Columna derecha: detalle info -->
            <div id="factura-id-result" class="border rounded p-3" style="flex: 1 1 40%; min-width: 200px; max-height: 600px; overflow-y: auto;">
                <!-- Aquí se muestra la info de la cotización seleccionada -->
                <p class="text-muted small text-center">Selecciona una cotización para ver detalles</p>
            </div>
        </div>
    </div>
</div>



<!-- Scripts -->
<script>
$(document).ready(function() {
    cargarCotizaciones();

    function cargarCotizaciones() {
        $.ajax({
            url: '../controller/listaCotizaController.php',
            method: 'POST',
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    var html = '';
                    $.each(response.cotizacion, function(index, cotizacion) {
                        html += '<tr>';
                        html += '<td>' + cotizacion.idcotizacion + '</td>';
                        html += '<td>' + cotizacion.fecha + '</td>';
                        html += '<td>' + parseFloat(cotizacion.total).toLocaleString("es-CO", { style: "currency", currency: "COP" }) + '</td>';
                        html += '<td>';
                        html += '<button class="btn btn-sm btn-info me-2 ver-factura-btn" data-cotizacion-id="' + cotizacion.idcotizacion + '">';
                        html += '<i class="bi bi-eye"></i> Ver</button>';
                        html += '<a class="btn btn-sm btn-success" href="../controller/listaCotizaController.php?cotizacion_id=' + cotizacion.idcotizacion + '" target="_blank">';
                        html += '<i class="bi bi-download"></i> PDF</a>';
                        html += '</td></tr>';
                    });
                    $('#cotizacion-tbody').html(html);
                } else {
                    $('#cotizacion-tbody').html('<tr><td colspan="4">No se encontraron cotizaciones.</td></tr>');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error al cargar las cotizaciones: ' + error);
                $('#cotizacion-tbody').html('<tr><td colspan="4">Ocurrió un error al cargar las cotizaciones.</td></tr>');
            }
        });
    }

    $('#filtro-id-form').submit(function(event) {
        event.preventDefault();
        var idcotizacion = $('#id_cotizacion').val().trim();

        if (idcotizacion.trim() === '') {
            cargarCotizaciones();
        } else {
            $.ajax({
                url: '../controller/listaCotizaController.php',
                method: 'POST',
                data: { buscar_cotizacion_id: true, id_cotizacion: idcotizacion },
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        var html = '';
                        $.each(response.cotizacion, function(index, cotizacion) {
                            html += '<tr>';
                            html += '<td>' + cotizacion.idcotizacion + '</td>';
                            html += '<td>' + cotizacion.fecha + '</td>';
                            html += '<td>' + parseFloat(cotizacion.total).toLocaleString("es-CO", { style: "currency", currency: "COP" }) + '</td>';
                            html += '<td>';
                            html += '<button class="btn btn-sm btn-info me-2 ver-factura-btn" data-cotizacion-id="' + cotizacion.idcotizacion + '">';
                            html += '<i class="bi bi-eye"></i> Ver</button>';
                            html += '<a class="btn btn-sm btn-success" href="../controller/listaCotizaController.php?cotizacion_id=' + cotizacion.idcotizacion + '" target="_blank">';
                            html += '<i class="bi bi-download"></i> PDF</a>';
                            html += '</td></tr>';
                        });
                        $('#cotizacion-tbody').html(html);
                    } else if (response.error) {
                        $('#cotizacion-tbody').html('<tr><td colspan="4">' + response.error + '</td></tr>');
                    }
                },
                error: function() {
                    $('#cotizacion-tbody').html('<tr><td colspan="4">Hubo un error al procesar la solicitud.</td></tr>');
                }
            });
        }
    });

    $(document).on('click', '.ver-factura-btn', function() {
        var cotizacion_id = $(this).data('cotizacion-id');
        $.ajax({
            url: '../controller/listaCotizaController.php',
            method: 'POST',
            data: {
                buscar_factura_id: true,
                id_cotizacion: cotizacion_id
            },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    $('#factura-id-result').html(response.html);
                } else {
                    $('#factura-id-result').html('<p class="text-danger">' + response.error + '</p>');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error al cargar la factura: ' + error);
                $('#factura-id-result').html('<p class="text-danger">Ocurrió un error al cargar la factura.</p>');
            }
        });
    });
});
</script>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
