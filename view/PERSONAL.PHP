<?php
session_start();

if (!isset($_SESSION['usuario']) || !isset($_SESSION['usuario_id'])) {
    echo "<script>alert('Por favor, inicie sesión.'); window.location.href='../login.php';</script>";
    exit();
}

$usuario_id = $_SESSION['usuario_id'];
include '../config/conexion.php';
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Gestión de Personas</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="bg-light">
<style>
  .container {
    width: 80%;
    margin-left: 12%;
  }
</style>

<div class="container py-4">
  <div class="card mb-2" style="font-size: 13px;">
    <div class="card-header bg-primary text-white py-2">
      <h5 class="mb-0">Gestión de Personas</h5>
    </div>
    <div class="card-body p-2">
      <form id="formPersona" class="row g-2">
        <div class="col-md-2">
          <label for="idpersona" class="form-label">ID (opcional)</label>
          <input type="number" class="form-control form-control-sm" id="idpersona" name="idpersona" placeholder="Auto ID">
        </div>
        <div class="col-md-2">
          <label for="nombre" class="form-label">Nombre</label>
          <input type="text" class="form-control form-control-sm" id="nombre" name="nombre" required>
        </div>
        <div class="col-md-2">
          <label for="correo" class="form-label">Correo</label>
          <input type="email" class="form-control form-control-sm" id="correo" name="correo" required>
        </div>
        <div class="col-md-2">
          <label for="telefono" class="form-label">Teléfono</label>
          <input type="text" class="form-control form-control-sm" id="telefono" name="telefono">
        </div>
        <div class="col-md-2">
          <label for="direccion" class="form-label">Dirección</label>
          <input type="text" class="form-control form-control-sm" id="direccion" name="direccion">
        </div>
        <div class="col-md-1">
          <label for="fecha_nacimiento" class="form-label">F. Nac.</label>
          <input type="date" class="form-control form-control-sm" id="fecha_nacimiento" name="fecha_nacimiento">
        </div>
        <div class="col-md-1">
          <label for="fecha_ingreso" class="form-label">F. Ingr.</label>
          <input type="date" class="form-control form-control-sm" id="fecha_ingreso" name="fecha_ingreso">
        </div>
        <div class="col-12 text-end">
          <button type="submit" class="btn btn-success btn-sm">Guardar</button>
        </div>
      </form>
    </div>
  </div>

  <div class="card mb-2" style="font-size: 13px;">
    <div class="card-header bg-secondary text-white py-2 d-flex justify-content-between align-items-center">
      <h6 class="mb-0">Lista de Personas</h6>
      <form id="formBuscarPersona" class="d-flex">
        <input type="text" id="buscarNombre" class="form-control form-control-sm me-2" placeholder="Buscar nombre">
        <button id="buscarPersonaBtn" class="btn btn-light btn-sm" type="submit">Buscar</button>
      </form>
    </div>
    <div class="card-body p-2" id="listaPersonas">
      <!-- Aquí se cargará la lista -->
    </div>
  </div>
</div>

<script>
$(function(){
  function cargarPersonas(){
    $.post('../controller/personaController.php', {accion:'cargar'}, renderizar);
  }

  function renderizar(resp){
    let html = `
<div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
  <table class="table table-bordered table-sm mb-0" style="font-size:13px;">
    <thead class="table-success text-center" style="position: sticky; top: 0; z-index: 1;">
      <tr>
        <th>ID</th>
        <th>Nombre</th>
        <th>Correo</th>
        <th>Tel</th>
        <th>Dir</th>
        <th>FN</th>
        <th>FI</th>
        <th>Acciones</th>
      </tr>
    </thead>
    <tbody>
`;


    if(resp.status === 'success'){
      resp.personas.forEach(p => {
        html += '<tr>'
          + `<td>${p.idpersona}</td>`
          + `<td>${p.nombre}</td>`
          + `<td>${p.correo}</td>`
          + `<td>${p.telefono}</td>`
          + `<td>${p.direccion}</td>`
          + `<td>${p.fecha_nacimiento}</td>`
          + `<td>${p.fecha_ingreso}</td>`
          + '<td>'
          + `<button class="btn btn-sm btn-warning editar me-1" data-id="${p.idpersona}" data-info='${JSON.stringify(p)}' title="Editar persona"><i class="bi bi-pencil-square"></i></button>`
          + `<button class="btn btn-sm btn-danger eliminar" data-id="${p.idpersona}" title="Eliminar persona"><i class="bi bi-trash"></i></button>`
          + '</td>'
          + '</tr>';
      });
    } else {
      html += '<tr><td colspan="8" class="text-center">No hay datos</td></tr>';
    }

    html += '</tbody></table></div>';
    $('#listaPersonas').html(html);
  }

  $('#formPersona').on('submit', function(e){
    e.preventDefault();
    let frm = $(this);
    $.post('../controller/personaController.php', frm.serialize() + '&accion=guardar', data => {
      alert(data.message);
      if(data.status === 'success'){
        frm[0].reset();
        $('#idpersona').val('');
        cargarPersonas();
      }
    });
  });

  $(document).on('click', '.editar', function(){
    let p = JSON.parse($(this).attr('data-info'));
    $('#idpersona').val(p.idpersona);
    $('#nombre').val(p.nombre);
    $('#correo').val(p.correo);
    $('#telefono').val(p.telefono);
    $('#direccion').val(p.direccion);
    $('#fecha_nacimiento').val(p.fecha_nacimiento);
    $('#fecha_ingreso').val(p.fecha_ingreso);
  });

  $(document).on('click', '.eliminar', function(){
    if(!confirm('¿Eliminar?')) return;
    $.post('../controller/personaController.php', {accion:'eliminar', idpersona:$(this).data('id')}, data => {
      alert(data.message);
      cargarPersonas();
    });
  });

  $('#formBuscarPersona').on('submit', function(e){
    e.preventDefault();
    const nombreBuscar = $('#buscarNombre').val().trim();

    if (nombreBuscar === '') {
      cargarPersonas(); // Mostrar todo si está vacío
    } else {
      $.post('../controller/personaController.php',
             {accion:'buscar', nombreBuscar: nombreBuscar},
             renderizar);
    }
  });

  // Carga inicial
  cargarPersonas();
});
</script>
</body>
</html>
