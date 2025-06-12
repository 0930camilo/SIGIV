<?php
session_start();
include '../controller/totalController.php';

// Validación de sesión
if (!isset($_SESSION['usuario'])) {
    echo "<script>alert('Por favor, inicie sesión.'); window.location.href='../login.php';</script>";
    exit();
}

$usuario = $_SESSION['usuario'];
$usuario_id = $_SESSION['usuario_id'];
$total_vendido_hoy = obtenerTotalVendidoHoy($usuario_id);
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="icon" href="../img/tienda2.gif" type="image/gif" />
    <title>TIENDA</title>
    <link rel="stylesheet" href="../css/header.css" />
    <link rel="stylesheet" href="../css/menu.css" />
    <link rel="stylesheet" href="../css/principal.css">
    <link rel="stylesheet" href="../css/contenido.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="bg-light">
<header class="mb-5">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="#">
                <img src="../img/logo.jpg" alt="Logo" />
                <div>
                    <div class="fw-bold">SIGIV</div>
                    <small>Sistema para Gestión de Inventario y Ventas</small>
                </div>
            </a>
            <span class="text-white me-auto ms-3" id="fecha-actual"></span>
            <div class="d-flex align-items-center gap-3">
                <div class="text-white text-end">
                    <div><strong>Bienvenido,</strong> <?= htmlspecialchars($usuario) ?></div>
                    <div id="total-vendido" class="text-success">
                        <strong>Vendido hoy:</strong> $<?= number_format($total_vendido_hoy, 2) ?>
                    </div>
                </div>
                <a href="../CONTROLLER/cerrar.php" class="btn btn-danger d-flex align-items-center">
                    <img src="../img/cerrar-sesion.gif" alt="Cerrar sesión" />
                    Cerrar Sesión
                </a>
            </div>
        </div>
    </nav>
</header>

<!-- Botón móvil -->
<button class="btn btn-primary m-3" id="toggleSidebarBtn">☰</button>

<!-- Sidebar -->
<div class="d-flex">
    <nav class="bg-white border-end p-1 sidebar" id="sidebar">
        <ul class="list-group">
            <li class="list-group-item border-0"><a href="./PERFIL.php" class="nav-link"><img src="../img/usuario.gif" class="menu-icon"> Perfil</a></li>

            <!-- Inventario -->
            <li class="list-group-item border-0">
                <a class="nav-link" data-bs-toggle="collapse" href="#inventarioMenu"><img src="../img/inventario.gif" class="menu-icon"> Inventario</a>
                <ul class="collapse list-unstyled ps-4 mt-1" id="inventarioMenu">
                    <li><a href="./CATEGORIAS.php" class="nav-link"><img src="../img/categoria.gif" class="menu-icon">Categorías</a></li>
                    <li><a href="./PROVEEDOR.php" class="nav-link"><img src="../img/tienda.gif" class="menu-icon">Proveedor</a></li>
                    <li><a href="./PRODUCTOS.php" class="nav-link"><img src="../img/producto.gif" class="menu-icon">Productos</a></li>
                </ul>
            </li>

            <!-- Ventas -->
            <li class="list-group-item border-0">
                <a class="nav-link" data-bs-toggle="collapse" href="#ventasMenu"><img src="../img/ventas.gif" class="menu-icon"> Ventas</a>
                <ul class="collapse list-unstyled ps-4 mt-1" id="ventasMenu">
                    <li><a href="./VENTA.php" class="nav-link"><img src="../img/venta.gif" class="menu-icon">Venta</a></li>
                    <li><a href="./FACTURA.php" class="nav-link"><img src="../img/factura.gif" class="menu-icon">Factura</a></li>
                </ul>
            </li>

            <!-- Cotización -->
            <li class="list-group-item border-0">
                <a class="nav-link" data-bs-toggle="collapse" href="#cotizaMenu"><img src="../img/cotiza.gif" class="menu-icon"> Cotización</a>
                <ul class="collapse list-unstyled ps-4 mt-1" id="cotizaMenu">
                    <li><a href="./COTIZACION.php" class="nav-link"><img src="../img/crear.gif" class="menu-icon">Crear</a></li>
                    <li><a href="./LISTACOTIZA.php" class="nav-link"><img src="../img/listar.gif" class="menu-icon">Mostrar</a></li>
                </ul>
            </li>

            <!-- Nómina -->
            <li class="list-group-item border-0">
                <a class="nav-link" data-bs-toggle="collapse" href="#nominaMenu"><img src="../img/nomina.gif" class="menu-icon"> Nómina</a>
                <ul class="collapse list-unstyled ps-4 mt-1" id="nominaMenu">
                    <li><a href="./NOMINA.PHP" class="nav-link"><img src="../img/crear.gif" class="menu-icon">Nóminas</a></li>
                    <li><a href="./PERSONAL.PHP" class="nav-link"><img src="../img/personal.gif" class="menu-icon">Personal</a></li>
                    <li><a href="./PERSONANOMINA.PHP" class="nav-link"><img src="../img/listaNomina.gif" class="menu-icon">Mostrar</a></li>
                </ul>
            </li>
        </ul>
    </nav>

    <!-- Contenido principal -->
    <main class="contenido-principal" id="content"></main>
</div>

<!-- Scripts -->
<script>
    $(document).ready(function () {
        const cargarContenido = (url) => {
            $.get(url, function (data) {
                $('#content').html(data);
            }).fail(function (xhr) {
                console.error("Error al cargar contenido:", xhr.responseText);
            });
        };

        // Mostrar fecha actual
        const formatearFecha = (fecha) =>
            fecha.toLocaleDateString("es-ES", {
                year: "numeric", month: "long", day: "numeric",
            });
        $("#fecha-actual").text(formatearFecha(new Date()));

        // Cargar PERFIL por defecto
        cargarContenido("./PERFIL.php");

        // Manejo del menú lateral
        $("nav ul.list-group").on("click", "li a", function (e) {
            const href = $(this).attr("href");
            if (href && !href.startsWith("#")) {
                e.preventDefault();
                cargarContenido(href);
                if ($(window).width() <= 768) $(".sidebar").removeClass("show");
            }
        });

        // Botón toggle de sidebar móvil
        $("#toggleSidebarBtn").on("click", () => $(".sidebar").toggleClass("show"));

        // Cerrar menú en móvil al hacer clic fuera
        $(document).on("click", function (e) {
            if ($(window).width() <= 768 && !$(e.target).closest(".sidebar, #toggleSidebarBtn").length) {
                $(".sidebar").removeClass("show");
            }
        });

        // Cierre manual de submenús si están abiertos
        $('.nav-link[data-bs-toggle="collapse"]').on("click", function (e) {
            const target = $(this).attr("href");
            if ($(target).hasClass("show")) {
                e.preventDefault();
                $(target).collapse("hide");
            }
        });

        // Total vendido (actualización automática)
        const actualizarTotalVendido = () => {
            $.getJSON("../controller/totalController.php", {
                accion: "obtener_total_vendido",
                usuario_id: <?= $usuario_id ?>
            }, function (data) {
                if (data?.total_vendido_hoy !== undefined) {
                    $("#total-vendido").html(
                        `<strong>Vendido hoy:</strong> $${parseFloat(data.total_vendido_hoy).toFixed(2)}`
                    );
                }
            }).fail(function (xhr) {
                console.error("Error al obtener total vendido:", xhr.responseText);
            });
        };

        actualizarTotalVendido();
        setInterval(actualizarTotalVendido, 5000); // cada 5 segundos
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
