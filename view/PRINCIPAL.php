<?php
session_start();
include '../controller/totalController.php'; 

// Verificar si el usuario está autenticado
if (!isset($_SESSION['usuario'])) {
    echo "<script>alert('Por favor, inicie sesión.'); window.location.href='../login.php';</script>";
    exit();
}

$usuario = $_SESSION['usuario']; // Guardar el nombre del usuario en una variable
$usuario_id = $_SESSION['usuario_id']; // Obtener el ID del usuario de la sesión

// Obtener total vendido hoy
$total_vendido_hoy = obtenerTotalVendidoHoy($usuario_id);

// Obtener la lista de ventas realizadas por el usuario
$ventas = obtenerVentas($usuario_id);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="../img//tienda2.gif" type="image/gif">
    <title>TIENDA</title>
    <link rel="stylesheet" href="../css/header.css">
    <link rel="stylesheet" href="../css/menus.css">
    <link rel="stylesheet" href="../css/contenido.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <header class="header">
        <nav class="navbar navbar-expand-lg navbar-light bg-transparent fixed-top">
            <div class="container1">
                <div class="container2">
                    <img class="log" src="../img/logo.jpg" >
                    <div>
                        <h1 class="navbar-brand fw-bold">SIGIV</h1>
                        <h1 class="navbar-brand fw-bold">Sistema de Gestión de Inventario y Ventas</h1>
                    </div>
                </div>

           

                <span id="fecha-actual" class="navbar-text"></span>
                
                <div class="bieneve">
                    <div>
                    <span class="navbar-text">BIENVENIDO, <?php echo htmlspecialchars($usuario); ?></span>
                    <div id="total-vendido" class="total-vendido">
                    <p>vendido hoy: $<?php echo number_format($total_vendido_hoy, 2); ?></p>
                </div>
                    </div>
                    <a class="btn btn-primary nav-btn" href="../CONTROLLER/cerrar.php"> <img class="btn-cerrar" src="../img/cerrar-sesion.gif" alt=""> Cerrar Sesión</a>
                    
                </div>
                
            </div>
        </nav>
    </header>
   
    <nav class="menu fixed-top">
        <ul>
            <li><a href="../view/PERFIL.php" class="toggle"><img class="iconos" src="../img/usuario.gif"> <h3 style="color: #343a40;">PERFIL</h3></a></li>
            <li>
                <a href="javascript:void(0)" class="toggle"><img class="iconos" src="../img/cumplimiento.gif"> <h3 style="color: #343a40;">INVENTARIO</h3></a>
                <ul>
                    <li style="display: flex;"><img src="../img/categoria.gif" alt=""><a href="./CATEGORIAS.php">CATEGORIAS</a></li>
                    <li style="display: flex;"><img src="../img/tienda.gif" alt=""><a href="./PROVEEDOR.php">PROVEEDOR</a></li>
                    <li style="display: flex;"><img src="../img/producto.gif" alt=""><a href="./PRODUCTOS.php">PRODUCTOS</a></li>
                </ul>
            </li>
            <li>
                <a href="javascript:void(0)" class="toggle"><img class="iconos" src="../img/venta.gif"> <h3 style="color: #343a40;">VENTAS</h3></a>
                <ul>
                    <li><img src="../img/ventas.gif" alt=""><a href="./VENTA.php">VENTA</a></li>
                    <li><img src="../img/factura.gif" alt=""><a href="./FACTURA.php">FACTURA</a></li>
                </ul>
            </li>
            
            

            
        </ul>
    </nav>

    <div id="content">
        <!-- Aquí se cargará el contenido de las páginas mediante AJAX -->
    </div>

    <script>
        $(document).ready(function() {
            // Función para formatear la fecha
            function formatearFecha(fecha) {
                const opciones = { year: 'numeric', month: 'long', day: 'numeric' };
                return fecha.toLocaleDateString('es-ES', opciones);
            }

            // Obtener la fecha actual
            const fechaActual = new Date();
            const fechaFormateada = formatearFecha(fechaActual);

            // Mostrar la fecha en el elemento con id 'fecha-actual'
            $('#fecha-actual').text(`   ${fechaFormateada}`);

            // Cargar el contenido de 'PERFIL' por defecto
            $.ajax({
                url: './PERFIL.php',
                method: 'GET',
                success: function(response) {
                    $('#content').html(response);
                },
                error: function(xhr, status, error) {
                    console.error('Error en AJAX: ' + error);
                }
            });

            // Manejar clicks en el menú
            $('.menu a').on('click', function(event) {
                event.preventDefault();
                var href = $(this).attr('href');

                if (href === '#') return;

                $.ajax({
                    url: href,
                    method: 'GET',
                    success: function(response) {
                        $('#content').html(response);
                    },
                    error: function(xhr, status, error) {
                        console.error('Error en AJAX: ' + error);
                    }
                });
            });

            // Mostrar/ocultar submenús
            $('.toggle').click(function() {
                $(this).next('ul').slideToggle(); // Alternar visibilidad del submenú
            });

            // Función para obtener el total vendido hoy
            function actualizarTotalVendido() {
                $.ajax({
                    url: '../controller/totalController.php', // Ruta al controlador
                    method: 'GET',
                    dataType: 'json',
                    data: { accion: 'obtener_total_vendido', usuario_id: <?php echo $usuario_id; ?> }, // Enviar ID de usuario
                    success: function(data) {
                        $('#total-vendido p').text(`Total vendido hoy: $${data.total_vendido_hoy}`);
                    },
                    error: function(xhr, status, error) {
                        console.error('Error en AJAX: ' + error);
                    }
                });
            }

            // Llamar a la función para la primera carga
            actualizarTotalVendido();

            // Actualizar el total vendido cada 5 segundos
            setInterval(actualizarTotalVendido, 5000); // 5000 ms = 5 segundos
        });
    </script>
</body>
</html>
