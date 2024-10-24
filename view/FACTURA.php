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
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   
</head>
<body>
  <div class="todo">
<div class="facturas">
<div>
<h2>Listado de Ventas</h2>
  <div class="factur"" >
  
    
    <form class="buscar" id="filtro-id-form">
    <label for="id_venta">ID de Venta:</label>
    <input type="text" id="id_venta" name="id_venta" placeholder="ID de Venta o 'todo'" required>
    <button class="btn" type="submit">Buscar</button>
    </form>

    <div class="calcu">
 <form id="sumatoria-fechas-form">

    <div class="fechas"">
    <label for="fecha_inicio">Inicio:</label>
    <input type="date" id="fecha_inicio" name="fecha_inicio" required>
    <div class="fin"">
    <label for="fecha_fin">Fin:</label>
    <input type="date" id="fecha_fin" name="fecha_fin" required>
    </div>
    </div>
    <button class="btnCalcu" type="submit">Calcular facturas</button>
   
  </form>

 <div  id="sumatoria-result"></div>
 
 </div>
 </div>

 <div class="fa">
    <table class="factu"border="1" id="ventas-table">
        <thead>
            <tr>
                <th>ID Venta</th>
                <th>Fecha</th>
                <th>Total</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody   id="ventas-tbody">
            <!-- Aquí se cargarán las ventas mediante AJAX -->
        </tbody>
    </table>
    </div>

    </div>


  <div class="verFactu">
  <div id="factura-id-result"></div>
 
 </div>
  </div>



    <div id="factura-id-result"></div>
    
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
                    html += '<td>' + venta.idventa + '</td>';
                    html += '<td>' + venta.fecha + '</td>';
                    html += '<td>$' + venta.total + '</td>';
                    html += '<td><button class="ver-factura-btn" data-venta-id="' + venta.idventa + '">Ver Factura</button> <a href="../controller/facturaControlador.php?venta_id=' + venta.idventa + '" target="_blank">Descargar Factura (PDF)</a></td>';
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

        if (idVenta.toLowerCase() === 'todo') {
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
                            html += '<td><button class="ver-factura-btn" data-venta-id="' + venta.idventa + '">Ver Factura</button> <a class="descargar" href="../controller/facturaControlador.php?venta_id=' + venta.idventa + '" target="_blank">Descargar Factura (PDF)</a></td>';
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

});



</script>
</div>
</body>
</html>
