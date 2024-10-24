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

$sql_categoria = "SELECT idcategoria, nombre 
                  FROM categoria 
                  WHERE usuario_idusuario = ? 
                  AND estado = 'activo'"; 
$stmt = mysqli_prepare($conn, $sql_categoria);
mysqli_stmt_bind_param($stmt, "i", $usuario_id);
mysqli_stmt_execute($stmt);
$result_categoria = mysqli_stmt_get_result($stmt);

$categorias = [];
while ($row_categoria = mysqli_fetch_assoc($result_categoria)) {
    $categorias[] = $row_categoria;
}
mysqli_stmt_close($stmt);

$sql_proveedor = "SELECT idproveedor, nombre 
                  FROM proveedor 
                  WHERE estado = 'activo' 
                  AND usuario_idusuario = ?"; // Filtrar por el usuario

$stmt_proveedor = $conn->prepare($sql_proveedor); // Preparar la consulta
$stmt_proveedor->bind_param("i", $usuario_id); // Vincular el parámetro
$stmt_proveedor->execute(); // Ejecutar la consulta
$result_proveedor = $stmt_proveedor->get_result(); // Obtener el resultado

$proveedores = [];
while ($row_proveedor = $result_proveedor->fetch_assoc()) {
    $proveedores[] = $row_proveedor; // Agregar cada proveedor a la lista
}

