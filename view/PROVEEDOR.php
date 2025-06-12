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
    <title>Gestión de Proveedores</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS y Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <!-- CSS personalizado -->
    <link rel="stylesheet" href="../css/proveedor.css" />

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container py-4">

    <div class="row justify-content-center">
        <div class="col-lg-10">

            <div class="row g-4">
                <!-- Formulario -->
                <div class="col-lg-4">
                    <div class="form-fixed">
                        <h1 class="h4 text-center">Gestión de Proveedores</h1>
                        <form id="formProveedor" class="card p-3 shadow-sm">
                            <input type="hidden" id="idproveedor" name="idproveedor" />

                            <div class="mb-3">
                                <label for="nombre" class="form-label">Nombre del Proveedor</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required>
                            </div>

                            <div class="mb-3">
                                <label for="telefono" class="form-label">Teléfono</label>
                                <input type="text" class="form-control" id="telefono" name="telefono" required>
                            </div>

                            <button type="submit" class="btn btn-primary w-100">Guardar</button>
                        </form>
                    </div>
                </div>

                <!-- Lista de proveedores -->
                <div class="col-lg-8">
                    <h1 class="h4 text-center">Lista de Proveedores</h1>

                    <div class="input-group mb-3">
                        <input type="text" id="buscarNombre" class="form-control" placeholder="Buscar proveedor por nombre">
                        <button class="btn btn-outline-secondary" id="buscarProveedorBtn">Buscar</button>
                    </div>

                    <div class="table-responsive scroll-area" id="listaProveedores">
                        <!-- Proveedores cargados dinámicamente -->
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    $(document).ready(function () {
        cargarProveedores();

        $('#formProveedor').on('submit', function (e) {
            e.preventDefault();
            $.ajax({
                url: '../controller/proveedorController.php',
                type: 'POST',
                data: $(this).serialize() + '&accion=guardar',
                success: function (response) {
                    const data = JSON.parse(response);
                    alert(data.message);
                    if (data.status === 'success') {
                        cargarProveedores();
                        $('#formProveedor')[0].reset();
                        $('#idproveedor').val('');
                    }
                }
            });
        });

        function cargarProveedores() {
            $.post('../controller/proveedorController.php', { accion: 'cargar' }, function (response) {
                const data = JSON.parse(response);
                let html = '<table class="table table-striped table-bordered fixed-header-table">';
                html += '<thead><tr><th>ID</th><th>Nombre</th><th>Teléfono</th><th>Acciones</th></tr></thead><tbody>';

                if (data.status === 'success') {
                    data.proveedores.forEach(p => {
                        html += `<tr>
                            <td>${p.idproveedor}</td>
                            <td>${p.nombre}</td>
                            <td>${p.telefono}</td>
                            <td>
                               <button class="btn btn-sm btn-warning editar" 
        data-id="${p.idproveedor}" 
        data-nombre="${p.nombre}" 
        data-telefono="${p.telefono}" 
        title="Editar">
    <i class="bi bi-pencil-square"></i>
</button>

<button class="btn btn-sm btn-danger eliminar" 
        data-id="${p.idproveedor}" 
        title="Eliminar">
    <i class="bi bi-trash"></i>
</button>

                            </td>
                        </tr>`;
                    });
                } else {
                    html += '<tr><td colspan="4">No se encontraron proveedores.</td></tr>';
                }

                html += '</tbody></table>';
                $('#listaProveedores').html(html);
            });
        }

        $(document).on('click', '.editar', function () {
            $('#idproveedor').val($(this).data('id'));
            $('#nombre').val($(this).data('nombre'));
            $('#telefono').val($(this).data('telefono'));
        });

        $(document).on('click', '.eliminar', function () {
            const id = $(this).data('id');
            if (confirm('¿Seguro que deseas eliminar este proveedor?')) {
                $.post('../controller/proveedorController.php', { accion: 'eliminar', idproveedor: id }, function (response) {
                    const data = JSON.parse(response);
                    alert(data.message);
                    if (data.status === 'success') {
                        cargarProveedores();
                    }
                });
            }
        });

        $('#buscarProveedorBtn').on('click', function () {
            const nombreBuscar = $('#buscarNombre').val();
            buscarProveedorPorNombre(nombreBuscar);
        });

        $('#buscarNombre').on('keypress', function (e) {
            if (e.which === 13) {
                buscarProveedorPorNombre($(this).val());
            }
        });

        function buscarProveedorPorNombre(nombreBuscar) {
            $.post('../controller/proveedorController.php', { accion: 'buscar', nombreBuscar }, function (response) {
                const data = JSON.parse(response);
                let html = '<table class="table table-striped table-bordered fixed-header-table">';
                html += '<thead><tr><th>ID</th><th>Nombre</th><th>Teléfono</th><th>Acciones</th></tr></thead><tbody>';

                if (data.status === 'success' && data.proveedores.length > 0) {
                    data.proveedores.forEach(p => {
                        html += `<tr>
                            <td>${p.idproveedor}</td>
                            <td>${p.nombre}</td>
                            <td>${p.telefono}</td>
                            <td>
                                <button class="btn btn-sm btn-warning editar" data-id="${p.idproveedor}" data-nombre="${p.nombre}" data-telefono="${p.telefono}" title="Editar"><i class="bi bi-pencil-square"></i></button>
<button class="btn btn-sm btn-danger eliminar" data-id="${p.idproveedor}" title="Eliminar"><i class="bi bi-trash"></i></button>
                            </td>
                        </tr>`;
                    });
                } else {
                    html += '<tr><td colspan="4">No se encontraron proveedores.</td></tr>';
                }

                html += '</tbody></table>';
                $('#listaProveedores').html(html);
            });
        }
    });
</script>
</body>
</html>
