<?php
session_start();
include '../controller/ventasController.php';


if (!isset($_SESSION['usuario'])) {
    echo "<script>alert('Por favor, inicie sesión.'); window.location.href='../login.php';</script>";
    exit();
}

if (!isset($_SESSION['usuario_id'])) {
    echo "<script>alert('No se pudo obtener el ID de usuario.'); window.location.href='../login.php';</script>";
    exit();
}

$usuario_id = $_SESSION['usuario_id'];
$productos = listarProductos(); // Obtener productos disponibles
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Venta</title>
    <link rel="stylesheet" href="../css/ventas.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  
</head>

<body>

<div class="vent" >
    
   <div class="ve">

  
    <div class="venta"  >

    <h1>Crear Venta</h1>

<div id="carrito-contenido">
    <!-- El contenido del carrito se cargará aquí con AJAX -->
</div>

    </div>

    <div class="lista">
    <h2>Productos Disponibles</h2>
    
    <!-- Filtro por categoría -->
    <select  id="filtro-categoria">
        <option value="todos">Todas las Categorías</option>
        <!-- Las categorías se cargarán aquí con AJAX -->
    </select>

    <input class="buscar-nombre"  type="text" id="buscar-nombre" placeholder="Buscar producto por nombre">
    <button class="btn-buscar" id="btn-buscar" type="button">Buscar</button>

    <div class="list" >
   

    <table border="1" id="productos-table">
        <thead class="tabla" >
            <tr>
                <th >Nombre</th>
                <th>Descripción</th>
                <th>Precio</th>
                <th>Disponibles</th>
                <th>Cantidad</th>
            
            </tr>
        </thead>
        <tbody>
            <!-- Los productos se cargarán aquí con AJAX -->
        </tbody>
    </table>

    </div>
    </div>
    </div> 


    <script>
$(document).ready(function() {
    // Función para cargar el contenido del carrito
    function cargarCarrito() {
        $.ajax({
            url: '../controller/cargarCarrito.php',
            method: 'GET',
            success: function(response) {
                $('#carrito-contenido').html(response);
            }
        });
    }
    function buscarProductoPorNombre() {
    var nombreProducto = $('#buscar-nombre').val();
    $.ajax({
        url: '../controller/ventasController.php',
        method: 'POST',
        data: { accion: 'buscarPorNombre', nombre_producto: nombreProducto },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                var tableBody = $('#productos-table tbody');
                tableBody.empty(); // Limpiar los productos anteriores

                // Iterar sobre los productos devueltos
                $.each(response.productos, function(index, producto) {
                    // Usar template literals (``) en lugar de concatenar con '+'
                    tableBody.append(`
                        <tr>
                            <td>${producto.nombre}</td>
                            <td>${producto.descripcion}</td>
                            <td>${producto.precio}</td>
                            <td>${producto.cantidad}</td>
                            <td>
                                <div class="agregar-producto">
                                    <form class="agregar-producto-form" data-producto-id="${producto.idproducto}">
                                        <input type="hidden" name="producto_id" value="${producto.idproducto}">
                                        
                                        <!-- Cuadro de número -->
                                        <input type="number" name="cantidad" min="1" max="${producto.cantidad}" value="1" required>
                                        
                                        <!-- Botón de agregar -->
                                        <button type="submit">Agregar</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    `);
                });
            }
        }
    });
}

// Manejar el evento de clic del botón de búsqueda
$('#btn-buscar').on('click', function() {
    buscarProductoPorNombre();
});

// También puedes agregar la opción de buscar al presionar la tecla "Enter"
$('#buscar-nombre').on('keypress', function(e) {
    if (e.which == 13) { // Código para la tecla Enter
        buscarProductoPorNombre();
    }
});


    // Manejar la eliminación de productos del carrito
    $(document).on('submit', '.eliminar-producto-form', function(e) {
        e.preventDefault(); // Previene la acción por defecto del formulario

        var form = $(this);
        $.ajax({
            url: '../controller/ventasController.php',
            method: 'POST',
            data: form.serialize(),
            success: function(response) {
                // Actualizar el contenido del carrito después de la eliminación
                cargarCarrito();
            },
            error: function() {
                alert('Hubo un error al eliminar el producto del carrito.');
            }
        });
    });

    // Cargar categorías y productos al inicio
    function cargarCategorias() {
        $.ajax({
            url: '../controller/ventasController.php',
            method: 'POST',
            data: { accion: 'cargarCategorias' },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    var filtro = $('#filtro-categoria');
                    filtro.empty();
                    filtro.append('<option value="todos">Todas las Categorías</option>');
                    $.each(response.categorias, function(index, categoria) {
                        filtro.append('<option value="' + categoria.idcategoria + '">' + categoria.nombre + '</option>');
                    });
                } else if (response.error) {
                    alert(response.error);
                }
            }
        });
    }

    // Cargar los productos con filtrado
    function cargarProductos(categoriaFiltro = 'todos') {
        $.ajax({
            url: '../controller/ventasController.php',
            method: 'POST',
            data: { obtener_productos: true, categoria_idcategoria: categoriaFiltro },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    var tableBody = $('#productos-table tbody');
                    tableBody.empty(); // Limpiar el contenido anterior
                    response.productos.forEach(function(producto) {
    tableBody.append(
        `<tr class="tablas">

    <td>${producto.nombre}</td>
    <td>${producto.descripcion}</td>
    <td>$${producto.precio}</td>
    <td>${producto.cantidad}</td>
    <td>
        <div class="agregar-producto" >
            <form class="agregar-producto-form" data-producto-id="${producto.idproducto}" >
                <input type="hidden" name="producto_id" value="${producto.idproducto}">
                
                <!-- El cuadro de número -->
                <input type="number" name="cantidad" min="1" max="${producto.cantidad}" value="1" required 
                       >
                
                <!-- El botón de agregar, ahora al lado del campo de entrada -->
                <button type="submit" >Agregar</button>
            </form>
        </div>
    </td>


    
</tr>`
    );
});


                } else if (response.error) {
                    alert(response.error);
                }
            }
        });
    }

    // Manejar el filtro de categoría
    $('#filtro-categoria').on('change', function() {
        var categoriaFiltro = $(this).val();
        cargarProductos(categoriaFiltro);
    });

    // Manejar la adición de productos al carrito
    $(document).on('submit', '.agregar-producto-form', function(e) {
        e.preventDefault();

        var form = $(this);
        $.ajax({
            url: '../controller/ventasController.php',
            method: 'POST',
            data: form.serialize(),
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    cargarCarrito();
                    // Recargar productos después de agregar un producto
                    cargarProductos($('#filtro-categoria').val());
                } else if (response.error) {
                    alert(response.error);
                }
            }
        });
    });

      // Cargar categorías, productos y carrito al inicio
    cargarCategorias();
    cargarProductos();
    cargarCarrito();
});
</script>

</div>

</body>
</html>