mysqli_close($conn);
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Productos</title>
    <link rel="stylesheet" href="../css/produc.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h1 class="h1">Gestión Producto</h1>
            <form id="formProducto">
                <div>
                <input type="hidden" id="idproducto" name="idproducto">
                <label for="nombre">Nombre del Producto:</label>
                <input type="text" id="nombre" name="nombre" required>
                
                <label for="descripcion">Descripción:</label>
                <input type="text" id="descripcion" name="descripcion">
                
                <label for="cantidad">Cantidad:</label>
                <input class="num" type="number" id="cantidad" name="cantidad" required>
                </div>

                <div>
                <label for="precioCompra">Precio de Compra:</label>
                <input class="num"type="number" id="precioCompra" name="precioCompra" step="0.01" required>
                
                <label for="precio">Precio de Venta:</label>
                <input type="number" id="precio" name="precio" step="0.01" required>
                </div>
                <label for="categoria_idcategoria">Categoría:</label>
                <select id="categoria_idcategoria" name="categoria_idcategoria" required>
                    <option value="">Seleccionar Categoría</option>
                    <?php foreach ($categorias as $categoria): ?>
                        <option value="<?php echo htmlspecialchars($categoria['idcategoria']); ?>">
                            <?php echo htmlspecialchars($categoria['nombre']); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
                
                <label for="proveedor_idproveedor">Proveedor:</label>
                <select id="proveedor_idproveedor" name="proveedor_idproveedor" required>
                    <option value="">Seleccionar Proveedor</option>
                    <?php foreach ($proveedores as $proveedor): ?>
                        <option value="<?php echo htmlspecialchars($proveedor['idproveedor']); ?>">
                            <?php echo htmlspecialchars($proveedor['nombre']); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
                
                <button type="submit">Guardar Producto</button>
            </form>
            
        </div>
        <h1 class="h1">PRODUCTOS</h1>
            <label  for="categoriaFiltro">Filtrar por Categoría:</label>
            <select   id="categoriaFiltro">
                <option value="todos">Todos</option>
                <?php foreach ($categorias as $categoria): ?>
                    <option value="<?php echo htmlspecialchars($categoria['idcategoria']); ?>">
                        <?php echo htmlspecialchars($categoria['nombre']); ?>
                    </option>
                <?php endforeach; ?>
            </select>


            <label for="nombreBuscar">Buscar Producto:</label>
      <input  type="text" id="nombreBuscar" name="nombreBuscar" placeholder="Nombre del Producto">
      <button id="btnBuscar">Buscar</button>


        <div class="list-container">
            
            
            <table class="product" id="tablaProductos">
                <thead  >
                    <tr class="product">
                        <th >ID</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Cantidad</th>
                        <th>Precio Compra</th>
                        <th>Precio Venta</th>
                        <th>Categoría</th>
                        <th>Proveedor</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody class="date">
                    <!-- Los productos se llenarán aquí mediante JavaScript -->
                </tbody>
            </table>
        </div>
    </div>
    
    <script>$(document).ready(function() {

// Función para cargar productos
function cargarProductos(categoriaFiltro = 'todos', nombreBuscar = '') {
    $.ajax({
        url: '../controller/ProductoController.php',
        method: 'POST',
        data: {
            accion: 'cargar',
            categoriaFiltro: categoriaFiltro,
            nombreBuscar: nombreBuscar,
            timestamp: new Date().getTime()
        },
        success: function(response) {
            const data = JSON.parse(response);
            if (data.status === 'success') {
                const productos = data.productos;
                const tbody = $('#tablaProductos tbody');
                tbody.empty();
                productos.forEach(function(producto) {
                    tbody.append(
                        `<tr class="product">
                            <td>${producto.idproducto}</td>
                            <td>${producto.nombre}</td>
                            <td>${producto.descripcion}</td>
                            <td>${producto.cantidad}</td>
                            <td>${producto.precioCompra}</td>
                            <td>${producto.precio}</td>
                            <td>${producto.categoriaNombre}</td>
                            <td>${producto.proveedorNombre}</td>
                            <td>
                                <button class="btn-editar" data-id="${producto.idproducto}">Actualizar</button>
                                <button class="btn-eliminar" data-id="${producto.idproducto}">Eliminar</button>
                            </td>
                        </tr>`
                    );
                });
            } else {
                alert('Error: ' + data.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('Error en AJAX: ' + error);
        }
    });
}

// Función para cargar proveedores
function cargarProveedores() {
    $.ajax({
        url: '../controller/ProductoController.php',
        method: 'POST',
        data: { accion: 'cargarProveedores' },
        success: function(response) {
            console.log('Respuesta de proveedores:', response);
            const data = JSON.parse(response);
            if (data.status === 'success') {
                const proveedores = data.proveedores;
                const proveedorSelect = $('#proveedor_idproveedor');
                proveedorSelect.empty();
                proveedorSelect.append('<option value="">Seleccionar Proveedor</option>');
                proveedores.forEach(function(proveedor) {
                    proveedorSelect.append(
                        `<option value="${proveedor.idproveedor}">${proveedor.nombre}</option>`
                    );
                });
            } else {
                console.error('Error al cargar proveedores:', data.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('Error en AJAX: ' + error);
        }
    });
}

// Cargar productos al iniciar
cargarProductos();

// Cargar proveedores al iniciar
cargarProveedores();

// Cargar productos al filtrar por categoría
$('#categoriaFiltro').change(function() {
    const categoriaFiltro = $(this).val();
    const nombreBuscar = $('#nombreBuscar').val(); // Obtener el valor del campo de búsqueda
    cargarProductos(categoriaFiltro, nombreBuscar);
});

// Manejar el evento de búsqueda
$('#btnBuscar').click(function() {
    const categoriaFiltro = $('#categoriaFiltro').val(); // Obtener la categoría seleccionada
    const nombreBuscar = $('#nombreBuscar').val(); // Obtener el valor del campo de búsqueda
    cargarProductos(categoriaFiltro, nombreBuscar);
});

// Agregar evento para la tecla "Enter" en el campo de búsqueda
$('#nombreBuscar').keypress(function(event) {
    if (event.which === 13) { // Verificar si la tecla presionada es "Enter"
        event.preventDefault(); // Prevenir el envío del formulario
        const categoriaFiltro = $('#categoriaFiltro').val(); // Obtener la categoría seleccionada
        const nombreBuscar = $(this).val(); // Obtener el valor del campo de búsqueda
        cargarProductos(categoriaFiltro, nombreBuscar);
    }
});

// Manejar el formulario de productos
$('#formProducto').submit(function(event) {
    event.preventDefault();
    const formData = $(this).serialize();
    $.ajax({
        url: '../controller/ProductoController.php',
        method: 'POST',
        data: formData + '&accion=guardar',
        success: function(response) {
            const data = JSON.parse(response);
            if (data.status === 'success') {
                alert('Producto guardado con éxito.');
                $('#formProducto')[0].reset();
                $('#idproducto').val('');  // Reiniciar el ID del producto
                cargarProductos();
            } else {
                alert('Error: ' + data.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('Error en AJAX: ' + error);
        }
    });
});

// Editar producto
$('#tablaProductos').on('click', '.btn-editar', function() {
    const idproducto = $(this).data('id');
    $.ajax({
        url: '../controller/ProductoController.php',
        method: 'POST',
        data: { accion: 'editar', idproducto: idproducto },
        success: function(response) {
            const data = JSON.parse(response);
            if (data.status === 'success') {
                const producto = data.producto;
                $('#idproducto').val(producto.idproducto);
                $('#nombre').val(producto.nombre);
                $('#descripcion').val(producto.descripcion);
                $('#cantidad').val(producto.cantidad);
                $('#precioCompra').val(producto.precioCompra);
                $('#precio').val(producto.precio);
                $('#categoria_idcategoria').val(producto.categoria_idcategoria);
                $('#proveedor_idproveedor').val(producto.proveedor_idproveedor);
            } else {
                alert('Error: ' + data.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('Error en AJAX: ' + error);
        }
    });
});

// Eliminar producto
$('#tablaProductos').on('click', '.btn-eliminar', function() {
    const idproducto = $(this).data('id');
    if (confirm('¿Estás seguro de que quieres eliminar este producto?')) {
        $.ajax({
            url: '../controller/ProductoController.php',
            method: 'POST',
            data: { accion: 'eliminar', idproducto: idproducto },
            success: function(response) {
                const data = JSON.parse(response);
                if (data.status === 'success') {
                    alert('Producto eliminado con éxito.');
                    cargarProductos();
                    cargarProveedores(); // Actualizar la lista de proveedores
                } else {
                    alert('Error: ' + data.message);
                }
            },
            error: function(xhr, status, error) {
                console.error('Error en AJAX: ' + error);
            }
        });
    }
});

});

</script>

</body>
</html>
