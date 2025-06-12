<?php
session_start();
include '../controller/facturaControlador.php'; // Asegúrate de que el controlador esté en la ruta correcta

// Verificar sesión del usuario
if (!isset($_SESSION['usuario'])) {
    echo "<script>alert('Por favor, inicie sesión.'); window.location.href='../login.php';</script>";
    exit();
}

if (!isset($_SESSION['usuario_id'])) {
    echo "<script>alert('No se pudo obtener el ID de usuario.'); window.location.href='../login.php';</script>";
    exit();
}

$usuario_id = $_SESSION['usuario_id'];

// Obtener la lista de ventas realizadas por el usuario
function obtenerVentas() {
    global $conn, $usuario_id;
    // Consulta SQL con orden descendente por idventa
    $sql = "SELECT * FROM ventas WHERE usuario_idusuario = ? ORDER BY idventa DESC";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $usuario_id);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_all(MYSQLI_ASSOC);
}


$ventas = obtenerVentas(); // Obtener ventas realizadas por el usuario

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Facturas</title>
    <link rel="stylesheet" href="../css/facturas.css">
    <!-- Agrega en <head> -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <style>
    .card-header h5, .card-header h6 {
  font-weight: 600;
  margin-bottom: 0;
}

.table th, .table td {
  vertical-align: middle;
}
.row{
    margin-left: 10%;
}
  .table-responsive-fixed {
    max-height: 400px;
    overflow-y: auto;
    position: relative;
  }

  .table-responsive-fixed thead th {
    position: sticky;
    top: 0;
    background-color: #cfe2ff; /* color similar al de .table-primary */
    z-index: 10;
  }
   </style>
</head>
<body>
 <div class="container-fluid mt-4">
  <div class="row g-3">
    <!-- Panel de Ventas -->
    <div class="col-md-7">
      <div class="card shadow-sm border-0">
        <div class="card-header bg-primary text-white py-2">
          <h5 class="mb-0">Ventas Realizadas</h5>
        </div>
        <div class="card-body">
          <!-- Filtro por Fechas -->
    <form id="sumatoria-fechas-form" class="row g-2 align-items-end mb-1 w-auto ms-1">
  <div class="col-sm-3">
    <label for="fecha_inicio" class="form-label">Desde:</label>
    <input type="date" id="fecha_inicio" name="fecha_inicio" class="form-control form-control-sm" required>
  </div>
  <div class="col-sm-3">
    <label for="fecha_fin" class="form-label">Hasta:</label>
    <input type="date" id="fecha_fin" name="fecha_fin" class="form-control form-control-sm" required>
  </div>
  
  <!-- Botón y resultado en línea -->
  <div class="col-sm-6 d-flex align-items-end mt-1">
  <div class="me-2">
    <button class="btn btn-success btn-sm" type="submit">Calcular</button>
  </div>
  <div id="sumatoria-result" class="text-muted small"></div>
</div>

</form>



          <!-- Filtro por ID -->
          <form id="filtro-id-form" class="row g-2 align-items-end mb-3 w-auto ms-1">
            <div class="col-sm-8">
              <label for="id_venta" class="form-label">Buscar por ID Venta:</label>
              <input type="text" id="id_venta" name="id_venta" class="form-control form-control-sm" placeholder="ID ">
            </div>
            <div class="col-sm-4 d-grid">
              <button class="btn btn-primary btn-sm" type="submit">Buscar</button>
            </div>
          </form>

          <!-- Tabla de ventas con estilo similar al de cotización -->
<div class="table-responsive table-responsive-fixed">
  <table class="table table-bordered table-hover align-middle table-sm" id="ventas-table">
    <thead class="text-center small">
      <tr>
        <th>ID Venta</th>
        <th>Fecha</th>
        <th>Total</th>
        <th>Acciones</th>
      </tr>
    </thead>
    <tbody id="ventas-tbody" class="text-center small">
      <!-- JS cargará los datos -->
    </tbody>
  </table>
</div>

        </div>
      </div>
    </div>

    <!-- Detalle de Factura -->
    <div class="col-md-5">
      <div class="card shadow-sm border-0 h-100">
        <div class="card-header bg-info text-white py-2">
          <h6 class="mb-0">Detalle de Factura</h6>
        </div>
        <div class="card-body" id="factura-id-result" style="font-size: 0.9rem;">
          <!-- Aquí carga la factura individual -->
        </div>
      </div>
    </div>
  </div>
</div>

 <script>
