<?php

session_start();

// Verificar si el usuario está autenticado
if (!isset($_SESSION['usuario'])) {
    echo "<script>alert('Por favor, inicie sesión.'); window.location.href='../login.php';</script>";
    exit();
}

// Verificar si 'usuario_id' está definido en la sesión
if (!isset($_SESSION['usuario_id'])) {
    echo "<script>alert('No se pudo obtener el ID de usuario.'); window.location.href='../login.php';</script>";
    exit();
}

$usuario_id = $_SESSION['usuario_id']; // Guardar el ID del usuario en una variable

// Obtener las categorías y proveedores para el selector
include '../config/conexion.php';

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Proveedores</title>
    <link rel="stylesheet" href="../css/proveedor.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h1 class="h1">Gestión de Proveedores</h1>
            
            <!-- Formulario para agregar/editar proveedor -->
            <form id="formProveedor">
                <input type="hidden" id="idproveedor" name="idproveedor">
                
                <label for="nombre">Nombre del Proveedor:</label>
                <input type="text" id="nombre" name="nombre" required>

                <label for="telefono">Teléfono:</label>
                <input type="text" id="telefono" name="telefono" required>

                <button type="submit">Guardar Proveedor</button>
            </form>

            <hr>
        </div>
        
        <div class="list-container">
            <h1>PROVEEDORES</h1>
            <label for="buscarNombre">Buscar Proveedor:</label>
            <input type="text" id="buscarNombre" name="buscarNombre" placeholder=" Nombre del Proveedor">
            <button id="buscarProveedorBtn">Buscar</button>
            
            <!-- Lista de proveedores -->
            <div class="prove" id="listaProveedores"></div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            cargarProveedores();

            // Manejar el envío del formulario para guardar proveedor
            $('#formProveedor').on('submit', function (e) {
                e.preventDefault();
                var formData = $(this).serialize() + '&accion=guardar';

                $.post('../controller/proveedorController.php', formData, function (response) {
                    var data = JSON.parse(response);
                    alert(data.message);
                    if (data.status === 'success') {
                        cargarProveedores();
                        $('#formProveedor')[0].reset(); // Limpiar el formulario
                    }
                });
            });

            // Función para cargar la lista de proveedores
            function cargarProveedores() {
    $.post('../controller/proveedorController.php', { accion: 'cargar' }, function (response) {
        var data = JSON.parse(response);
        var html = '<table class="proveedor-tabla" border="1"><thead><tr><th>ID</th><th>Nombre</th><th>Teléfono</th><th>Acciones</th></tr></thead><tbody>';

        if (data.status === 'success') {
            $.each(data.proveedores, function (index, proveedor) {
                html += '<tr>';
                html += '<td>' + proveedor.idproveedor + '</td>';
                html += '<td>' + proveedor.nombre + '</td>';
                html += '<td>' + proveedor.telefono + '</td>';
                html += '<td><button class="editar" data-id="' + proveedor.idproveedor + '" data-nombre="' + proveedor.nombre + '" data-telefono="' + proveedor.telefono + '">Actualizar</button>';
                html += ' <button class="eliminar" data-id="' + proveedor.idproveedor + '">Eliminar</button></td>';
                html += '</tr>';
            });
        } else {
            html += '<tr><td colspan="4">No se encontraron proveedores.</td></tr>';
        }

        html += '</tbody></table>';
        $('#listaProveedores').html(html);
    });
}

// Manejar el evento de editar proveedor
$(document).on('click', '.editar', function () {
    $('#idproveedor').val($(this).data('id'));
    $('#nombre').val($(this).data('nombre'));
    $('#telefono').val($(this).data('telefono'));
});

// Manejar el evento de eliminar proveedor
$(document).on('click', '.eliminar', function () {
    var id = $(this).data('id');
    if (confirm('¿Seguro que deseas eliminar este proveedor?')) {
        $.post('../controller/proveedorController.php', { accion: 'eliminar', idproveedor: id }, function (response) {
            var data = JSON.parse(response);
            alert(data.message);
            if (data.status === 'success') {
                cargarProveedores();
            }
        });
    }
});

// Funcionalidad de búsqueda
$('#buscarProveedorBtn').on('click', function () {
    var nombreBuscar = $('#buscarNombre').val();
    buscarProveedorPorNombre(nombreBuscar);
});

// Función para buscar proveedores por nombre
function buscarProveedorPorNombre(nombreBuscar) {
    $.post('../controller/proveedorController.php', { accion: 'buscar', nombreBuscar: nombreBuscar }, function (response) {
        var data = JSON.parse(response);
        var html = '<table class="proveedor-tabla" border="1"><thead><tr><th>ID</th><th>Nombre</th><th>Teléfono</th><th>Acciones</th></tr></thead><tbody>';

        if (data.status === 'success' && data.proveedores.length > 0) {
            $.each(data.proveedores, function (index, proveedor) {
                html += '<tr>';
                html += '<td>' + proveedor.idproveedor + '</td>';
                html += '<td>' + proveedor.nombre + '</td>';
                html += '<td>' + proveedor.telefono + '</td>';
                html += '<td><button class="editar" data-id="' + proveedor.idproveedor + '" data-nombre="' + proveedor.nombre + '" data-telefono="' + proveedor.telefono + '">Actualizar</button>' +
                    ' <button class="eliminar" data-id="' + proveedor.idproveedor + '">Eliminar</button></td>';
                html += '</tr>';
            });
        } else {
            html += '<tr><td colspan="4">No se encontraron proveedores.</td></tr>';
        }

        html += '</tbody></table>';
        $('#listaProveedores').html(html);
    });
}

// También puedes agregar la opción de buscar al presionar la tecla "Enter"
$('#buscarNombre').on('keypress', function (e) {
    if (e.which == 13) { // Código para la tecla Enter
        var nombreBuscar = $(this).val();
        buscarProveedorPorNombre(nombreBuscar);
    }
});

// Cargar proveedores al inicio
$(document).ready(function () {
    cargarProveedores();
});


            


        });
    </script>
</body>
</html>
