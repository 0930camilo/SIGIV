<?php
session_start();
if (!isset($_SESSION['usuario']) || !isset($_SESSION['usuario_id'])) {
    echo "<script>alert('Debe iniciar sesión.'); window.location.href='../login.php';</script>";
    exit();
}
$usuario_id = $_SESSION['usuario_id'];
include '../config/conexion.php';
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nómina</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
    .container{
        margin-left: 14%;
        width: 80%;
    }
    .table-dark{
 position: sticky;
 top: 0; 
 background-color: white; 
 z-index: 10;
}
</style>
<body class="bg-light">

<div  class="container py-3">
    <!-- Formulario -->
    <div class="card shadow-sm mb-3">
        <div class="card-header bg-primary text-white py-2">
            <h6 class="mb-0">Gestión de Nómina</h6>
        </div>
      <div class="card-body p-2">
    <form id="formNomina" class="d-flex flex-wrap align-items-end gap-2 small">
        <input type="hidden" id="idnomina" name="idnomina">
        <input type="hidden" name="usuario_idusuario" value="<?= htmlspecialchars($usuario_id) ?>">

        <div class="d-flex flex-column" style="max-width: 200px;">
            <label for="descripcion" class="form-label mb-1">Descripción</label>
            <input type="text" class="form-control form-control-sm" id="descripcion" name="descripcion" required>
        </div>

        <div class="d-flex flex-column" style="max-width: 160px;">
            <label for="fecha_inicio_form" class="form-label mb-1">Fecha Inicio</label>
            <input type="date" class="form-control form-control-sm" id="fecha_inicio_form" name="fecha_inicio" required>
        </div>

        <div class="d-flex flex-column" style="max-width: 160px;">
            <label for="fecha_fin_form" class="form-label mb-1">Fecha Fin</label>
            <input type="date" class="form-control form-control-sm" id="fecha_fin_form" name="fecha_fin" required>
        </div>

        <div>
            <button type="submit" class="btn btn-success btn-sm">Guardar</button>
        </div>
    </form>
</div>

    </div>

    <!-- Tabla -->
    <div class="card shadow-sm">
        <div class="card-header bg-secondary text-white py-2">
            <h6 class="mb-0">Listado de Nóminas</h6>
        </div>
        <div class="card-body p-2" id="nominasTable">
            <!-- Se carga vía JS -->
        </div>
    </div>
</div>

<script>
$(document).ready(function () {
    cargarNominas();

    $('#formNomina').on('submit', function (e) {
        e.preventDefault();
        $.post('../controller/nominaController.php', $(this).serialize() + '&accion=guardar', function (response) {
            try {
                const data = JSON.parse(response);
                if (data.status === 'success') {
                    alert('Nómina guardada con éxito.');
                    $('#formNomina')[0].reset();
                    cargarNominas();
                } else {
                    alert('Error: ' + (data.message || 'No se pudo guardar.'));
                }
            } catch (e) {
                console.error('Error en respuesta:', response);
            }
        });
    });

    $(document).on('click', '.btn-eliminar', function () {
        const id = $(this).data('id');
        $.post('../controller/nominaController.php', { idnomina: id, accion: 'eliminar' }, function (response) {
            try {
                const data = JSON.parse(response);
                if (data.status === 'success') {
                    alert('Nómina eliminada.');
                    cargarNominas();
                }
            } catch (e) {
                console.error('Error al eliminar:', response);
            }
        });
    });

    $(document).on('click', '.btn-editar', function () {
        const row = $(this).closest('tr');
        $('#idnomina').val(row.find('.nomina-id').text());
        $('#descripcion').val(row.find('.nomina-descripcion').text());
        $('#fecha_inicio_form').val(row.find('.nomina-fecha-inicio').text());
        $('#fecha_fin_form').val(row.find('.nomina-fecha-fin').text());
    });

    function cargarNominas() {
        $.post('../controller/nominaController.php', {
            accion: 'cargar',
            usuario_idusuario: <?= $usuario_id ?>
        }, function (response) {
            renderizarNominas(response);
        });
    }

    function renderizarNominas(response) {
        const data = JSON.parse(response);
        if (data.status !== 'success') {
            $('#nominasTable').html('<p class="text-danger">Error al cargar nóminas.</p>');
            return;
        }
let html = `
<div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
    <table class="table table-sm table-bordered text-center">
        <thead class="table-dark sticky-top bg-light">
            <tr>
                <th>ID</th><th>Descripción</th><th>Inicio</th><th>Fin</th><th>Total</th><th>Acciones</th>
            </tr>
        </thead>
        <tbody>`;


        data.nominas.forEach(n => {
            html += `
                <tr>
                    <td class="nomina-id">${n.idnomina}</td>
                    <td class="nomina-descripcion">${n.descripcion}</td>
                    <td class="nomina-fecha-inicio">${n.fecha_inicio}</td>
                    <td class="nomina-fecha-fin">${n.fecha_fin}</td>
                    <td>$${parseFloat(n.total_pago).toLocaleString('es-CO')}</td>
    <td>
    <button class="btn btn-warning btn-sm btn-editar" title="Actualizar">
        <i class="fas fa-edit me-1"></i>
    </button>
    <button class="btn btn-danger btn-sm btn-eliminar" data-id="${n.idnomina}" title="Eliminar">
        <i class="fas fa-trash-alt me-1"></i> 
    </button>
</td>


                </tr>`;
        });

        html += `</tbody></table></div>`;
        $('#nominasTable').html(html);
    }
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