$(document).ready(function() {
    // Cargar todas las ventas al iniciar la página
    cargarVentas();

    // Función para cargar todas las ventas
    // Cargar todas las ventas al iniciar la página
function cargarVentas() {
    $.ajax({
        url: '../controller/facturaControlador.php',
        method: 'POST',
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                var ventas = response.ventas;
                var html = '';
                $.each(ventas, function(index, venta) {
       html += '<tr>';
html += '<td class="text-start">' + venta.idventa + '</td>';
html += '<td class="text-start">' + venta.fecha + '</td>';
html += '<td class="text-start">$' + venta.total + '</td>';
html += '<td class="d-flex align-items-center justify-content-start gap-2">';
html += '<button class="btn btn-sm btn-info ver-factura-btn" data-venta-id="' + venta.idventa + '">';
html += '<i class="bi bi-eye"></i> Ver</button>';
html += '<a class="btn btn-sm btn-success" href="../controller/facturaControlador.php?venta_id=' + venta.idventa + '" target="_blank">';
html += '<i class="bi bi-download"></i> (PDF)</a>';
html += '<button class="btn btn-sm btn-warning devolucion-btn" data-venta-id="' + venta.idventa + '">';
html += '<i class="bi bi-arrow-counterclockwise"></i></button>';
html += '</td>';
html += '</tr>';




                });
                $('#ventas-tbody').html(html);
            } else {
                $('#ventas-tbody').html('<tr><td colspan="4">No se encontraron ventas.</td></tr>');
            }
        },
        error: function(xhr, status, error) {
            console.error('Error al cargar las ventas: ' + error);
            $('#ventas-tbody').html('<tr><td colspan="4">Ocurrió un error al cargar las ventas.</td></tr>');
        }
    });
}


    // Manejar la búsqueda de ventas por ID o "todo"
    $('#filtro-id-form').submit(function(event) {
        event.preventDefault();
        var idVenta = $('#id_venta').val().trim();
if (idVenta.trim() === '') {
    
            cargarVentas(); // Si el usuario escribe "todo", carga todas las ventas
        } else {
            // Si no es "todo", busca por ID de venta
            $.ajax({
                url: '../controller/facturaControlador.php',
                method: 'POST',
                data: { buscar_ventas_id: true, id_venta: idVenta },
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        var ventas = response.ventas;
                        var html = '';
                        $.each(ventas, function(index, venta) {
                            html += '<tr>';
                            html += '<td>' + venta.idventa + '</td>';
                            html += '<td>' + venta.fecha + '</td>';
                            html += '<td>$' + venta.total + '</td>';
                           html += '<td class="d-flex align-items-center justify-content-start gap-2">';
html += '<button class="btn btn-sm btn-info ver-factura-btn" data-venta-id="' + venta.idventa + '">';
html += '<i class="bi bi-eye"></i> Ver</button>';
html += '<a class="btn btn-sm btn-success" href="../controller/facturaControlador.php?venta_id=' + venta.idventa + '" target="_blank">';
html += '<i class="bi bi-download"></i> (PDF)</a>';
html += '<button class="btn btn-sm btn-warning devolucion-btn" data-venta-id="' + venta.idventa + '">';
html += '<i class="bi bi-arrow-counterclockwise"></i></button>';
html += '</td>';
html += '</tr>';

                        });
                        $('#ventas-tbody').html(html);
                    } else if (response.error) {
                        $('#ventas-tbody').html('<tr><td colspan="4">' + response.error + '</td></tr>');
                    }
                },
                error: function() {
                    $('#ventas-tbody').html('<tr><td colspan="4">Hubo un error al procesar la solicitud.</td></tr>');
                }
            });
        }
    });

    // Manejar la solicitud de sumatoria por rango de fechas
   // Sumatoria de ventas por rango de fechas
   $('#sumatoria-fechas-form').submit(function(e) {
    e.preventDefault();
    var fecha_inicio = $('#fecha_inicio').val();
    var fecha_fin = $('#fecha_fin').val();

    $.ajax({
        url: '../controller/facturaControlador.php',
        method: 'POST',
        data: {
            sumatoria_rango_fecha: true,
            fecha_inicio: fecha_inicio,
            fecha_fin: fecha_fin
        },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                // Mostrar total vendido y ganancia total
                $('#sumatoria-result').html(
                    '<p>Total vendido: $' + response.total_sum + '</p>' +
                    '<p>Ganancia total: $' + response.ganancia_total + '</p>'
                );
            } else {
                // Mostrar mensaje de error si ocurre un problema
                $('#sumatoria-result').html('<p>' + response.error + '</p>');
            }
        },
        error: function(xhr, status, error) {
            console.error('Error al calcular la sumatoria: ' + error);
            $('#sumatoria-result').html('<p>Ocurrió un error al calcular la sumatoria.</p>');
        }
    });
});


    // Ver factura sin recargar la página
$(document).on('click', '.ver-factura-btn', function() {
    var venta_id = $(this).data('venta-id');
    
    $.ajax({
        url: '../controller/facturaControlador.php',
        method: 'POST',
        data: {
            buscar_factura_id: true,
            id_venta: venta_id
        },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                $('#factura-id-result').html(response.html);
            } else {
                $('#factura-id-result').html('<p>' + response.error + '</p>');
            }
        },
        error: function(xhr, status, error) {
            console.error('Error al cargar la factura: ' + error);
            $('#factura-id-result').html('<p>Ocurrió un error al cargar la factura.</p>');
        }
    });
});


document.addEventListener('click', function(event) {
    if (event.target.classList.contains('devolucion-btn')) {
        event.stopPropagation(); // Evitar que el evento se propague

        const ventaId = event.target.getAttribute('data-venta-id');
        const productoId = prompt("Ingrese el ID del producto para devolución:");

        // Validar el ID del producto
        if (!productoId) {
            alert("El ID del producto es necesario para continuar con la devolución.");
            return;
        }

        const nuevaCantidad = prompt("Ingrese la nueva cantidad para devolución:");

        // Validar la cantidad
        if (!nuevaCantidad) {
            alert("La cantidad es necesaria para continuar con la devolución.");
            return;
        }

        // Ejecutar el fetch solo después de obtener ambos valores
        fetch('../controller/devolucionControlador.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `accion=devolucion&venta_id=${ventaId}&producto_id=${productoId}&cantidad=${nuevaCantidad}`
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.success);
                location.reload(); // Recargar para mostrar cambios
            } else {
                alert(data.error);
            }
        })
        .catch(error => console.error('Error:', error));
    }
});

});



</script>
</div>
</body>
</html>
