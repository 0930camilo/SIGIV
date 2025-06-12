-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-05-2025 a las 00:11:42
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sigiv`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `Nombre` varchar(50) NOT NULL,
  `Clave` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`Nombre`, `Clave`) VALUES
('camilo perez', '0903');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idcategoria` int(10) UNSIGNED NOT NULL,
  `usuario_idusuario` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `estado` enum('activo','inactivo') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`idcategoria`, `usuario_idusuario`, `nombre`, `estado`) VALUES
(1, 1, 'Herramientas eléctricas', 'activo'),
(3, 1, 'Tornillería y fijaciones', 'activo'),
(5, 1, 'Fontanería y tuberías', 'activo'),
(6, 1, 'Electricidad e iluminación', 'activo'),
(7, 1, 'Seguridad industrial y protección', 'activo'),
(8, 1, 'Jardinería y agricultura', 'activo'),
(9, 1, 'Adhesivos, selladores y siliconas', 'activo'),
(10, 1, 'Ferretería en general', 'activo'),
(11, 1, 'Cerrajería y candados', 'activo'),
(12, 1, 'Plomería y accesorios para baño', 'activo'),
(13, 1, 'Construcción en seco (drywall)', 'activo'),
(14, 1, 'Abrasivos y discos de corte', 'activo'),
(15, 1, 'Lubricantes y grasas', 'activo'),
(16, 1, 'Mallas, alambres y cercas', 'activo'),
(17, 1, 'Accesorios para carpintería', 'activo'),
(18, 1, 'Vidrios y acrílicos', 'activo'),
(19, 1, 'Pisos y revestimientos', 'activo'),
(20, 1, 'Motores y generadores', 'activo'),
(23, 1, 'Equipos de medición y nivelación', 'activo'),
(24, 1, 'Impermeabilizantes', 'activo'),
(25, 1, 'tanques', 'activo'),
(26, 1, 'Telas asfálticas y aislamientos', 'activo'),
(27, 1, 'Sistemas de riego y drenaje', 'activo'),
(28, 1, 'Paneles solares y energías renovables', 'activo'),
(29, 1, 'Cintas adhesivas y empaques', 'activo'),
(30, 1, 'Señalización y seguridad vial', 'activo'),
(31, 1, 'Mobiliario para construcción', 'activo'),
(32, 1, 'Andamios y escaleras', 'activo'),
(33, 1, 'EPP (Equipos de Protección Personal)', 'activo'),
(34, 1, 'Cables y conectores eléctricos', 'activo'),
(35, 1, 'Automatización y domótica', 'activo'),
(36, 1, 'Iluminación LED y bombillas', 'activo'),
(37, 1, 'Soldadura y accesorios', 'activo'),
(38, 1, 'Neumáticos y accesorios para vehículos', 'activo'),
(39, 1, 'Herramientas neumáticas', 'activo'),
(40, 1, 'Calefacción y aire acondicionado', 'activo'),
(41, 1, 'Rejas, puertas y estructuras metálicas', 'activo'),
(43, 1, 'Maderas y tableros', 'activo'),
(48, 1, 'Productos de limpieza industrial', 'activo'),
(49, 1, 'Toldos, lonas y carpas', 'activo'),
(50, 1, 'Protección contra incendios', 'activo'),
(51, 1, 'cemento', 'activo'),
(52, 1, 'Ladrillo', 'activo'),
(53, 1, 'Bloque de Concreto', 'activo'),
(54, 1, 'arena', 'activo'),
(55, 1, 'Varilla', 'activo'),
(56, 1, 'Lámina de Drywall', 'activo'),
(57, 1, 'Yeso', 'activo'),
(58, 1, 'pinturas', 'activo'),
(59, 1, 'herramientas manuales', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizacion`
--

CREATE TABLE `cotizacion` (
  `idcotizacion` int(10) UNSIGNED NOT NULL,
  `usuario_idusuario` int(10) UNSIGNED NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `nombre_cliente` varchar(100) DEFAULT NULL,
  `telefono_cliente` varchar(20) DEFAULT NULL,
  `total` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cotizacion`
--

INSERT INTO `cotizacion` (`idcotizacion`, `usuario_idusuario`, `fecha`, `nombre_cliente`, `telefono_cliente`, `total`) VALUES
(1, 1, '2025-04-01 20:50:27', 'ana', '1313', '2000.00'),
(2, 1, '2025-04-01 21:00:14', 'dds', '343', '23.00'),
(3, 1, '2025-04-02 20:26:55', 'juna', '1212', '5000.00'),
(4, 1, '2025-04-04 20:33:57', '', '', '15000.00'),
(5, 1, '2025-04-04 21:28:24', '', '', '25000.00'),
(6, 1, '2025-04-04 21:48:30', '', '3147025585', '10000.00'),
(7, 1, '2025-04-04 21:51:05', '', '3009873791', '5000.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_cotizacion`
--

CREATE TABLE `detalle_cotizacion` (
  `iddetalle` int(10) UNSIGNED NOT NULL,
  `cotizacion_idcotizacion` int(10) UNSIGNED NOT NULL,
  `producto_idproducto` int(10) UNSIGNED NOT NULL,
  `cantidad` int(10) UNSIGNED NOT NULL,
  `precio` decimal(15,2) NOT NULL,
  `subtotal` decimal(15,2) GENERATED ALWAYS AS (`cantidad` * `precio`) STORED,
  `descripcion_producto` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalle_cotizacion`
--

INSERT INTO `detalle_cotizacion` (`iddetalle`, `cotizacion_idcotizacion`, `producto_idproducto`, `cantidad`, `precio`, `descripcion_producto`) VALUES
(1, 1, 1672, 2, '2000.00', 'hasdhas'),
(3, 2, 1, 2, '300.00', 'dsad'),
(4, 3, 1, 1, '5000.00', NULL),
(5, 4, 1, 3, '5000.00', NULL),
(6, 5, 1, 1, '5000.00', NULL),
(7, 5, 2, 4, '5000.00', NULL),
(8, 6, 1, 1, '5000.00', NULL),
(9, 6, 2, 1, '5000.00', NULL),
(10, 7, 1, 1, '5000.00', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ventas`
--

CREATE TABLE `detalle_ventas` (
  `iddetalle` int(10) UNSIGNED NOT NULL,
  `venta_idventa` int(10) UNSIGNED NOT NULL,
  `producto_idproducto` int(10) UNSIGNED NOT NULL,
  `cantidad` int(10) UNSIGNED NOT NULL,
  `precio` decimal(15,2) NOT NULL,
  `subtotal` decimal(15,2) GENERATED ALWAYS AS (`cantidad` * `precio`) STORED,
  `descripcion_producto` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalle_ventas`
--

INSERT INTO `detalle_ventas` (`iddetalle`, `venta_idventa`, `producto_idproducto`, `cantidad`, `precio`, `descripcion_producto`) VALUES
(670, 206, 1, 1, '5000.00', NULL),
(671, 207, 1, 2, '5000.00', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nomina`
--

CREATE TABLE `nomina` (
  `idnomina` int(10) UNSIGNED NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `total_pago` decimal(10,2) DEFAULT 0.00,
  `usuario_idusuario` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `nomina`
--

INSERT INTO `nomina` (`idnomina`, `descripcion`, `fecha_inicio`, `fecha_fin`, `total_pago`, `usuario_idusuario`) VALUES
(1, 'prue', '2025-04-01', '2025-04-17', '0.00', 1),
(3, 'frebrero', '2025-03-31', '2025-04-22', '0.00', 1),
(4, 'dsadasf', '2025-02-23', '2025-04-29', '0.00', 24);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idpersona` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `estado` enum('activo','inactivo') DEFAULT 'activo',
  `usuario_idusuario` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idpersona`, `nombre`, `correo`, `telefono`, `direccion`, `fecha_nacimiento`, `fecha_ingreso`, `estado`, `usuario_idusuario`) VALUES
(1, 'adis', 'ad@gmail.com', '3147025585', 'k7 #28-10', '2025-04-02', '2025-05-08', 'activo', 1),
(2, 'jose', 'jose@gmail.com', '000000', 'cda', '2025-04-01', '2025-05-14', 'activo', 24);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona_nomina`
--

CREATE TABLE `persona_nomina` (
  `idpersona` int(10) UNSIGNED NOT NULL,
  `idnomina` int(10) UNSIGNED NOT NULL,
  `dias_trabajados` int(11) NOT NULL,
  `valor_dia` decimal(10,2) NOT NULL,
  `salario` decimal(10,2) GENERATED ALWAYS AS (`dias_trabajados` * `valor_dia`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `idproducto` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `cantidad` int(10) UNSIGNED DEFAULT NULL,
  `precioCompra` decimal(15,2) NOT NULL,
  `precio` decimal(15,2) DEFAULT NULL,
  `usuario_idusuario` int(10) UNSIGNED NOT NULL,
  `categoria_idcategoria` int(10) UNSIGNED NOT NULL,
  `proveedor_idproveedor` int(10) UNSIGNED DEFAULT NULL,
  `estado` enum('activo','inactivo') DEFAULT 'activo',
  `fecha` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`idproducto`, `nombre`, `descripcion`, `cantidad`, `precioCompra`, `precio`, `usuario_idusuario`, `categoria_idcategoria`, `proveedor_idproveedor`, `estado`, `fecha`) VALUES
(1, 'Atornillador Eléctrico', 'Atornillador rápido y eficiente con batería recargable', 18, '3000.00', '5000.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(2, 'Sierra Circular', 'Sierra de alta potencia para cortes precisos', 255, '2200.00', '5000.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(3, 'Sierra Caladora', 'Sierra para cortes curvos y detallados', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(4, 'Amoladora Angular', 'Herramienta para cortar y desbastar metales', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(5, 'Lijadora Orbital', 'Lijadora de acabado fino para madera y metal', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(6, 'Lijadora de Banda', 'Lijadora potente para superficies grandes', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(7, 'Rotomartillo', 'Herramienta de perforación para concreto', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(8, 'Cepillo Eléctrico', 'Herramienta para rebajar madera con precisión', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(9, 'Multiherramienta Oscilante', 'Para cortes y lijados precisos en múltiples materiales', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(10, 'Clavadora Neumática', 'Para fijación de clavos de forma rápida y eficiente', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(11, 'Engrapadora Eléctrica', 'Para fijación rápida en tapicería y trabajos manuales', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(12, 'Soldadora Inverter', 'Equipo de soldadura con electrodo revestido', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(13, 'Dremel / Mini Amoladora', 'Herramienta rotativa para tallado y pulido', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(14, 'Pulidora de Autos', 'Para abrillantar y pulir carrocerías', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(15, 'Pistola de Calor', 'Para decapar pintura y otros usos industriales', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(16, 'Compresor de Aire', 'Suministro de aire comprimido para herramientas neumáticas', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(17, 'Desbrozadora Eléctrica', 'Herramienta para cortar césped y maleza', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(18, 'Hidrolavadora', 'Máquina de limpieza a presión', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(19, 'Cortasetos Eléctrico', 'Herramienta para el mantenimiento de arbustos', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(20, 'Taladro Percutor', 'Taladro con función de percusión y múltiples velocidades', 0, '0.00', '0.00', 1, 1, 1, 'activo', '2025-02-24 19:38:51'),
(40, 'Cemento Portland Gris 50kg', 'Cemento Portland tipo I en saco de 50 kg', 0, '0.00', '0.00', 1, 51, 1, 'activo', '2025-02-25 18:15:47'),
(41, 'Cemento Portland Blanco 50kg', 'Cemento Portland blanco para acabados y decoraciones', 0, '0.00', '0.00', 1, 51, 1, 'activo', '2025-02-25 18:15:47'),
(42, 'Cemento Tipo II 50kg', 'Cemento de resistencia moderada a sulfatos, ideal para estructuras hidráulicas', 0, '0.00', '0.00', 1, 51, 1, 'activo', '2025-02-25 18:15:47'),
(43, 'Cemento Tipo III 50kg', 'Cemento de alta resistencia inicial, ideal para obras rápidas', 0, '0.00', '0.00', 1, 51, 1, 'activo', '2025-02-25 18:15:47'),
(44, 'Cemento Estructural 42.5kg', 'Cemento diseñado para estructuras de concreto armado', 0, '0.00', '0.00', 1, 51, 1, 'activo', '2025-02-25 18:15:47'),
(45, 'Cemento Antisulfato 50kg', 'Cemento resistente a ambientes agresivos con alto contenido de sulfatos', 0, '0.00', '0.00', 1, 51, 1, 'activo', '2025-02-25 18:15:47'),
(46, 'Cemento Rápido 25kg', 'Cemento de fraguado rápido para reparaciones y fijaciones', 0, '0.00', '0.00', 1, 51, 1, 'activo', '2025-02-25 18:15:47'),
(47, 'Cemento Impermeable 50kg', 'Cemento con aditivos hidrófugos para reducir la absorción de agua', 0, '0.00', '0.00', 1, 51, 1, 'activo', '2025-02-25 18:15:47'),
(48, 'Cemento Holcim Extra 50kg', 'Cemento de alta resistencia, ideal para construcción general', 0, '0.00', '0.00', 1, 51, 1, 'activo', '2025-02-25 18:15:47'),
(49, 'Cemento Argos Uso General 50kg', 'Cemento de alta calidad para construcción y estructuras', 0, '0.00', '0.00', 1, 51, 1, 'activo', '2025-02-25 18:15:47'),
(50, 'Cemento Cemex Tolteca 50kg', 'Cemento de resistencia superior, ideal para concreto reforzado', 0, '0.00', '0.00', 1, 51, 1, 'activo', '2025-02-25 18:15:47'),
(51, 'Ladrillo Macizo', 'Ladrillo sin perforaciones, ideal para muros de carga.', 0, '0.00', '0.00', 1, 52, 1, 'activo', '2025-02-25 18:25:05'),
(52, 'Ladrillo Perforado', 'Ladrillo con perforaciones para reducir peso y mejorar adherencia.', 0, '0.00', '0.00', 1, 52, 1, 'activo', '2025-02-25 18:25:05'),
(53, 'Ladrillo Hueco', 'Ladrillo con huecos internos, utilizado para reducir peso en paredes.', 0, '0.00', '0.00', 1, 52, 1, 'activo', '2025-02-25 18:25:05'),
(54, 'Ladrillo Refractario', 'Resistente a altas temperaturas, ideal para hornos y chimeneas.', 0, '0.00', '0.00', 1, 52, 1, 'activo', '2025-02-25 18:25:05'),
(55, 'Ladrillo de Vidrio', 'Ladrillo decorativo que permite el paso de luz.', 0, '0.00', '0.00', 1, 52, 1, 'activo', '2025-02-25 18:25:05'),
(56, 'Ladrillo Ecológico', 'Fabricado con materiales reciclados, más amigable con el ambiente.', 0, '0.00', '0.00', 1, 52, 1, 'activo', '2025-02-25 18:25:05'),
(57, 'Ladrillo Silico-Calizo', 'Mezcla de arena y cal, con alta resistencia y precisión.', 0, '0.00', '0.00', 1, 52, 1, 'activo', '2025-02-25 18:25:05'),
(58, 'Ladrillo Termoarcilla', 'Ladrillo con cámaras de aire para mejor aislamiento térmico.', 0, '0.00', '0.00', 1, 52, 1, 'activo', '2025-02-25 18:25:05'),
(59, 'Ladrillo de Adobe', 'Hecho de barro secado al sol, utilizado en construcciones tradicionales.', 0, '0.00', '0.00', 1, 52, 1, 'activo', '2025-02-25 18:25:05'),
(60, 'Ladrillo Caravista', 'Diseñado para quedar a la vista sin necesidad de revestimiento.', 0, '0.00', '0.00', 1, 52, 1, 'activo', '2025-02-25 18:25:05'),
(61, 'Ladrillo de Fachada', 'Mayor resistencia a la intemperie, ideal para exteriores.', 0, '0.00', '0.00', 1, 52, 1, 'activo', '2025-02-25 18:25:05'),
(62, 'Ladrillo de Hormigón', 'Fabricado con cemento y áridos, muy resistente.', 0, '0.00', '0.00', 1, 52, 1, 'activo', '2025-02-25 18:25:05'),
(63, 'Ladrillo Decorativo', 'Diseñado con formas y colores para acabados estéticos.', 0, '0.00', '0.00', 1, 52, 1, 'activo', '2025-02-25 18:25:05'),
(64, 'Ladrillo de Tejar', 'Ladrillo artesanal hecho a mano, con acabado rústico.', 0, '0.00', '0.00', 1, 52, 1, 'activo', '2025-02-25 18:25:05'),
(65, 'Bloque de Concreto Estandar', 'Bloque sólido de concreto para construcción de muros.', 0, '0.00', '0.00', 1, 53, 1, 'activo', '2025-02-25 18:29:42'),
(66, 'Bloque de Concreto Hueco', 'Bloque con cavidades internas para reducir peso y facilitar instalación.', 0, '0.00', '0.00', 1, 53, 1, 'activo', '2025-02-25 18:29:42'),
(67, 'Bloque de Concreto para Mampostería', 'Bloque diseñado para muros estructurales con alta resistencia.', 0, '0.00', '0.00', 1, 53, 1, 'activo', '2025-02-25 18:29:42'),
(68, 'Bloque de Concreto Tipo Split', 'Bloque con acabado rústico, usado en fachadas.', 0, '0.00', '0.00', 1, 53, 1, 'activo', '2025-02-25 18:29:42'),
(69, 'Bloque de Concreto Celular', 'Material liviano con aislamiento térmico y acústico.', 0, '0.00', '0.00', 1, 53, 1, 'activo', '2025-02-25 18:29:42'),
(70, 'Bloque de Concreto Curvo', 'Diseñado para estructuras con formas circulares.', 0, '0.00', '0.00', 1, 53, 1, 'activo', '2025-02-25 18:29:42'),
(71, 'Bloque de Concreto de Alta Resistencia', 'Bloque con mayor densidad y resistencia estructural.', 0, '0.00', '0.00', 1, 53, 1, 'activo', '2025-02-25 18:29:42'),
(72, 'Bloque de Concreto para Pavimentación', 'Bloque usado en suelos, calles y caminos peatonales.', 0, '0.00', '0.00', 1, 53, 1, 'activo', '2025-02-25 18:29:42'),
(73, 'Bloque de Concreto Permeable', 'Permite la filtración del agua para drenaje ecológico.', 0, '0.00', '0.00', 1, 53, 1, 'activo', '2025-02-25 18:29:42'),
(74, 'Bloque de Concreto con Aislamiento', 'Incorpora material aislante térmico en su interior.', 0, '0.00', '0.00', 1, 53, 1, 'activo', '2025-02-25 18:29:42'),
(75, 'Arena Fina', 'Arena con grano fino, ideal para acabados y mezclas de mortero.', 0, '0.00', '0.00', 1, 54, 1, 'activo', '2025-02-25 18:31:11'),
(76, 'Arena Gruesa', 'Arena con grano grueso, utilizada para estructuras de concreto.', 0, '0.00', '0.00', 1, 54, 1, 'activo', '2025-02-25 18:31:11'),
(77, 'Arena Lavada', 'Arena tratada para eliminar impurezas, usada en morteros y concretos.', 0, '0.00', '0.00', 1, 54, 1, 'activo', '2025-02-25 18:31:11'),
(78, 'Arena de Río', 'Arena natural extraída de ríos, ideal para mezclas de construcción.', 0, '0.00', '0.00', 1, 54, 1, 'activo', '2025-02-25 18:31:11'),
(79, 'Arena de Cantera', 'Arena obtenida de canteras, utilizada en rellenos y nivelaciones.', 0, '0.00', '0.00', 1, 54, 1, 'activo', '2025-02-25 18:31:11'),
(80, 'Arena Triturada', 'Arena artificial obtenida por trituración de piedra, usada en concreto.', 0, '0.00', '0.00', 1, 54, 1, 'activo', '2025-02-25 18:31:11'),
(81, 'Arena Silícea', 'Arena con alto contenido de sílice, utilizada en fundición y vidrio.', 0, '0.00', '0.00', 1, 54, 1, 'activo', '2025-02-25 18:31:11'),
(82, 'Arena para Filtro', 'Arena especializada para sistemas de filtración y tratamiento de agua.', 0, '0.00', '0.00', 1, 54, 1, 'activo', '2025-02-25 18:31:11'),
(83, 'Arena para Enlucido', 'Arena con grano uniforme, usada en revestimientos y acabados finos.', 0, '0.00', '0.00', 1, 54, 1, 'activo', '2025-02-25 18:31:11'),
(84, 'Arena para Hormigón', 'Arena seleccionada para mezclas de hormigón estructural.', 0, '0.00', '0.00', 1, 54, 1, 'activo', '2025-02-25 18:31:11'),
(85, 'Varilla Corrugada 3/8\"', 'Varilla de acero corrugado de 3/8\", ideal para refuerzos estructurales.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:40'),
(86, 'Varilla Corrugada 1/2\"', 'Varilla de acero corrugado de 1/2\", utilizada en cimentaciones y losas.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:40'),
(87, 'Varilla Corrugada 5/8\"', 'Varilla de acero corrugado de 5/8\", para estructuras de concreto reforzado.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:40'),
(88, 'Varilla Corrugada 3/4\"', 'Varilla de acero corrugado de 3/4\", recomendada para construcciones pesadas.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:40'),
(89, 'Varilla Corrugada 1\"', 'Varilla de acero corrugado de 1\", usada en puentes y grandes edificaciones.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:40'),
(90, 'Varilla Lisa 3/8\"', 'Varilla de acero lisa de 3/8\", utilizada en elementos de refuerzo menores.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:40'),
(91, 'Varilla Lisa 1/2\"', 'Varilla de acero lisa de 1/2\", usada en aplicaciones estructurales livianas.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:40'),
(92, 'Varilla Galvanizada 3/8\"', 'Varilla de acero galvanizada de 3/8\", resistente a la corrosión.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:40'),
(93, 'Varilla Galvanizada 1/2\"', 'Varilla de acero galvanizada de 1/2\", ideal para zonas húmedas.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:40'),
(94, 'Varilla para Anclaje', 'Varilla diseñada para sistemas de anclaje en estructuras metálicas.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:40'),
(95, 'Varilla Corrugada 1 1/4\"', 'Varilla de acero corrugado de 1 1/4\", utilizada en estructuras de gran carga.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:58'),
(96, 'Varilla Corrugada 1 1/2\"', 'Varilla de acero corrugado de 1 1/2\", para columnas y vigas de alta resistencia.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:58'),
(97, 'Varilla Lisa 5/8\"', 'Varilla de acero lisa de 5/8\", usada en encofrados y estructuras livianas.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:58'),
(98, 'Varilla Lisa 3/4\"', 'Varilla de acero lisa de 3/4\", utilizada en estructuras metálicas y de concreto.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:58'),
(99, 'Varilla Lisa 1\"', 'Varilla de acero lisa de 1\", recomendada para refuerzos estructurales.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:58'),
(100, 'Varilla Galvanizada 5/8\"', 'Varilla de acero galvanizada de 5/8\", ideal para zonas de alta humedad.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:58'),
(101, 'Varilla Galvanizada 3/4\"', 'Varilla de acero galvanizada de 3/4\", resistente a la corrosión en ambientes marinos.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:58'),
(102, 'Varilla para Cercado', 'Varilla de acero utilizada para cercas y estructuras de protección.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:58'),
(103, 'Varilla de Acero Inoxidable 3/8\"', 'Varilla de acero inoxidable de 3/8\", resistente a la oxidación.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:58'),
(104, 'Varilla de Acero Inoxidable 1/2\"', 'Varilla de acero inoxidable de 1/2\", usada en construcciones expuestas a humedad.', 0, '0.00', '0.00', 1, 55, 1, 'activo', '2025-02-25 18:34:58'),
(105, 'Lámina de Drywall 1/4\"', 'Lámina de yeso cartón de 1/4\", ideal para techos y muros livianos.', 0, '0.00', '0.00', 1, 56, 1, 'activo', '2025-02-25 18:40:00'),
(106, 'Lámina de Drywall 3/8\"', 'Lámina de yeso cartón de 3/8\", utilizada en divisiones interiores.', 0, '0.00', '0.00', 1, 56, 1, 'activo', '2025-02-25 18:40:00'),
(107, 'Lámina de Drywall 1/2\"', 'Lámina de yeso cartón de 1/2\", resistente a impactos y humedad moderada.', 0, '0.00', '0.00', 1, 56, 1, 'activo', '2025-02-25 18:40:00'),
(108, 'Lámina de Drywall 5/8\"', 'Lámina de yeso cartón de 5/8\", ideal para zonas de alto tráfico.', 0, '0.00', '0.00', 1, 56, 1, 'activo', '2025-02-25 18:40:00'),
(109, 'Lámina de Drywall Resistente a la Humedad', 'Lámina tratada para zonas con alta humedad como baños y cocinas.', 0, '0.00', '0.00', 1, 56, 1, 'activo', '2025-02-25 18:40:00'),
(110, 'Lámina de Drywall Resistente al Fuego', 'Lámina de yeso con aditivos especiales para retardar incendios.', 0, '0.00', '0.00', 1, 56, 1, 'activo', '2025-02-25 18:40:00'),
(111, 'Lámina de Drywall para Exteriores', 'Lámina reforzada con fibra de vidrio para uso en exteriores.', 0, '0.00', '0.00', 1, 56, 1, 'activo', '2025-02-25 18:40:00'),
(112, 'Lámina de Drywall Ultraliviana', 'Lámina más ligera para facilitar la instalación en techos.', 0, '0.00', '0.00', 1, 56, 1, 'activo', '2025-02-25 18:40:26'),
(113, 'Lámina de Drywall Tipo X', 'Diseñada para mayor resistencia al fuego en construcciones comerciales.', 0, '0.00', '0.00', 1, 56, 1, 'activo', '2025-02-25 18:40:26'),
(114, 'Lámina de Drywall Flexible', 'Permite la creación de muros y techos curvos con facilidad.', 0, '0.00', '0.00', 1, 56, 1, 'activo', '2025-02-25 18:40:26'),
(115, 'Lámina de Drywall con Aislante Acústico', 'Lámina con núcleo reforzado para reducir ruidos entre habitaciones.', 0, '0.00', '0.00', 1, 56, 1, 'activo', '2025-02-25 18:40:26'),
(116, 'Lámina de Drywall con Aislante Térmico', 'Lámina con propiedades de aislamiento térmico para reducir la transferencia de calor.', 0, '0.00', '0.00', 1, 56, 1, 'activo', '2025-02-25 18:40:26'),
(117, 'Lámina de Drywall Antimicrobiana', 'Lámina tratada para evitar la proliferación de moho y bacterias en ambientes húmedos.', 0, '0.00', '0.00', 1, 56, 1, 'activo', '2025-02-25 18:40:26'),
(118, 'Lámina de Cemento Fibro-Reforzada', 'Lámina de cemento con fibras de refuerzo, ideal para exteriores y zonas de alta humedad.', 0, '0.00', '0.00', 1, 56, 1, 'activo', '2025-02-25 18:40:26'),
(119, 'Lámina de Drywall Perforada', 'Diseñada para techos y paredes con alta absorción acústica.', 0, '0.00', '0.00', 1, 56, 1, 'activo', '2025-02-25 18:40:26'),
(120, 'Yeso Construcción 25kg', 'Yeso estándar para revestimientos y acabados en interiores.', 0, '0.00', '0.00', 1, 57, 1, 'activo', '2025-02-25 18:43:38'),
(121, 'Yeso Construcción 40kg', 'Yeso estándar para revestimientos y acabados en interiores.', 0, '0.00', '0.00', 1, 57, 1, 'activo', '2025-02-25 18:43:38'),
(122, 'Yeso Rápido 25kg', 'Fragua en menor tiempo, ideal para reparaciones urgentes.', 0, '0.00', '0.00', 1, 57, 1, 'activo', '2025-02-25 18:43:38'),
(123, 'Yeso de Proyección 35kg', 'Aplicación mecánica en grandes superficies.', 0, '0.00', '0.00', 1, 57, 1, 'activo', '2025-02-25 18:43:38'),
(124, 'Yeso Laminado 30kg', 'Usado en la fabricación de placas de yeso tipo drywall.', 0, '0.00', '0.00', 1, 57, 1, 'activo', '2025-02-25 18:43:38'),
(125, 'Yeso Antihumedad 25kg', 'Formulación especial para evitar el deterioro en zonas húmedas.', 0, '0.00', '0.00', 1, 57, 1, 'activo', '2025-02-25 18:43:38'),
(126, 'Yeso Extra Blanco 20kg', 'Mayor pureza y blancura para acabados finos.', 0, '0.00', '0.00', 1, 57, 1, 'activo', '2025-02-25 18:43:38'),
(127, 'Yeso Agrícola 50kg', 'Mejora la calidad del suelo en cultivos.', 0, '0.00', '0.00', 1, 57, 1, 'activo', '2025-02-25 18:43:38'),
(128, 'Yeso Industrial 30kg', 'Usado en moldes y producción de piezas en la industria.', 0, '0.00', '0.00', 1, 57, 1, 'activo', '2025-02-25 18:43:38'),
(129, 'Tornillo cabeza hexagonal 1/4\" x 1\"', 'Para estructuras metálicas y ensamblajes resistentes.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:02'),
(130, 'Tornillo cabeza hexagonal 1/4\" x 2\"', 'Usado en estructuras metálicas y ensambles de madera.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:02'),
(131, 'Tornillo cabeza hexagonal 3/8\" x 3\"', 'Fijaciones resistentes en estructuras metálicas y madera.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:02'),
(132, 'Tornillo cabeza hexagonal 1/2\" x 4\"', 'Para soportes estructurales y fijaciones fuertes.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:02'),
(133, 'Tornillo rosca madera 1/4\" x 2\"', 'Para fijaciones en madera sin necesidad de perforación previa.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:02'),
(134, 'Tornillo rosca madera 3/8\" x 3\"', 'Fijaciones seguras en estructuras de madera.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:02'),
(135, 'Tornillo de anclaje 1/2\" x 6\"', 'Para fijaciones en concreto con gran resistencia.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:02'),
(136, 'Tornillo de anclaje 5/8\" x 8\"', 'Fijaciones estructurales en concreto.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:02'),
(137, 'Chazo plástico 6mm con tornillo', 'Para anclajes en pared de concreto o ladrillo.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:02'),
(138, 'Chazo plástico 8mm con tornillo', 'Fijaciones seguras en paredes y techos.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:02'),
(139, 'Tornillo Allen 1/4\" x 1\"', 'Para fijaciones en maquinaria y estructuras metálicas.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:02'),
(140, 'Tornillo Allen 3/8\" x 2\"', 'Fijación de componentes mecánicos y estructuras pesadas.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:02'),
(141, 'Pija autotaladrante 1\"', 'Para fijaciones rápidas en metal o madera.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:02'),
(142, 'Pija autotaladrante 1 1/2\"', 'Fijaciones en techos metálicos y estructuras ligeras.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:02'),
(143, 'Tornillo para cubierta 2\"', 'Para fijación de láminas de techo con arandela de neopreno.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:02'),
(144, 'Tornillo para cubierta 2 1/2\"', 'Fijaciones de techos metálicos con sellado resistente.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:02'),
(145, 'Pija autotaladrante 3\"', 'Para fijaciones estructurales en techos y cubiertas.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(146, 'Tornillo para madera 1/4\" x 3\"', 'Usado en carpintería para ensamblajes fuertes.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(147, 'Tornillo para madera 3/8\" x 4\"', 'Fijaciones resistentes en estructuras de madera.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(148, 'Tornillo drywall 1\"', 'Para fijaciones de paneles de yeso en estructuras de metal o madera.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(149, 'Tornillo drywall 1 1/4\"', 'Usado en la instalación de paneles de yeso.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(150, 'Tornillo drywall 1 5/8\"', 'Fijaciones seguras para drywall en estructuras metálicas.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(151, 'Tornillo de expansión 1/4\" x 2\"', 'Para anclajes de alto rendimiento en concreto.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(152, 'Tornillo de expansión 3/8\" x 3\"', 'Fijaciones resistentes en muros de hormigón.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(153, 'Chazo de nylon 6mm', 'Para anclajes de tornillos en paredes de ladrillo y concreto.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(154, 'Chazo de nylon 8mm', 'Usado en fijaciones con tornillos en paredes de concreto.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(155, 'Tuerca hexagonal 1/4\"', 'Para ensamblaje de tornillos hexagonales.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(156, 'Tuerca hexagonal 3/8\"', 'Usada en fijaciones estructurales.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(157, 'Tuerca de seguridad 1/2\"', 'Evita que los tornillos se aflojen por vibraciones.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(158, 'Arandela plana 1/4\"', 'Distribuye la presión en la superficie de contacto.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(159, 'Arandela plana 3/8\"', 'Protege superficies y evita aflojamientos.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(160, 'Arandela de presión 1/2\"', 'Para evitar aflojamientos en estructuras sometidas a vibraciones.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(161, 'Tornillo autoperforante para metal 1/2\"', 'Para unir estructuras metálicas sin perforaciones previas.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(162, 'Tornillo autoperforante para metal 3/4\"', 'Fijaciones seguras en perfiles metálicos.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(163, 'Tornillo tirafondo 1/4\" x 4\"', 'Usado en estructuras de madera para fijaciones profundas.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(164, 'Tornillo tirafondo 3/8\" x 5\"', 'Fijaciones fuertes en madera o mampostería.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(165, 'Tornillo cabeza plana 1/4\" x 1\"', 'Para ensamblajes discretos en muebles y estructuras de madera.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(166, 'Tornillo cabeza plana 3/8\" x 2\"', 'Fijaciones seguras en estructuras de madera y metal.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(167, 'Grapa para fijación 1/2\"', 'Usada en estructuras metálicas para fijar cables y alambres.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(168, 'Grapa para fijación 3/4\"', 'Fijaciones fuertes en instalaciones eléctricas y de construcción.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(169, 'Anclaje de expansión 1/2\"', 'Para fijaciones de alto rendimiento en concreto.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(170, 'Anclaje de expansión 5/8\"', 'Ideal para fijaciones estructurales en mampostería.', 0, '0.00', '0.00', 1, 3, 1, 'activo', '2025-02-25 18:54:22'),
(201, 'Pintura acrílica blanca mate galón', 'Pintura de alta cobertura para interiores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(202, 'Pintura acrílica blanca brillante galón', 'Ideal para techos y paredes en interiores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(203, 'Pintura acrílica gris perla galón', 'Tono neutro ideal para interiores y exteriores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(204, 'Pintura acrílica azul celeste galón', 'Pintura para interiores y exteriores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(205, 'Pintura acrílica rojo intenso galón', 'Color vibrante con alta resistencia al desgaste, para interiores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(206, 'Pintura acrílica amarillo mostaza galón', 'Acabado duradero con excelente cobertura para interiores y exteriores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(207, 'Pintura acrílica verde bosque galón', 'Tono natural perfecto para exteriores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(208, 'Pintura acrílica negra galón', 'Ideal para interiores y exteriores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(209, 'Pintura esmalte sintético blanco galón', 'Pintura para madera y metal con acabado brillante, apta para interiores y exteriores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(210, 'Pintura esmalte sintético negro galón', 'Alta durabilidad y resistencia a la intemperie, ideal para exteriores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(211, 'Pintura esmalte sintético azul galón', 'Ideal para muebles y puertas metálicas en interiores y exteriores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(212, 'Pintura en spray blanco brillante 400ml', 'Aerosol de secado rápido para retoques en interiores y exteriores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(213, 'Pintura en spray negro mate 400ml', 'Ideal para superficies metálicas y plásticas en exteriores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(214, 'Pintura impermeabilizante roja galón', 'Protección contra filtraciones en techos y paredes exteriores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(215, 'Pintura impermeabilizante blanca galón', 'Alta resistencia a la intemperie, ideal para exteriores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(216, 'Pintura epóxica gris galón', 'Para pisos y áreas de alto tráfico en interiores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(217, 'Pintura epóxica azul galón', 'Durabilidad extrema para áreas industriales y exteriores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(218, 'Pintura reflectante blanca galón', 'Alta visibilidad para señalización en exteriores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(219, 'Pintura reflectante amarilla galón', 'Usada en demarcación vial y exteriores.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(220, 'Pintura automotriz negro brillante galón', 'Alta adherencia y resistencia para exteriores y vehículos.', 0, '0.00', '0.00', 1, 58, 1, 'activo', '2025-02-25 19:30:35'),
(221, 'Tubo PVC ½ pulgada x 3m', 'Tubo de PVC para conducción de agua potable.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(222, 'Tubo PVC ¾ pulgada x 3m', 'Resistente a la corrosión y de fácil instalación.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(223, 'Tubo PVC 1 pulgada x 3m', 'Para instalaciones hidráulicas y sanitarias.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(224, 'Tubo PPR ½ pulgada x 3m', 'Tubería de polipropileno para agua caliente y fría.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(225, 'Tubo PPR ¾ pulgada x 3m', 'Alta resistencia térmica y química.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(226, 'Codo PVC ½ pulgada 90°', 'Accesorio de conexión para cambios de dirección en tuberías.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(227, 'Codo PVC ¾ pulgada 90°', 'Para sistemas de fontanería y drenaje.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(228, 'Codo PVC 1 pulgada 90°', 'Resistente y de fácil instalación.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(229, 'Unión roscada PVC ½ pulgada', 'Conector desmontable para sistemas de agua potable.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(230, 'Unión roscada PVC ¾ pulgada', 'Alta resistencia a la presión y temperatura.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(231, 'Válvula de esfera PVC ½ pulgada', 'Llave de paso para control de flujo de agua.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(232, 'Válvula de esfera PVC ¾ pulgada', 'Manejo fácil con sistema de apertura y cierre rápido.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(233, 'Tubo galvanizado ½ pulgada x 3m', 'Tubería metálica para conducción de agua.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(234, 'Tubo galvanizado ¾ pulgada x 3m', 'Resistente a la corrosión y al desgaste.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(235, 'Codo galvanizado ½ pulgada 90°', 'Accesorio de conexión para tuberías metálicas.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(236, 'Codo galvanizado ¾ pulgada 90°', 'Durabilidad y resistencia garantizada.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(237, 'Te PVC ½ pulgada', 'Conector en forma de \"T\" para derivaciones en tuberías.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(238, 'Te PVC ¾ pulgada', 'Para uniones de tres vías en instalaciones hidráulicas.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(239, 'Adaptador macho PVC ½ pulgada', 'Conexión entre roscas y tuberías de PVC.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(240, 'Adaptador macho PVC ¾ pulgada', 'Permite conexiones firmes en sistemas de fontanería.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:32:53'),
(241, 'Cinta teflón 10m', 'Cinta selladora para conexiones de tuberías.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(242, 'Llave de paso PVC ½ pulgada', 'Controla el flujo de agua en tuberías de PVC.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(243, 'Llave de paso PVC ¾ pulgada', 'Resistente a la presión y corrosión.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(244, 'Llave de paso metálica ½ pulgada', 'Fabricada en bronce, alta resistencia.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(245, 'Llave de paso metálica ¾ pulgada', 'Ideal para sistemas de agua potable y riego.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(246, 'Reducción PVC ¾ a ½ pulgada', 'Permite la reducción de diámetro en tuberías.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(247, 'Reducción PVC 1 a ¾ pulgada', 'Para conexiones de diferentes diámetros.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(248, 'Adaptador hembra PVC ½ pulgada', 'Para unir conexiones roscadas en fontanería.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(249, 'Adaptador hembra PVC ¾ pulgada', 'Facilita la unión de tuberías con conexiones roscadas.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(250, 'Conector flexible ½ pulgada', 'Manguera de conexión para grifos y sanitarios.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(251, 'Conector flexible ¾ pulgada', 'Flexible y resistente a altas temperaturas.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(252, 'Válvula check PVC ½ pulgada', 'Evita el retorno del agua en tuberías.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(253, 'Válvula check PVC ¾ pulgada', 'Instalación en sistemas hidráulicos y sanitarios.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(254, 'Trampa para fregadero PVC 1 ½ pulgada', 'Evita malos olores y retorno de aguas residuales.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(255, 'Trampa para lavamanos PVC 1 ¼ pulgada', 'Diseño antiolores, fácil instalación.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(256, 'Tanque elevado 500L', 'Tanque de almacenamiento de agua potable.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(257, 'Tanque elevado 1000L', 'Capacidad ideal para sistemas domésticos.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(258, 'Bomba de agua periférica 0.5HP', 'Ideal para aumentar la presión de agua.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(259, 'Bomba de agua centrífuga 1HP', 'Mayor caudal para sistemas de riego o abastecimiento.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(260, 'Filtro para agua 10\"', 'Purificación de agua potable.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:33:22'),
(261, 'Codo PVC 90° ½ pulgada', 'Para cambio de dirección en tuberías de agua.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(262, 'Codo PVC 90° ¾ pulgada', 'Resistente a la presión y corrosión.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(263, 'Codo PVC 45° ½ pulgada', 'Permite desvío de tuberías a menor ángulo.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(264, 'Codo PVC 45° ¾ pulgada', 'Para conexiones de tuberías en ángulo de 45 grados.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(265, 'Tubo PVC presión ½ pulgada x 3m', 'Tubo de alta resistencia para conducción de agua potable.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(266, 'Tubo PVC presión ¾ pulgada x 3m', 'Resistente a la presión y cambios de temperatura.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(267, 'Tubo PVC sanitario 4\" x 3m', 'Para drenajes y sistemas de alcantarillado.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(268, 'Unión PVC ½ pulgada', 'Conector recto para unir tuberías del mismo diámetro.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(269, 'Unión PVC ¾ pulgada', 'Conexión segura y hermética en instalaciones de fontanería.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(270, 'Unión universal metálica ½ pulgada', 'Para unir tuberías de distintos materiales.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(271, 'Unión universal metálica ¾ pulgada', 'Permite conectar diferentes tipos de tuberías.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(272, 'Tubo flexible sanitario 1 ¼ pulgada x 50cm', 'Para drenajes de lavamanos y fregaderos.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(273, 'Válvula de bola PVC ½ pulgada', 'Para control de flujo en tuberías de agua potable.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(274, 'Válvula de bola PVC ¾ pulgada', 'Alta resistencia al desgaste y químicos.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(275, 'Válvula de retención PVC ½ pulgada', 'Evita el retorno de agua en sistemas de tuberías.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(276, 'Válvula de retención PVC ¾ pulgada', 'Evita el flujo inverso del agua.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(277, 'Tapón PVC ½ pulgada', 'Para cerrar extremos de tuberías de agua.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(278, 'Tapón PVC ¾ pulgada', 'Cierre hermético para tuberías de PVC.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(279, 'Tapón PVC 4 pulgadas', 'Utilizado en sistemas sanitarios y pluviales.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(280, 'Kit de reparación para tuberías', 'Incluye sellador, cinta de teflón y abrazaderas.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:35:37'),
(281, 'Llave de paso PVC ½ pulgada', 'Controla el flujo de agua en sistemas de tuberías.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(282, 'Llave de paso PVC ¾ pulgada', 'Alta resistencia y fácil instalación.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(283, 'Llave de paso metálica ½ pulgada', 'Resistente a la corrosión, ideal para exteriores.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(284, 'Llave de paso metálica ¾ pulgada', 'Para control preciso del flujo de agua.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(285, 'Cinta de teflón 10m', 'Sella conexiones de rosca en tuberías.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(286, 'Cinta de teflón industrial 25m', 'Mayor resistencia y sellado para conexiones.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(287, 'Abrazadera metálica ½ pulgada', 'Para fijación de tuberías y mangueras.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(288, 'Abrazadera metálica ¾ pulgada', 'Fijación segura de tuberías a estructuras.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(289, 'Abrazadera plástica ½ pulgada', 'Para sujetar tuberías de PVC a paredes.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(290, 'Abrazadera plástica ¾ pulgada', 'Ideal para instalación de tuberías sanitarias.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(291, 'Conector macho PVC ½ pulgada', 'Conexión rápida y segura para tuberías.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(292, 'Conector macho PVC ¾ pulgada', 'Para acoplamiento en sistemas de fontanería.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(293, 'Conector hembra PVC ½ pulgada', 'Permite la unión con conexiones roscadas.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(294, 'Conector hembra PVC ¾ pulgada', 'Para adaptaciones de tuberías de PVC.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(295, 'Adaptador PVC ½ a ¾ pulgada', 'Reduce o amplía el diámetro de tuberías.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(296, 'Adaptador PVC ¾ a 1 pulgada', 'Para conexión entre tuberías de distintos diámetros.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(297, 'Sifón flexible 1 ½ pulgada', 'Para desagües de lavamanos y fregaderos.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(298, 'Sifón rígido 1 ½ pulgada', 'Evita malos olores en desagües sanitarios.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(299, 'Válvula de flotador tanque ½ pulgada', 'Regula el nivel de agua en tanques y cisternas.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(300, 'Válvula de flotador tanque ¾ pulgada', 'Sistema automático para control de agua en depósitos.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:37:00'),
(301, 'Codo PVC ½ pulgada', 'Conexión en ángulo de 90° para tuberías de PVC.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(302, 'Codo PVC ¾ pulgada', 'Redirecciona tuberías en sistemas de fontanería.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(303, 'Codo PVC 1 pulgada', 'Para cambios de dirección en instalaciones de agua.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(304, 'Tee PVC ½ pulgada', 'Distribuye el flujo de agua en tres direcciones.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(305, 'Tee PVC ¾ pulgada', 'Permite ramificaciones en sistemas de tuberías.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(306, 'Tee PVC 1 pulgada', 'Conexión en T para sistemas hidráulicos.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(307, 'Reducción PVC ¾ a ½ pulgada', 'Reduce el diámetro de tuberías en sistemas de agua.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(308, 'Reducción PVC 1 a ¾ pulgada', 'Para empalmes de tuberías de distintos diámetros.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(309, 'Unión roscada PVC ½ pulgada', 'Conexión desmontable para mantenimiento de tuberías.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(310, 'Unión roscada PVC ¾ pulgada', 'Fácil instalación y desmontaje en sistemas hidráulicos.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(311, 'Válvula check PVC ½ pulgada', 'Impide el retorno de agua en el sistema.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(312, 'Válvula check PVC ¾ pulgada', 'Evita el reflujo en tuberías de agua potable.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(313, 'Válvula esfera PVC ½ pulgada', 'Regulación del flujo en instalaciones de agua.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(314, 'Válvula esfera PVC ¾ pulgada', 'Para control de paso de agua en sistemas hidráulicos.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(315, 'Válvula de compuerta ½ pulgada', 'Apertura y cierre total del flujo de agua.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(316, 'Válvula de compuerta ¾ pulgada', 'Control preciso en sistemas de fontanería.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(317, 'Tubo PVC presión ½ pulgada', 'Para conducción de agua potable a presión.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(318, 'Tubo PVC presión ¾ pulgada', 'Alta resistencia y durabilidad en fontanería.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(319, 'Tubo PVC presión 1 pulgada', 'Uso en sistemas de agua potable y riego.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(320, 'Trampa de fregadero PVC', 'Evita el paso de olores desde el desagüe.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:38:17'),
(321, 'Tubo PVC sanitario ½ pulgada', 'Para desagües en instalaciones domésticas.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(322, 'Tubo PVC sanitario ¾ pulgada', 'Uso en sistemas de drenaje y alcantarillado.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(323, 'Tubo PVC sanitario 1 pulgada', 'Alta resistencia para sistemas de evacuación de aguas.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(324, 'Codo PVC sanitario ½ pulgada', 'Redirección de flujo en sistemas de drenaje.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(325, 'Codo PVC sanitario ¾ pulgada', 'Para cambios de dirección en tuberías de desagüe.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(326, 'Codo PVC sanitario 1 pulgada', 'Uso en sistemas de alcantarillado doméstico.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(327, 'Tee PVC sanitaria ½ pulgada', 'Distribución en sistemas de drenaje.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(328, 'Tee PVC sanitaria ¾ pulgada', 'Para conexión de ramificaciones en desagües.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(329, 'Tee PVC sanitaria 1 pulgada', 'Conector en forma de T para tuberías de desagüe.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(330, 'Unión soldable PVC ½ pulgada', 'Conexión permanente de tuberías de PVC.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(331, 'Unión soldable PVC ¾ pulgada', 'Para empalmes en tuberías hidráulicas.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(332, 'Unión soldable PVC 1 pulgada', 'Facilita la instalación de sistemas de tuberías.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(333, 'Adaptador macho PVC ½ pulgada', 'Conexión roscada para tuberías de PVC.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(334, 'Adaptador macho PVC ¾ pulgada', 'Permite unir tuberías de PVC con accesorios metálicos.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(335, 'Adaptador macho PVC 1 pulgada', 'Conector de PVC con rosca externa.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(336, 'Adaptador hembra PVC ½ pulgada', 'Conexión roscada interna para PVC.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(337, 'Adaptador hembra PVC ¾ pulgada', 'Para unión con tuberías metálicas o de PVC.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(338, 'Adaptador hembra PVC 1 pulgada', 'Uso en instalaciones de fontanería y riego.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(339, 'Abrazadera metálica ½ pulgada', 'Para fijación segura de tuberías a la pared.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(340, 'Abrazadera metálica ¾ pulgada', 'Sujeción de tuberías en sistemas hidráulicos.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(341, 'Abrazadera metálica 1 pulgada', 'Para fijar tuberías en instalaciones de agua.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(342, 'Llave de paso PVC ½ pulgada', 'Corte y regulación de agua en redes domésticas.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(343, 'Llave de paso PVC ¾ pulgada', 'Permite el control del suministro de agua.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(344, 'Llave de paso PVC 1 pulgada', 'Regulación de flujo en tuberías hidráulicas.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(345, 'Llave de jardín metálica ½ pulgada', 'Grifo resistente para exteriores.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(346, 'Llave de jardín metálica ¾ pulgada', 'Grifo de alta durabilidad para exteriores.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(347, 'Llave de jardín metálica 1 pulgada', 'Para control de agua en sistemas de riego.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(348, 'Filtro de agua doméstico', 'Elimina impurezas del agua potable.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(349, 'Filtro de agua industrial', 'Filtración de alta capacidad para sistemas hidráulicos.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(350, 'Cinta teflón 10 metros', 'Sellado hermético para roscas de tuberías.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(351, 'Pasta selladora para tuberías', 'Asegura uniones sin fugas en conexiones hidráulicas.', 0, '0.00', '0.00', 1, 5, 1, 'activo', '2025-02-25 19:39:12'),
(401, 'Cable eléctrico THW 12 AWG', 'Cable de cobre con aislamiento para instalaciones eléctricas residenciales.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(402, 'Cable eléctrico THW 14 AWG', 'Uso en instalaciones eléctricas domésticas y comerciales.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(403, 'Cable eléctrico THW 10 AWG', 'Mayor capacidad de conducción eléctrica para cargas altas.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(404, 'Tubo conduit PVC ½ pulgada', 'Protección para cableado eléctrico.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(405, 'Tubo conduit PVC ¾ pulgada', 'Resistencia y aislamiento para cableado.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(406, 'Codo conduit PVC ½ pulgada', 'Cambio de dirección en instalaciones eléctricas.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(407, 'Codo conduit PVC ¾ pulgada', 'Permite redirección segura del cableado.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(408, 'Caja de distribución PVC 4x4', 'Caja para conexiones eléctricas en muros y techos.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(409, 'Caja de distribución PVC 6x6', 'Para distribución segura de cableado eléctrico.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(410, 'Interruptor sencillo', 'Encendido y apagado de circuitos eléctricos.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(411, 'Interruptor doble', 'Control de dos circuitos desde un solo punto.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(412, 'Interruptor triple', 'Permite controlar tres fuentes de iluminación.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(413, 'Tomacorriente sencillo', 'Conexión para aparatos eléctricos.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(414, 'Tomacorriente doble', 'Para dos dispositivos eléctricos simultáneamente.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(415, 'Tomacorriente con polo a tierra', 'Mayor seguridad en conexiones eléctricas.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(416, 'Regleta de conexión 6 tomas', 'Distribución de corriente eléctrica.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(417, 'Regleta de conexión 8 tomas', 'Extensión de energía con múltiples conexiones.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(418, 'Foco LED 9W luz cálida', 'Iluminación de bajo consumo energético.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(419, 'Foco LED 9W luz blanca', 'Luz blanca para ambientes claros.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(420, 'Foco LED 12W luz fría', 'Alta eficiencia y menor consumo de energía.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(421, 'Foco LED 18W luz neutra', 'Ideal para oficinas y espacios amplios.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(422, 'Reflector LED 30W', 'Iluminación potente para exteriores.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(423, 'Reflector LED 50W', 'Iluminación de alta intensidad y bajo consumo.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(424, 'Tira LED 5 metros', 'Decoración e iluminación ambiental.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(425, 'Balastro electrónico 36W', 'Regulación de corriente para tubos fluorescentes.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(426, 'Tubo LED 18W 120 cm', 'Reemplazo de tubos fluorescentes.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(427, 'Tubo LED 9W 60 cm', 'Iluminación eficiente para oficinas.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(428, 'Tablero eléctrico metálico', 'Protección y control de circuitos eléctricos.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26');
INSERT INTO `producto` (`idproducto`, `nombre`, `descripcion`, `cantidad`, `precioCompra`, `precio`, `usuario_idusuario`, `categoria_idcategoria`, `proveedor_idproveedor`, `estado`, `fecha`) VALUES
(429, 'Breaker 15A monopolar', 'Protección contra sobrecargas eléctricas.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(430, 'Breaker 20A monopolar', 'Interruptor automático de seguridad.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(431, 'Breaker 30A bipolár', 'Mayor capacidad de protección eléctrica.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(432, 'Breaker 40A tripolar', 'Para sistemas eléctricos industriales.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(433, 'Transformador 110V a 220V', 'Conversión de voltaje para equipos eléctricos.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(434, 'Transformador 220V a 110V', 'Uso en equipos de diferentes voltajes.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(435, 'Supresor de picos', 'Protección contra variaciones de voltaje.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(436, 'Toma USB para pared', 'Carga de dispositivos móviles integrada.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:44:26'),
(437, 'Interruptor de sensor de movimiento', 'Enciende automáticamente las luces al detectar movimiento.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(438, 'Interruptor inteligente WiFi', 'Controla la luz desde el celular mediante WiFi.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(439, 'Dimmer para luces LED', 'Regulación de intensidad lumínica.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(440, 'Control remoto para iluminación', 'Mando inalámbrico para luces LED y reguladores.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(441, 'Lámpara de emergencia LED', 'Iluminación automática en caso de fallas eléctricas.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(442, 'Linterna recargable LED', 'Luz portátil de alta intensidad.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(443, 'Panel solar 100W', 'Generación de energía limpia con luz solar.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(444, 'Kit de panel solar con batería', 'Energía solar para iluminación en zonas remotas.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(445, 'Batería para energía solar 12V', 'Almacenamiento de energía solar para sistemas autónomos.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(446, 'Regulador de carga solar 10A', 'Protección de baterías en sistemas fotovoltaicos.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(447, 'Convertidor de corriente 12V a 110V', 'Transforma corriente continua en alterna.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(448, 'Luminaria LED de techo', 'Iluminación moderna para interiores.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(449, 'Lámpara colgante industrial', 'Iluminación decorativa para espacios amplios.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(450, 'Lámpara de pared LED', 'Luz decorativa y funcional para interiores.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(451, 'Reflector solar 50W con sensor', 'Iluminación de exteriores con energía solar y sensor de movimiento.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(452, 'Reflector LED RGB 30W', 'Iluminación de colores con control remoto.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(453, 'Lámpara LED sumergible', 'Iluminación resistente al agua para piscinas o fuentes.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(454, 'Cinta LED RGB con control', 'Tira de luces de colores personalizables.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(455, 'Enchufe inteligente WiFi', 'Controla cualquier dispositivo desde el celular.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(456, 'Regulador de voltaje 1000VA', 'Protección contra fluctuaciones de voltaje.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(457, 'Estabilizador de corriente 2000W', 'Regula y estabiliza el suministro eléctrico.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(458, 'Medidor de consumo eléctrico', 'Mide el gasto energético de dispositivos y equipos.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(459, 'UPS 1200VA', 'Sistema de respaldo para cortes eléctricos.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(460, 'Cable coaxial RG6', 'Cable para instalaciones de televisión y redes.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(461, 'Conector coaxial tipo F', 'Conexión para cables de televisión y antenas.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(462, 'Detector de voltaje sin contacto', 'Identifica corriente eléctrica sin necesidad de contacto.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(463, 'Probador de enchufes', 'Verifica el estado y conexión de tomacorrientes.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(464, 'Multímetro digital', 'Mide voltaje, corriente y resistencia eléctrica.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(465, 'Pinza amperimétrica', 'Mide corriente sin necesidad de desconectar el circuito.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(466, 'Cinta aislante 10m', 'Aislamiento eléctrico en cables y conexiones.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(467, 'Cinta vulcanizada', 'Aislamiento impermeable y protección de empalmes.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(468, 'Conector rápido WAGO', 'Conexión segura y sin tornillos en cables eléctricos.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(469, 'Bornera de conexión 12 posiciones', 'Distribución de corriente eléctrica en tableros.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(470, 'Lámpara portátil recargable', 'Fuente de luz transportable y de larga duración.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(471, 'Base para foco E27', 'Soporte para bombillos de rosca estándar.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(472, 'Base para foco GU10', 'Soporte para bombillas LED de tipo GU10.', 0, '0.00', '0.00', 1, 6, 1, 'activo', '2025-02-25 19:45:04'),
(473, 'Casco de seguridad', 'Protección contra impactos en la cabeza.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(474, 'Casco con protector facial', 'Casco con pantalla para mayor protección facial.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(475, 'Gafas de seguridad', 'Protección ocular contra partículas y líquidos.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(476, 'Gafas de protección UV', 'Protección contra radiación ultravioleta.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(477, 'Mascarilla N95', 'Protección respiratoria contra partículas y polvo.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(478, 'Respirador con filtro', 'Protección avanzada contra gases y vapores tóxicos.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(479, 'Guantes de seguridad de nitrilo', 'Protección química y mecánica.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(480, 'Guantes de cuero reforzado', 'Resistencia a cortes y abrasión.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(481, 'Guantes dieléctricos', 'Aislantes para trabajos eléctricos.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(482, 'Bota de seguridad con punta de acero', 'Protección contra impactos y perforaciones.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(483, 'Zapato de seguridad antideslizante', 'Ideal para entornos industriales y húmedos.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(484, 'Overol de seguridad', 'Protección contra químicos y contaminantes.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(485, 'Chaleco reflectante', 'Alta visibilidad para trabajos en zonas de tráfico.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(486, 'Arnés de seguridad con línea de vida', 'Protección contra caídas en alturas.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(487, 'Orejeras de seguridad', 'Protección auditiva contra ruidos fuertes.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(488, 'Tapones auditivos de espuma', 'Reducción de ruido en entornos industriales.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(489, 'Faja lumbar de soporte', 'Protección contra lesiones en la espalda.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(490, 'Rodilleras industriales', 'Protección de rodillas en trabajos pesados.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(491, 'Señal de seguridad “Uso obligatorio de casco”', 'Aviso de seguridad industrial.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(492, 'Señal de salida de emergencia', 'Indica la ubicación de salidas de evacuación.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(493, 'Extintor de incendios 6 kg', 'Para controlar incendios en fábricas y oficinas.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(494, 'Manta ignífuga', 'Apaga incendios pequeños y protege contra llamas.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(495, 'Botiquín de primeros auxilios industrial', 'Kit de emergencia para accidentes laborales.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(496, 'Ducha de emergencia', 'Para descontaminación en caso de exposición química.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(497, 'Lavado ocular de emergencia', 'Para enjuague inmediato de los ojos en caso de accidentes.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(498, 'Linterna de seguridad ATEX', 'A prueba de explosiones para zonas peligrosas.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(499, 'Cinta de peligro amarillo y negro', 'Para señalización de áreas de riesgo.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(500, 'Cono de seguridad reflectante', 'Para delimitar zonas de trabajo o tránsito.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(501, 'Baranda de seguridad portátil', 'Delimitación de zonas de peligro temporal.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(502, 'Cuerda de delimitación con postes', 'Para control de acceso en áreas restringidas.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(503, 'Cámara de seguridad industrial', 'Monitoreo y vigilancia en fábricas y almacenes.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(504, 'Alarma de evacuación', 'Sirena de emergencia para simulacros y evacuaciones.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(505, 'Cierre de seguridad para maquinaria', 'Bloqueo de equipos para evitar accidentes.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(506, 'Kit de rescate en alturas', 'Equipo para rescate en trabajos de gran altura.', 0, '0.00', '0.00', 1, 7, 1, 'activo', '2025-02-25 19:51:20'),
(507, 'Tijeras de podar', 'Herramienta manual para cortar ramas y arbustos.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(508, 'Podadora de césped', 'Máquina para cortar césped de manera uniforme.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(509, 'Desbrozadora', 'Herramienta para eliminar maleza y hierba alta.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(510, 'Motosierra', 'Sierra mecánica para cortar árboles y ramas gruesas.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(511, 'Rastrillo de jardinería', 'Para recolectar hojas y nivelar el suelo.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(512, 'Pala de jardinería', 'Herramienta esencial para cavar y trasplantar.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(513, 'Azadón', 'Para remover tierra y eliminar maleza.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(514, 'Regadera de mano', 'Para el riego de plantas pequeñas.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(515, 'Manguera de riego', 'Tubo flexible para irrigación de jardines.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(516, 'Aspersor de riego', 'Dispositivo para distribución uniforme de agua.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(517, 'Sistema de riego por goteo', 'Ahorro de agua y eficiencia en el riego.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(518, 'Semillas de césped', 'Para la siembra y crecimiento de césped natural.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(519, 'Semillas de hortalizas', 'Variedad de semillas para huertos caseros.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(520, 'Abono orgánico', 'Fertilizante natural para mejorar la calidad del suelo.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(521, 'Fertilizante químico', 'Nutrientes esenciales para el crecimiento de plantas.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(522, 'Tierra para macetas', 'Sustrato especializado para plantas en macetas.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(523, 'Macetas de barro', 'Contenedores naturales para plantas.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(524, 'Macetas de plástico', 'Ligero y resistente para todo tipo de plantas.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(525, 'Insecticida ecológico', 'Protección contra plagas sin dañar el ambiente.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(526, 'Herbicida selectivo', 'Para eliminar maleza sin afectar cultivos.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(527, 'Controlador de plagas biológico', 'Método natural para reducir insectos dañinos.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(528, 'Malla anti-pájaros', 'Evita que aves dañen cultivos y frutas.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(529, 'Invernadero portátil', 'Protección para plantas contra clima extremo.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(530, 'Carretilla de jardín', 'Transporte fácil de tierra, piedras y herramientas.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(531, 'Guantes de jardinería', 'Protección de manos al manipular tierra y plantas.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(532, 'Malla de sombreo', 'Reducción de la intensidad de la luz solar en cultivos.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(533, 'Bomba de fumigación manual', 'Para aplicar pesticidas o fertilizantes líquidos.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(534, 'Bomba de fumigación a motor', 'Mayor potencia para fumigaciones en grandes cultivos.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(535, 'Mulch orgánico', 'Capa de protección para mantener la humedad del suelo.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(536, 'Estacas de bambú', 'Soporte natural para plantas trepadoras.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(537, 'Kit de huerto urbano', 'Todo lo necesario para cultivar en casa.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(538, 'Sensor de humedad del suelo', 'Para optimizar el riego de cultivos.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(539, 'Espantapájaros', 'Protección de cultivos contra aves.', 0, '0.00', '0.00', 1, 8, 1, 'activo', '2025-02-25 19:52:34'),
(540, 'Silicona transparente', 'Adhesivo sellador multiusos para interiores y exteriores.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(541, 'Silicona blanca', 'Ideal para sellado de baños, cocinas y ventanas.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(542, 'Silicona negra', 'Resistente a altas temperaturas y aceites.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(543, 'Silicona acrílica', 'Especial para madera, yeso y superficies porosas.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(544, 'Silicona para acuarios', 'No tóxica y resistente al agua.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(545, 'Sellador de poliuretano', 'Alta resistencia mecánica y adhesión.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(546, 'Sellador acrílico', 'Flexible y pintable, ideal para juntas de construcción.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(547, 'Sellador de juntas', 'Para evitar filtraciones en pisos y paredes.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(548, 'Sellador epóxico', 'Gran resistencia química y mecánica.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(549, 'Pegamento de contacto', 'Para unir materiales como madera, cuero y caucho.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(550, 'Pegamento de PVC', 'Especial para unir tuberías y accesorios plásticos.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(551, 'Pegamento para madera', 'Adhesivo de alta resistencia para carpintería.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(552, 'Pegamento instantáneo', 'Fijación rápida para múltiples materiales.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(553, 'Pegamento estructural', 'Adhesivo de alto rendimiento para construcción.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(554, 'Cinta adhesiva doble faz', 'Para montaje y fijación sin clavos ni tornillos.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(555, 'Cinta de enmascarar', 'Para protección en trabajos de pintura.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(556, 'Cinta de sellado', 'Para asegurar juntas y evitar fugas de agua o aire.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(557, 'Cinta de aluminio', 'Alta resistencia al calor y a la humedad.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(558, 'Cinta vulcanizante', 'Para reparaciones en cables eléctricos y tuberías.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(559, 'Espuma expansiva', 'Para rellenar grietas y huecos en construcción.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(560, 'Adhesivo para baldosas', 'Para instalación de cerámica y porcelanato.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(561, 'Mortero adhesivo', 'Para fijar bloques de concreto y ladrillos.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(562, 'Cemento de contacto', 'Para unir materiales de construcción.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(563, 'Silicona para alta temperatura', 'Resistente a temperaturas extremas.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(564, 'Sellador asfáltico', 'Para impermeabilizar techos y estructuras.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(565, 'Resina epóxica', 'Para reparaciones estructurales y acabados brillantes.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(566, 'Silicona líquida', 'Ideal para manualidades y reparaciones finas.', 0, '0.00', '0.00', 1, 9, 1, 'activo', '2025-02-25 19:53:49'),
(570, 'Candado de acero', 'Candado de alta seguridad con llave reforzada.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(571, 'Candado de combinación', 'Candado sin llave con código numérico programable.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(572, 'Candado de latón', 'Resistente a la corrosión y de larga duración.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(573, 'Candado con alarma', 'Incluye sistema de alarma antirrobo con sensor de vibración.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(574, 'Candado para bicicleta', 'Candado con cable de acero flexible y combinación numérica.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(575, 'Candado biométrico', 'Candado con apertura por huella dactilar.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(576, 'Candado de seguridad para maleta', 'Aprobado por TSA, con combinación de 3 dígitos.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(577, 'Cerradura de sobreponer', 'Cerradura de alta seguridad con llave tradicional.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(578, 'Cerradura digital', 'Sistema de apertura con código numérico y tarjeta RFID.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(579, 'Cerradura multipunto', 'Mayor seguridad con varios puntos de cierre.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(580, 'Cerradura de pomo', 'Cerradura estándar con sistema de llave cilíndrica.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(581, 'Cerradura electrónica', 'Apertura con clave, tarjeta o Bluetooth.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(582, 'Cerradura para vidrio', 'Especial para puertas de vidrio templado.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(583, 'Cerradura tubular', 'Ideal para puertas interiores con sistema de giro.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(584, 'Cerrojo de seguridad', 'Doble perno para mayor resistencia.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(585, 'Cerrojo digital', 'Sistema de bloqueo inteligente con acceso remoto.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(586, 'Llave maestra', 'Llave universal compatible con sistemas de seguridad.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(587, 'Llaves de repuesto', 'Copias de seguridad para diferentes tipos de cerraduras.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(588, 'Caja fuerte digital', 'Sistema con clave numérica y apertura de emergencia.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(589, 'Caja fuerte con llave', 'Cerradura mecánica tradicional con doble seguro.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(590, 'Pistón de seguridad', 'Refuerzo adicional para puertas principales.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(591, 'Barra de seguridad para puertas', 'Bloqueo resistente contra aperturas forzadas.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(592, 'Manija con cerradura', 'Para puertas de entrada con sistema de bloqueo incorporado.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(593, 'Bisagra de seguridad', 'Con refuerzo para evitar desmontaje de puertas.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(594, 'Cerradura invisible', 'Sistema de seguridad sin llave visible.', 0, '0.00', '0.00', 1, 11, 1, 'activo', '2025-02-25 19:59:42'),
(595, 'Llave de lavamanos', 'Llave monomando cromada para lavamanos.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(596, 'Llave de cocina', 'Grifo monomando de acero inoxidable para cocina.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(597, 'Llave para ducha', 'Mezcladora de agua fría y caliente para ducha.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(598, 'Ducha eléctrica', 'Ducha con resistencia eléctrica y regulación de temperatura.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(599, 'Cabezal de ducha', 'Rociador de ducha con múltiples modos de presión.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(600, 'Flexo para ducha', 'Manguera flexible para cabezal de ducha.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(601, 'Inodoro de una pieza', 'Sanitario con diseño moderno y descarga eficiente.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(602, 'Inodoro con tanque ahorrador', 'Sanitario con sistema de doble descarga.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(603, 'Lavamanos cerámico', 'Lavamanos de cerámica blanca con diseño elegante.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(604, 'Lavamanos de sobreponer', 'Lavamanos tipo bowl para instalación sobre mueble.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(605, 'Lavadero de ropa', 'Pila para lavado de ropa con escurridor.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(606, 'Sifón para lavamanos', 'Sifón de PVC flexible para desagüe de lavamanos.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(607, 'Sifón para fregadero', 'Sifón curvo de acero inoxidable para cocina.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(608, 'Válvula de desagüe', 'Válvula push para lavamanos sin rebosadero.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(609, 'Válvula de retención', 'Válvula antirretorno para evitar flujo inverso.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(610, 'Codo de PVC 90°', 'Codo de PVC para instalaciones de tuberías sanitarias.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(611, 'Codo de cobre', 'Codo de cobre para unión de tuberías de agua potable.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(612, 'Tubo PVC sanitario', 'Tubería de PVC para aguas residuales.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(613, 'Tubo de cobre', 'Tubo de cobre para conducción de agua caliente.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(614, 'Fitting de unión', 'Conector rápido para tuberías de PVC.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(615, 'Te de PVC', 'Conector en forma de T para tuberías sanitarias.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(616, 'Te de cobre', 'Pieza en T para unión de tuberías de cobre.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(617, 'Sellador de roscas', 'Cinta de teflón para evitar fugas en conexiones roscadas.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(618, 'Silicona para plomería', 'Sellador de silicona resistente al agua.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(619, 'Junta de goma', 'Empaque de goma para evitar fugas en conexiones.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(620, 'Llave de paso', 'Válvula de cierre para agua potable.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(621, 'Llave angular', 'Válvula angular para lavamanos o fregadero.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(622, 'Regadera de ducha', 'Rociador de agua con efecto tipo lluvia.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(623, 'Manguera flexible', 'Manguera de acero inoxidable para conexión de agua.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(624, 'Taza para inodoro', 'Repuesto para sanitarios de cerámica.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(625, 'Tanque de inodoro', 'Depósito de agua para inodoros con doble descarga.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(626, 'Asiento para inodoro', 'Tapa de inodoro de plástico con cierre suave.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(627, 'Dispensador de jabón', 'Dispensador manual o automático para jabón líquido.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(628, 'Toallero de pared', 'Soporte metálico para toallas de baño.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(629, 'Portarrollos', 'Soporte para papel higiénico con tapa.', 0, '0.00', '0.00', 1, 12, 1, 'activo', '2025-02-25 20:00:57'),
(984, 'Placa de drywall 1/2\"', 'Panel de yeso estándar para construcción en seco.', 0, '0.00', '0.00', 1, 13, 1, 'activo', '2025-02-25 20:03:34'),
(985, 'Placa de drywall resistente a la humedad', 'Panel de yeso especial para zonas húmedas.', 0, '0.00', '0.00', 1, 13, 1, 'activo', '2025-02-25 20:03:34'),
(986, 'Placa de drywall resistente al fuego', 'Panel de yeso con protección contra incendios.', 0, '0.00', '0.00', 1, 13, 1, 'activo', '2025-02-25 20:03:34'),
(987, 'Perfil metálico tipo riel', 'Perfil para la estructura de paredes de drywall.', 0, '0.00', '0.00', 1, 13, 1, 'activo', '2025-02-25 20:03:34'),
(988, 'Perfil metálico tipo canal', 'Perfil de soporte horizontal en estructuras de drywall.', 0, '0.00', '0.00', 1, 13, 1, 'activo', '2025-02-25 20:03:34'),
(989, 'Perfil metálico tipo montante', 'Elemento estructural vertical en muros de drywall.', 0, '0.00', '0.00', 1, 13, 1, 'activo', '2025-02-25 20:03:34'),
(990, 'Cinta de papel para juntas', 'Cinta especial para refuerzo de uniones en drywall.', 0, '0.00', '0.00', 1, 13, 1, 'activo', '2025-02-25 20:03:34'),
(991, 'Cinta malla de fibra de vidrio', 'Cinta autoadhesiva para juntas en drywall.', 0, '0.00', '0.00', 1, 13, 1, 'activo', '2025-02-25 20:03:34'),
(992, 'Masilla para drywall', 'Compuesto para relleno de juntas y tornillos en drywall.', 0, '0.00', '0.00', 1, 13, 1, 'activo', '2025-02-25 20:03:34'),
(993, 'Tornillos para drywall', 'Tornillos especiales para fijación de placas de yeso.', 0, '0.00', '0.00', 1, 13, 1, 'activo', '2025-02-25 20:03:34'),
(994, 'Anclajes y taquetes para drywall', 'Elementos de fijación para drywall.', 0, '0.00', '0.00', 1, 13, 1, 'activo', '2025-02-25 20:03:34'),
(995, 'Cuchilla para cortar drywall', 'Herramienta de precisión para corte de placas.', 0, '0.00', '0.00', 1, 13, 1, 'activo', '2025-02-25 20:03:34'),
(996, 'Lijadora para drywall', 'Lijadora especial para acabado en drywall.', 0, '0.00', '0.00', 1, 13, 1, 'activo', '2025-02-25 20:03:34'),
(997, 'Compuesto nivelador para drywall', 'Material para lograr una superficie uniforme.', 0, '0.00', '0.00', 1, 13, 1, 'activo', '2025-02-25 20:03:34'),
(998, 'Pintura base para drywall', 'Sellador para placas de drywall antes de la pintura final.', 0, '0.00', '0.00', 1, 13, 1, 'activo', '2025-02-25 20:03:34'),
(999, 'Disco de corte para metal', 'Disco abrasivo para corte de metales ferrosos y no ferrosos.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1000, 'Disco de corte para acero inoxidable', 'Disco de alta precisión para cortes limpios en acero inoxidable.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1001, 'Disco de corte para concreto', 'Disco abrasivo diseñado para cortar concreto y mampostería.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1002, 'Disco de corte diamantado', 'Disco reforzado con diamante para mayor durabilidad en cortes.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1003, 'Disco de corte segmentado', 'Disco con ranuras para mejor disipación del calor en cortes prolongados.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1004, 'Disco flap abrasivo', 'Disco con láminas abrasivas para desbaste y acabado en metales.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1005, 'Disco de desbaste para metal', 'Disco de gran resistencia para eliminar material en metales.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1006, 'Disco de desbaste para acero inoxidable', 'Disco especializado para acero inoxidable sin contaminar el material.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1007, 'Disco de desbaste para concreto', 'Disco con refuerzo especial para desbaste en superficies de concreto.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1008, 'Disco de corte multimaterial', 'Disco apto para cortar diferentes tipos de materiales.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1009, 'Lijas en hoja', 'Papel abrasivo para lijado manual de madera y metales.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1010, 'Lijas en banda', 'Bandas abrasivas para uso en lijadoras de banda.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1011, 'Lijas en disco', 'Discos de lija para uso en lijadoras orbitales y rotativas.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1012, 'Lijas esponja', 'Lija flexible para superficies curvas y detalles finos.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1013, 'Lijas tipo malla', 'Lija con estructura abierta para evitar saturación de polvo.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1014, 'Cepillo de alambre para esmeril', 'Cepillo abrasivo para limpieza y remoción de óxido.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1015, 'Cepillo de alambre circular', 'Cepillo metálico para limpieza en esmeril y taladros.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1016, 'Cepillo de alambre tipo copa', 'Cepillo con filamentos metálicos para limpieza en superficies grandes.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1017, 'Esmeril de copa', 'Accesorio abrasivo para desbaste en superficies amplias.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1018, 'Esmeril de vaso', 'Esmeril en forma de vaso para desbaste en materiales duros.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1019, 'Piedras de afilar', 'Piedras abrasivas para afilado de herramientas y cuchillas.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1020, 'Piedras de esmeril', 'Piedras abrasivas para amolado en esmeriladoras.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1021, 'Taco lijador', 'Base de apoyo para lijado manual con mayor control.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1022, 'Rollo de lija', 'Lija en formato de rollo para corte a medida.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1023, 'Lija al agua', 'Lija resistente a la humedad para acabados finos.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1024, 'Esmeril montado', 'Piedra abrasiva montada en vástago para trabajos de precisión.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1025, 'Esmeril de banco', 'Esmeril fijo para trabajos de afilado y desbaste.', 0, '0.00', '0.00', 1, 14, 1, 'activo', '2025-02-25 20:05:50'),
(1026, 'Aceite lubricante multiuso', 'Lubricante para reducir la fricción y proteger piezas mecánicas.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1027, 'Aceite lubricante para motor 10W-40', 'Aceite sintético para motores de combustión interna.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1028, 'Aceite lubricante para motor 15W-40', 'Aceite de alta viscosidad para motores diésel y gasolina.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1029, 'Aceite hidráulico', 'Aceite especializado para sistemas hidráulicos de maquinaria.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1030, 'Aceite de transmisión', 'Lubricante para cajas de cambio y diferenciales.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1031, 'Aceite para compresores', 'Lubricante diseñado para compresores de aire y refrigeración.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1032, 'Aceite para engranajes', 'Lubricante de alta viscosidad para engranajes industriales.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1033, 'Aceite para motos 4T', 'Lubricante para motores de motocicletas de cuatro tiempos.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1034, 'Aceite para motos 2T', 'Lubricante especial para motores de dos tiempos.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1035, 'Aceite para cadena de motosierra', 'Lubricante adhesivo para la cadena de motosierras.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1036, 'Grasa multiusos', 'Lubricante en grasa para rodamientos y partes móviles.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1037, 'Grasa de litio', 'Grasa de alto rendimiento con resistencia al agua.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1038, 'Grasa de cobre', 'Lubricante resistente a altas temperaturas y presión.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1039, 'Grasa de silicona', 'Lubricante dieléctrico y resistente al agua.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1040, 'Grasa para rodamientos', 'Lubricante especial para prolongar la vida útil de rodamientos.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1041, 'Grasa para cadenas', 'Lubricante en grasa adhesiva para cadenas y piñones.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1042, 'Grasa para engranajes', 'Lubricante de alta viscosidad para engranajes industriales.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1043, 'Lubricante en aerosol', 'Aceite en spray para lubricación rápida y eficiente.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1044, 'Lubricante penetrante', 'Lubricante especial para liberar piezas oxidadas.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1045, 'Lubricante antifricción', 'Reductor de fricción para piezas en movimiento.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1046, 'Lubricante para bisagras', 'Lubricante específico para evitar chirridos en bisagras y cerraduras.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1047, 'Lubricante para cadenas de bicicleta', 'Lubricante en aceite o cera para cadenas de bicicleta.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1048, 'Lubricante para herramientas eléctricas', 'Lubricante para mantener herramientas eléctricas en buen estado.', 0, '0.00', '0.00', 1, 15, 1, 'activo', '2025-02-25 20:07:20'),
(1049, 'Malla ciclónica', 'Malla metálica galvanizada ideal para cerramientos.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1050, 'Malla eslabonada', 'Malla de alambre trenzado para cercados perimetrales.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1051, 'Malla electrosoldada', 'Malla rígida y resistente para cercados de seguridad.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1052, 'Malla plástica para cercas', 'Malla de polímero resistente a la intemperie.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1053, 'Malla ganadera', 'Malla diseñada para cercados de ganado y fincas.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1054, 'Malla sombra', 'Malla para control de luz solar en cultivos y jardines.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1055, 'Malla hexagonal', 'Malla metálica para protección de aves y cultivos.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1056, 'Malla de seguridad', 'Malla reforzada para delimitaciones temporales.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1057, 'Malla antitrips', 'Malla de tejido fino para protección de cultivos.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1058, 'Alambre de púas', 'Alambre galvanizado con púas para cercados de seguridad.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1059, 'Alambre galvanizado', 'Alambre de alta resistencia para uso en cercas y estructuras.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1060, 'Alambre de acero inoxidable', 'Alambre resistente a la corrosión para diversos usos.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1061, 'Alambre de amarre', 'Alambre flexible para sujeción de estructuras y mallas.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1062, 'Alambre recocido', 'Alambre maleable ideal para ataduras y amarres.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1063, 'Cerca eléctrica', 'Sistema de seguridad con electrificación para cercados.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1064, 'Poste metálico para cerca', 'Poste de acero galvanizado para soporte de mallas.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1065, 'Poste de concreto para cerca', 'Poste prefabricado para instalación de cercados.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1066, 'Poste de madera tratada', 'Poste de madera resistente a la intemperie.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1067, 'Puerta metálica para cerca', 'Puerta de seguridad para acceso en cercados.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1068, 'Grapas para cercas', 'Sujetadores de acero para fijación de mallas y alambres.', 0, '0.00', '0.00', 1, 16, 1, 'activo', '2025-02-25 20:08:24'),
(1069, 'Bisagra oculta', 'Bisagra de cierre suave para muebles y gabinetes.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1070, 'Bisagra recta', 'Bisagra de acero inoxidable para puertas de madera.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1071, 'Cerradura para mueble', 'Cerradura metálica para gabinetes y cajoneras.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1072, 'Corredera telescópica', 'Corredera de extensión completa para cajones.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1073, 'Manija para mueble', 'Manija de acero inoxidable para puertas y cajones.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1074, 'Tirador de madera', 'Tirador rústico para muebles de madera maciza.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1075, 'Soporte para repisas', 'Soporte metálico resistente para estanterías.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1076, 'Patas de mesa ajustables', 'Patas metálicas regulables en altura.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1077, 'Patas de madera para muebles', 'Patas de madera maciza para sofás y mesas.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1078, 'Esquinero metálico', 'Refuerzo metálico para esquinas de muebles.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1079, 'Soporte de entrepaño', 'Soporte plástico para estantes de madera.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1080, 'Tornillos para madera', 'Tornillos autorroscantes para carpintería.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1081, 'Clavos sin cabeza', 'Clavos de acero ideales para fijación sin marcas visibles.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1082, 'Pegamento para madera', 'Adhesivo especial para unión de piezas de carpintería.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1083, 'Lija para madera', 'Lija en rollo y en hojas para acabado fino.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1084, 'Sargentos de presión', 'Prensas de sujeción para ensambles de madera.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1085, 'Espigas de madera', 'Espigas para unión de piezas en carpintería.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1086, 'Tapón embellecedor', 'Tapón plástico para cubrir tornillos en muebles.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1087, 'Riel para puertas corredizas', 'Sistema de rieles para puertas de closet y muebles.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1088, 'Cinta de canto', 'Cinta adhesiva para sellar bordes de tableros de MDF.', 0, '0.00', '0.00', 1, 17, 1, 'activo', '2025-02-25 20:09:48'),
(1089, 'Vidrio templado', 'Vidrio de alta resistencia para puertas y ventanas.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1090, 'Vidrio laminado', 'Vidrio de seguridad compuesto por capas intercaladas.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1091, 'Vidrio esmerilado', 'Vidrio con acabado mate para privacidad y decoración.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1092, 'Vidrio reflectivo', 'Vidrio que reduce el paso de calor y luz solar.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1093, 'Vidrio flotado', 'Vidrio liso y transparente ideal para ventanas.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1094, 'Vidrio curvado', 'Vidrio moldeado en curvas para aplicaciones especiales.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1095, 'Vidrio biselado', 'Vidrio con bordes decorativos para muebles y espejos.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1096, 'Espejo plata', 'Espejo con alta reflexión para interiores.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1097, 'Espejo bronce', 'Espejo con tono bronce para decoración.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1098, 'Acrílico transparente', 'Lámina de acrílico para uso en señalización y protección.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1099, 'Acrílico opalino', 'Lámina de acrílico translúcido para iluminación.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1100, 'Acrílico de colores', 'Láminas de acrílico en diferentes colores para diseño.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1101, 'Acrílico espejo', 'Lámina de acrílico con efecto de espejo.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1102, 'Acrílico antirreflectante', 'Lámina de acrílico que reduce reflejos y brillos.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1103, 'Policarbonato sólido', 'Lámina de policarbonato resistente a impactos.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1104, 'Policarbonato alveolar', 'Placa de policarbonato con estructura de celdas.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1105, 'Sellador para vidrios', 'Silicona especial para instalación de vidrios.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1106, 'Perfiles de aluminio', 'Perfiles para enmarcado de vidrios y acrílicos.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1107, 'Cinta doble faz para acrílicos', 'Cinta adhesiva especial para fijación de acrílicos.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1108, 'Tornillos y soportes para vidrio', 'Accesorios de fijación para estructuras de vidrio.', 0, '0.00', '0.00', 1, 18, 1, 'activo', '2025-02-27 19:55:57'),
(1109, 'Baldosa cerámica', 'Baldosas de cerámica para interiores y exteriores.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1110, 'Porcelanato brillante', 'Revestimiento de porcelanato con acabado brillante.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1111, 'Porcelanato mate', 'Revestimiento de porcelanato con acabado mate.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1112, 'Piso laminado', 'Piso flotante con acabado en madera.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1113, 'Piso vinílico', 'Revestimiento vinílico resistente al agua.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1114, 'Piso de madera maciza', 'Piso de madera natural para interiores elegantes.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1115, 'Deck de madera', 'Piso de madera para exteriores y terrazas.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1116, 'Deck de WPC', 'Revestimiento exterior en madera plástica compuesta.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1117, 'Mármol para pisos', 'Revestimiento de mármol para lujo y elegancia.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1118, 'Granito para pisos', 'Piedra natural resistente para pisos.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1119, 'Piso de concreto pulido', 'Piso industrial de concreto con acabado pulido.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1120, 'Cemento estampado', 'Revestimiento con acabado decorativo tipo piedra o madera.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1121, 'Azulejos para pisos', 'Azulejos resistentes para baños y cocinas.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1122, 'Revestimiento de piedra natural', 'Piedras decorativas para paredes y pisos.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1123, 'Revestimiento de ladrillo', 'Ladrillos decorativos para muros y suelos.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1124, 'Piso de caucho', 'Piso amortiguante para gimnasios y zonas de alto impacto.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1125, 'Piso de césped sintético', 'Revestimiento sintético para áreas deportivas y jardines.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1126, 'Pegante para cerámica', 'Pegamento especial para instalación de pisos cerámicos.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1127, 'Juntas para porcelanato', 'Material de relleno para juntas en pisos porcelánicos.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1128, 'Sellador para pisos', 'Sellador protector para pisos de madera y piedra.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:58:33'),
(1129, 'Piso de mármol travertino', 'Mármol travertino con acabado natural para interiores y exteriores.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1130, 'Loseta de cemento', 'Baldosa de cemento para pisos rústicos y decorativos.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1131, 'Piso de granito pulido', 'Granito pulido de alta resistencia para interiores.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01');
INSERT INTO `producto` (`idproducto`, `nombre`, `descripcion`, `cantidad`, `precioCompra`, `precio`, `usuario_idusuario`, `categoria_idcategoria`, `proveedor_idproveedor`, `estado`, `fecha`) VALUES
(1132, 'Láminas de vinilo autoadhesivas', 'Láminas de vinilo fáciles de instalar y resistentes a la humedad.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1133, 'Piso de PVC modular', 'Piso de PVC con ensamble modular para fácil instalación.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1134, 'Piso epóxico', 'Recubrimiento epóxico ideal para áreas industriales y comerciales.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1135, 'Piso de resina poliuretano', 'Piso de resina con alta resistencia química y mecánica.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1136, 'Piso de piedra laja', 'Revestimiento en piedra laja para exteriores y fachadas.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1137, 'Piso de adoquines de concreto', 'Pavimento en adoquines de concreto para exteriores.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1138, 'Piso de ladrillo cocido', 'Ladrillo cocido para patios y jardines.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1139, 'Revestimiento de microcemento', 'Capa delgada de microcemento para suelos y paredes.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1140, 'Piso de terrazo', 'Piso compuesto de cemento con incrustaciones de mármol.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1141, 'Revestimiento de cuarzo', 'Cuarzo triturado y resina para suelos resistentes y brillantes.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1142, 'Piso de piedra pizarra', 'Pizarra natural para suelos de alto tránsito.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1143, 'Piso de bambú', 'Piso ecológico de bambú con acabado natural.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1144, 'Piso de corcho', 'Revestimiento de corcho con alta absorción acústica.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1145, 'Piso de madera de roble', 'Madera de roble natural para suelos resistentes y elegantes.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1146, 'Piso flotante resistente al agua', 'Laminado de alta resistencia a la humedad para baños y cocinas.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1147, 'Piso de cerámica antideslizante', 'Baldosas de cerámica con acabado rugoso para evitar deslizamientos.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1148, 'Rodapié de PVC', 'Rodapié en PVC para terminaciones de suelos.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1149, 'Rodapié de madera', 'Rodapié de madera para acabados de suelos.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1150, 'Pegamento para pisos vinílicos', 'Adhesivo especializado para instalación de pisos vinílicos.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1151, 'Barniz para pisos de madera', 'Barniz protector para pisos de madera con alto tránsito.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1152, 'Aceite para pisos de madera', 'Aceite natural para tratamiento de suelos de madera.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1153, 'Protector de juntas para porcelanato', 'Sellador para proteger juntas de pisos porcelánicos.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1154, 'Baldosas hidráulicas', 'Baldosas decorativas hechas de cemento con diseños artesanales.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1155, 'Piso de caucho para parques infantiles', 'Piso de caucho acolchado para áreas de juego.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1156, 'Piso de resina acrílica', 'Revestimiento acrílico para suelos industriales.', 0, '0.00', '0.00', 1, 19, 1, 'activo', '2025-02-27 19:59:01'),
(1157, 'Generador eléctrico a gasolina 2000W', 'Generador portátil de 2000W ideal para emergencias y trabajos en exteriores.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1158, 'Generador diésel 5000W', 'Generador de alto rendimiento con motor diésel de larga duración.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1159, 'Generador solar portátil', 'Generador solar con batería recargable ideal para camping y emergencias.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1160, 'Generador inverter silencioso', 'Generador inverter ultra silencioso con tecnología de bajo consumo.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1161, 'Motor eléctrico monofásico 1HP', 'Motor eléctrico de 1 caballo de fuerza para aplicaciones industriales y domésticas.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1162, 'Motor eléctrico trifásico 5HP', 'Motor trifásico de 5 caballos de fuerza con alta eficiencia energética.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1163, 'Motor diésel 10HP', 'Motor diésel industrial de 10 caballos de fuerza para maquinaria pesada.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1164, 'Motor a gasolina 6.5HP', 'Motor de combustión interna a gasolina de 6.5 caballos de fuerza.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1165, 'Motor de corriente continua 24V', 'Motor de corriente continua para aplicaciones en robótica y automatización.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1166, 'Generador eólico 500W', 'Generador de energía eólica para sistemas de energías renovables.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1167, 'Alternador para generador 10kW', 'Alternador de alta eficiencia para generadores eléctricos de hasta 10kW.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1168, 'Batería de respaldo para generadores', 'Batería de respaldo de litio para generadores solares y eléctricos.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1169, 'Regulador de voltaje AVR', 'Regulador automático de voltaje para estabilizar generadores eléctricos.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1170, 'Arrancador de motores eléctricos', 'Arrancador automático para motores eléctricos de diferentes capacidades.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1171, 'Aceite lubricante para generadores', 'Aceite especializado para mantenimiento de generadores de combustión interna.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1172, 'Filtro de aire para motores', 'Filtro de aire para motores de generadores y maquinaria industrial.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1173, 'Panel de control para generadores', 'Panel de control digital con monitoreo de voltaje y frecuencia para generadores.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1174, 'Sistema de arranque eléctrico para generadores', 'Kit de arranque eléctrico compatible con generadores de hasta 5000W.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1175, 'Turbina hidráulica generadora de energía', 'Turbina hidráulica para generación de electricidad en sistemas de agua.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1176, 'Motor de inducción de baja potencia', 'Motor eléctrico de inducción para aplicaciones domésticas.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1177, 'Cables de conexión para generadores', 'Juego de cables reforzados para la conexión de generadores eléctricos.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1178, 'Soporte antivibración para generadores', 'Base con amortiguadores de vibraciones para generadores y motores.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1179, 'Generador a gas GLP 3000W', 'Generador de energía alimentado por gas GLP, ideal para emergencia y camping.', 0, '0.00', '0.00', 1, 20, 1, 'activo', '2025-02-27 20:10:54'),
(1180, 'Cinta métrica de 5m', 'Cinta métrica flexible de 5 metros con carcasa reforzada.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1181, 'Cinta métrica de 10m', 'Cinta métrica con doble graduación y gancho imantado.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1182, 'Nivel láser autonivelante', 'Nivel láser de línea autonivelante con trípode ajustable.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1183, 'Nivel de burbuja de 60 cm', 'Nivel de burbuja con precisión milimétrica y cuerpo de aluminio.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1184, 'Nivel de burbuja magnético', 'Nivel magnético de 40 cm ideal para estructuras metálicas.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1185, 'Calibrador Vernier digital', 'Pie de rey digital de acero inoxidable con pantalla LCD.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1186, 'Micrómetro de exteriores', 'Micrómetro de alta precisión para medición de espesores.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1187, 'Medidor de distancia láser 50m', 'Medidor láser con pantalla digital y funciones avanzadas.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1188, 'Teodolito digital', 'Instrumento de medición angular para levantamientos topográficos.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1189, 'Estación total', 'Equipo de medición para trabajos de topografía con conectividad Bluetooth.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1190, 'Nivela óptica', 'Nivel óptico de alta precisión con trípode ajustable.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1191, 'Regla de aluminio de 1m', 'Regla de aluminio con escala milimétrica y bordes reforzados.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1192, 'Regla de aluminio de 2m', 'Regla de aluminio anodizado para mediciones precisas.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1193, 'Punto láser de alineación', 'Dispositivo de alineación con rayo láser de alta precisión.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1194, 'Nivel digital con inclinómetro', 'Nivel electrónico con medición de ángulos y pantalla LED.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1195, 'Plomada magnética', 'Plomada con base imantada para trabajos de precisión en estructuras metálicas.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1196, 'Transportador de ángulos digital', 'Transportador digital con pantalla LCD y alta precisión.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1197, 'Medidor de humedad para madera', 'Dispositivo digital para medir el contenido de humedad en la madera.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1198, 'Medidor de humedad para concreto', 'Medidor de humedad de alta precisión para construcción.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1199, 'Nivel láser rotativo', 'Nivel láser giratorio para grandes obras y precisión en altura.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1200, 'Cinta métrica láser', 'Medidor de distancia con cinta métrica integrada y medición láser.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1201, 'Altímetro digital', 'Medidor de altura digital con precisión milimétrica.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1202, 'Reloj comparador con base magnética', 'Instrumento de medición de precisión con soporte magnético.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1203, 'Goniómetro digital', 'Goniómetro con pantalla digital para medición de ángulos complejos.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:03'),
(1204, 'Medidor de espesores ultrasónico', 'Medidor digital de espesores con tecnología ultrasónica.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1205, 'Clinómetro digital', 'Instrumento de medición de inclinación con pantalla LCD.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1206, 'Nivel torpedo magnético', 'Nivel compacto con base magnética y burbujas de precisión.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1207, 'Medidor de presión digital', 'Medidor de presión portátil con pantalla digital.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1208, 'Medidor de espesor de pintura', 'Medidor de espesor para recubrimientos y pintura en metales.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1209, 'Cinta métrica de fibra de vidrio 30m', 'Cinta de fibra de vidrio con mango ergonómico.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1210, 'Nivel láser de 360°', 'Nivel láser con línea completa en 360 grados para alineaciones.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1211, 'Distanciómetro ultrasónico', 'Medidor de distancia ultrasónico con precisión avanzada.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1212, 'Nivel de burbuja de 120 cm', 'Nivel de alta precisión con estructura de aluminio reforzado.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1213, 'Trípode para nivel láser', 'Trípode ajustable en altura para soportar niveles láser.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1214, 'Receptor láser para nivelación', 'Dispositivo que mejora la precisión de los niveles láser.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1215, 'Marcador de profundidad', 'Herramienta de medición para marcar profundidades exactas.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1216, 'Regla flexible de acero inoxidable', 'Regla flexible para medición en superficies curvas.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1217, 'Medidor de pH digital', 'Dispositivo portátil para medir el pH de líquidos y suelos.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1218, 'Balanza de precisión digital', 'Balanza digital con sensibilidad de 0.01 gramos.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1219, 'Manómetro de presión', 'Manómetro para medición de presión en líquidos y gases.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1220, 'Medidor de velocidad del viento', 'Anemómetro digital para medir velocidad del viento y temperatura.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1221, 'Goniómetro mecánico', 'Instrumento mecánico para medición de ángulos de forma manual.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1222, 'Regla con escuadra ajustable', 'Regla multifuncional con escuadra de ángulo variable.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1223, 'Brújula de precisión', 'Brújula para trabajos de orientación y nivelación.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1224, 'Medidor de corriente digital', 'Pinza amperimétrica para medir corriente eléctrica sin contacto.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1225, 'Cronómetro digital', 'Dispositivo de medición de tiempo con alta precisión.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1226, 'Medidor de dureza portátil', 'Instrumento digital para medición de dureza en materiales.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1227, 'Altímetro barométrico', 'Dispositivo para medición de altura y presión atmosférica.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1228, 'Medidor de vibraciones', 'Dispositivo digital para medición de vibraciones en estructuras.', 0, '0.00', '0.00', 1, 23, 1, 'activo', '2025-02-27 20:16:29'),
(1229, 'Impermeabilizante acrílico', 'Impermeabilizante acrílico flexible para techos y terrazas.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1230, 'Membrana asfáltica en rollo', 'Lámina asfáltica autoadhesiva para impermeabilización de cubiertas.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1231, 'Pintura impermeabilizante elástica', 'Recubrimiento elástico para paredes y techos con efecto hidrofóbico.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1232, 'Impermeabilizante cementoso', 'Impermeabilizante en base cementosa para piscinas y sótanos.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1233, 'Sellador de juntas impermeabilizante', 'Sellador de poliuretano para juntas y grietas en fachadas.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1234, 'Cinta impermeabilizante autoadhesiva', 'Cinta impermeable para sellado de grietas y filtraciones.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1235, 'Aditivo impermeabilizante para concreto', 'Aditivo líquido para hacer impermeable el concreto y mortero.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1236, 'Manta impermeabilizante líquida', 'Impermeabilizante en forma líquida para aplicación directa.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1237, 'Impermeabilizante reflectivo térmico', 'Impermeabilizante que reduce la temperatura de superficies.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1238, 'Resina impermeabilizante epóxica', 'Resina epóxica impermeabilizante para suelos y muros.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1239, 'Impermeabilizante de poliuretano', 'Recubrimiento de poliuretano para cubiertas y terrazas.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1240, 'Gel impermeabilizante para fachadas', 'Gel de protección contra humedad para fachadas de concreto.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1241, 'Barniz impermeabilizante para madera', 'Barniz protector de agua y humedad para muebles y exteriores.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1242, 'Emulsión asfáltica impermeabilizante', 'Recubrimiento asfáltico impermeabilizante para techos y muros.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1243, 'Impermeabilizante para terrazas transitables', 'Recubrimiento para terrazas con alta resistencia al tránsito.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1244, 'Recubrimiento elastomérico impermeable', 'Impermeabilizante elastomérico flexible y resistente.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1245, 'Acrilpol impermeabilizante', 'Recubrimiento impermeabilizante acrílico de alta durabilidad.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1246, 'Cemento impermeabilizante para tanques', 'Cemento de alta adherencia para impermeabilizar tanques de agua.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1247, 'Sellador impermeabilizante para tejas', 'Sellador para tejas de barro y cemento resistente a la intemperie.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1248, 'Impermeabilizante acrílico con fibras', 'Impermeabilizante reforzado con fibras para mayor resistencia.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1249, 'Pintura impermeabilizante para muros', 'Pintura hidrofóbica para muros expuestos a la humedad.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1250, 'Impermeabilizante bicomponente', 'Impermeabilizante en dos componentes para estructuras enterradas.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1251, 'Fieltro impermeabilizante', 'Fieltro reforzado para impermeabilización de techos y cubiertas.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1252, 'Tela asfáltica impermeabilizante', 'Tela con asfalto modificado para impermeabilización de estructuras.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1253, 'Impermeabilizante para baños y cocinas', 'Impermeabilizante ideal para zonas con alta humedad.', 0, '0.00', '0.00', 1, 24, 1, 'activo', '2025-02-27 20:20:56'),
(1254, 'Tanque de almacenamiento de agua 500L', 'Tanque plástico de alta resistencia para almacenamiento de agua potable.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1255, 'Tanque de almacenamiento de agua 1000L', 'Tanque de polietileno de alta densidad con capacidad de 1000 litros.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1256, 'Tanque de almacenamiento de agua 2500L', 'Tanque de gran capacidad para almacenamiento de agua potable y riego.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1257, 'Tanque de almacenamiento de agua 5000L', 'Tanque reforzado con tapa hermética para uso en grandes volúmenes.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1258, 'Tanque séptico 600L', 'Sistema de tratamiento primario para aguas residuales domésticas.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1259, 'Tanque séptico 1200L', 'Tanque de tratamiento de aguas negras con alta resistencia química.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1260, 'Tanque de almacenamiento de químicos', 'Tanque especializado para almacenamiento seguro de productos químicos.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1261, 'Tanque de polietileno reforzado', 'Tanque para almacenamiento de líquidos industriales y agrícolas.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1262, 'Tanque metálico para agua', 'Tanque de acero galvanizado para almacenamiento de agua potable.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1263, 'Tanque elevado 2000L', 'Tanque para instalación en altura con salida de alta presión.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1264, 'Tanque modular de almacenamiento', 'Sistema de tanques modulares interconectables para grandes volúmenes.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1265, 'Tanque de recolección de agua lluvia', 'Tanque para captación y reutilización de agua pluvial.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1266, 'Tanque flexible para agua potable', 'Tanque portátil y flexible ideal para transporte de agua.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1267, 'Tanque subterráneo de almacenamiento', 'Tanque diseñado para ser enterrado y optimizar espacio.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1268, 'Tanque de presión para sistemas hidráulicos', 'Tanque con membrana interna para regulación de presión en redes hidráulicas.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1269, 'Tanque de almacenamiento de diésel', 'Tanque seguro para almacenamiento de combustible diésel.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1270, 'Tanque de almacenamiento de aceite', 'Tanque con recubrimiento especial para aceites industriales.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1271, 'Tanque para riego agrícola', 'Tanque de gran capacidad para sistemas de riego por gravedad o presión.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1272, 'Tanque transportable para agua', 'Tanque con ruedas y estructura metálica para fácil movilidad.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1273, 'Tanque isotérmico para líquidos', 'Tanque con aislamiento térmico para líquidos sensibles a temperatura.', 0, '0.00', '0.00', 1, 25, 1, 'activo', '2025-02-27 20:22:35'),
(1274, 'Tela Asfáltica APP 3mm', 'Membrana impermeabilizante con refuerzo de fibra de vidrio, ideal para cubiertas y terrazas.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1275, 'Tela Asfáltica APP 4mm', 'Impermeabilización de alta resistencia para cubiertas expuestas al sol.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1276, 'Tela Asfáltica SBS 3mm', 'Membrana flexible con betún modificado, ideal para climas fríos.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1277, 'Tela Asfáltica SBS 4mm', 'Refuerzo de poliéster para alta resistencia mecánica.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1278, 'Tela Asfáltica con Aluminio 4mm', 'Revestimiento reflectivo para reducir el calor en cubiertas.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1279, 'Tela Asfáltica Autoadhesiva', 'Fácil aplicación sin necesidad de soplete.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1280, 'Manta Asfáltica Autoadhesiva', 'Ideal para impermeabilización de muros y cimentaciones.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1281, 'Lámina Asfáltica con Geotextil', 'Aislante de humedad con refuerzo para suelos.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1282, 'Lámina de Polietileno para Aislamiento', 'Aislamiento térmico y de humedad para cubiertas y paredes.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1283, 'Panel de Lana de Roca', 'Aislamiento térmico y acústico resistente al fuego.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1284, 'Panel de Poliuretano', 'Aislamiento térmico de alta eficiencia para paredes y techos.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1285, 'Espuma de Poliuretano Expansiva', 'Relleno y sellado de juntas y huecos.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1286, 'Placas de Poliestireno Expandido (EPS)', 'Aislamiento térmico ligero para techos y muros.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1287, 'Rollo de Lana Mineral', 'Aislante térmico y acústico para techos y paredes.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1288, 'Membrana Líquida Impermeabilizante', 'Revestimiento elástico para cubiertas y terrazas.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1289, 'Cinta Asfáltica Autoadhesiva', 'Sellado de juntas y grietas en techos y paredes.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1290, 'Membrana Bituminosa con Refuerzo', 'Impermeabilización de alta resistencia para estructuras enterradas.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1291, 'Manta Geotextil No Tejida', 'Protección y drenaje en impermeabilización de suelos y cubiertas.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1292, 'Rollo de Fieltro Asfáltico', 'Aislante de humedad para cubiertas inclinadas.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1293, 'Lámina de Aluminio Aislante', 'Aislante térmico reflectivo para techos y muros.', 0, '0.00', '0.00', 1, 26, 1, 'activo', '2025-02-27 20:33:26'),
(1294, 'Tubería de Polietileno para Riego', 'Tubería flexible para sistemas de riego por goteo y aspersión.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1295, 'Manguera de Goteo', 'Manguera con emisores integrados para riego eficiente.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1296, 'Cinta de Riego por Goteo', 'Cinta delgada con perforaciones para riego agrícola.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1297, 'Aspersor de Impacto', 'Aspersor giratorio para riego de grandes áreas.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1298, 'Microaspersores', 'Aspersores pequeños para cultivos y jardines.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1299, 'Emisores de Goteo Regulables', 'Goteros ajustables para control de flujo de agua.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1300, 'Filtros para Riego', 'Filtros para evitar obstrucciones en sistemas de riego.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1301, 'Válvula de Control de Riego', 'Válvulas para regular el flujo de agua en sistemas de riego.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1302, 'Electroválvula para Riego', 'Válvula eléctrica para automatización del riego.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1303, 'Programador de Riego', 'Sistema automatizado para programar tiempos de riego.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1304, 'Bomba de Agua para Riego', 'Bomba para extracción y distribución de agua en riego agrícola.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1305, 'Tanque de Almacenamiento de Agua', 'Depósito para almacenamiento de agua de riego.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1306, 'Sensor de Humedad para Riego', 'Dispositivo para medir la humedad del suelo y optimizar el riego.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1307, 'Boquillas para Aspersores', 'Diferentes tipos de boquillas para aspersores de riego.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1308, 'Uniones y Accesorios de Riego', 'Conectores, tees, codos y uniones para tuberías de riego.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1309, 'Drenajes Subterráneos', 'Sistemas de tuberías perforadas para drenaje agrícola.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1310, 'Tubería Corrugada para Drenaje', 'Tubería flexible para evacuación de aguas.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1311, 'Caja de Registro para Drenaje', 'Caja para facilitar la inspección y mantenimiento de drenajes.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1312, 'Rejillas para Drenaje', 'Rejillas de protección para drenajes en suelos y pavimentos.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1313, 'Malla Antiraíces para Riego', 'Malla para evitar obstrucciones en tuberías de riego.', 0, '0.00', '0.00', 1, 27, 1, 'activo', '2025-02-27 20:36:25'),
(1314, 'Panel Solar Monocristalino 400W', 'Panel solar de alta eficiencia para sistemas fotovoltaicos.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1315, 'Panel Solar Policristalino 300W', 'Panel solar de silicio policristalino para instalaciones solares.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1316, 'Kit Solar Residencial 2kW', 'Sistema solar completo con inversor, baterías y paneles para hogar.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1317, 'Controlador de Carga MPPT 60A', 'Controlador de carga de alta eficiencia para paneles solares.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1318, 'Controlador de Carga PWM 30A', 'Regulador de carga para sistemas solares de 12V y 24V.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1319, 'Inversor de Onda Pura 3000W 24V', 'Convierte corriente continua en alterna para sistemas solares.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1320, 'Inversor Híbrido 5000W 48V', 'Inversor solar con cargador incorporado para sistemas fotovoltaicos.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1321, 'Batería Solar de Litio 200Ah', 'Batería de almacenamiento de energía para sistemas solares.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1322, 'Batería de Gel 150Ah 12V', 'Batería de ciclo profundo para instalaciones solares.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1323, 'Estructura Soporte para Paneles Solares', 'Soportes de aluminio para la instalación de paneles solares.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1324, 'Cable Solar 6mm²', 'Cable especial para conexión de paneles solares.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1325, 'Conector MC4 para Panel Solar', 'Conector impermeable para paneles solares.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1326, 'Microinversor Solar 600W', 'Inversor compacto para optimizar el rendimiento de cada panel.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1327, 'Aerogenerador 1kW 24V', 'Turbina eólica para generación de energía renovable.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1328, 'Sistema Solar Portátil 100W', 'Kit de energía solar portátil con batería integrada.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1329, 'Farola Solar LED 100W', 'Luminaria autónoma con panel solar integrado.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1330, 'Calentador Solar de Agua 200L', 'Sistema de calentamiento de agua por energía solar.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1331, 'Bomba Solar para Agua 1HP', 'Bomba sumergible que funciona con energía solar.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1332, 'Regulador Eólico MPPT', 'Controlador de carga para turbinas eólicas.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1333, 'Torre para Aerogenerador 6m', 'Soporte metálico para turbinas eólicas.', 0, '0.00', '0.00', 1, 28, 1, 'activo', '2025-02-27 20:37:47'),
(1334, 'Cinta Adhesiva Transparente 48mm x 100m', 'Cinta adhesiva de alta resistencia para embalaje.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1335, 'Cinta Adhesiva Marrón 48mm x 100m', 'Cinta adhesiva color marrón ideal para cajas de cartón.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1336, 'Cinta Doble Faz 24mm x 10m', 'Cinta adhesiva de doble cara para fijaciones permanentes.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1337, 'Cinta Masking Tape 24mm x 50m', 'Cinta de enmascarar para pintura y manualidades.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1338, 'Cinta de Enmascarar Automotriz 18mm x 45m', 'Cinta especial para trabajos de pintura automotriz.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1339, 'Cinta de Embalaje Reforzada 48mm x 50m', 'Cinta adhesiva reforzada con filamentos de fibra de vidrio.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1340, 'Cinta Aislante Negra 19mm x 20m', 'Cinta aislante para trabajos eléctricos.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1341, 'Cinta Aislante de Alta Tensión 19mm x 10m', 'Cinta especial para instalaciones eléctricas de alto voltaje.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1342, 'Cinta Antideslizante Negra 50mm x 10m', 'Cinta adhesiva con textura rugosa para superficies seguras.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1343, 'Cinta Reflectiva Roja y Blanca 5cm x 45m', 'Cinta adhesiva reflectante para señalización.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1344, 'Cinta de Aluminio 48mm x 50m', 'Cinta adhesiva de aluminio para aislamiento térmico y ductos.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1345, 'Cinta de Teflón para Roscas 12mm x 10m', 'Cinta selladora para conexiones de plomería.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1346, 'Cinta Adhesiva de Papel Kraft 48mm x 50m', 'Cinta ecológica biodegradable para embalajes.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1347, 'Film Stretch Transparente 50cm x 300m', 'Película plástica para envolver y proteger mercancías.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1348, 'Film Stretch Negro 50cm x 300m', 'Película estirable negra para embalaje discreto.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1349, 'Cinta Adhesiva de Seguridad con Mensaje', 'Cinta con impresión para precintos de seguridad.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1350, 'Cinta Adhesiva Industrial Resistente 50mm x 50m', 'Cinta adhesiva de uso rudo para aplicaciones industriales.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1351, 'Cinta VHB de Alta Resistencia 12mm x 5m', 'Cinta adhesiva ultra fuerte para fijaciones permanentes.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1352, 'Cinta de Espuma Adhesiva 10mm x 2m', 'Cinta con base de espuma para fijaciones y sellado.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1353, 'Cinta Adhesiva para Moqueta 50mm x 25m', 'Cinta adhesiva de doble cara para alfombras y moquetas.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:14'),
(1354, 'Cinta Adhesiva de Seguridad con Sellado Invulnerable', 'Cinta con tecnología de seguridad para evitar manipulaciones.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1355, 'Cinta de Fibra de Vidrio 50mm x 50m', 'Cinta reforzada con fibra de vidrio para máxima resistencia.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1356, 'Cinta Adhesiva para Alta Temperatura 25mm x 30m', 'Cinta resistente a altas temperaturas, ideal para procesos industriales.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1357, 'Cinta Kapton 10mm x 33m', 'Cinta adhesiva de poliamida resistente a calor extremo.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1358, 'Cinta de Señalización Amarilla y Negra 50mm x 33m', 'Cinta adhesiva para marcación de áreas de seguridad.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1359, 'Cinta Adhesiva para Empaque Frágil 48mm x 50m', 'Cinta con impresión \"FRÁGIL\" para embalajes delicados.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1360, 'Cinta Adhesiva de Tela Impermeable 50mm x 25m', 'Cinta adhesiva reforzada con tela resistente al agua.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1361, 'Cinta de Señalización Fotoluminiscente 50mm x 10m', 'Cinta adhesiva que brilla en la oscuridad para señalización.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1362, 'Cinta Adhesiva Conductiva de Cobre 25mm x 10m', 'Cinta con capacidad de conducción eléctrica para electrónica.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1363, 'Cinta Adhesiva Reforzada con Hilo 50mm x 50m', 'Cinta extra fuerte con hilos de refuerzo para embalajes pesados.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1364, 'Cinta de Aluminio con Revestimiento 50mm x 50m', 'Cinta metálica con protección extra para aislamiento.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1365, 'Cinta de Goma Autovulcanizable 19mm x 10m', 'Cinta adhesiva que se fusiona para aislamiento y reparaciones.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1366, 'Cinta de Papel Crepé 50mm x 50m', 'Cinta adhesiva de papel crepé para manualidades y pintura.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1367, 'Cinta de Doble Cara Acrílica 24mm x 10m', 'Cinta adhesiva acrílica transparente de alta adherencia.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1368, 'Cinta Adhesiva para Suelos 50mm x 33m', 'Cinta resistente al tráfico para delimitación de áreas en el suelo.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1369, 'Cinta Barrera de Seguridad 75mm x 200m', 'Cinta no adhesiva para delimitar áreas restringidas.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1370, 'Cinta Adhesiva para Reparación de Plásticos 50mm x 5m', 'Cinta especial para reparaciones rápidas de plásticos.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1371, 'Cinta Adhesiva de Tela para Cableado 25mm x 25m', 'Cinta de tela adhesiva utilizada en cableado automotriz.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1372, 'Cinta Adhesiva de PVC Antiestática 19mm x 20m', 'Cinta especial antiestática para componentes electrónicos.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1373, 'Cinta de Polietileno para Sellado 50mm x 50m', 'Cinta adhesiva de polietileno para sellado de juntas.', 0, '0.00', '0.00', 1, 29, 1, 'activo', '2025-02-27 20:41:34'),
(1374, 'Cono de Tránsito Reflectivo 75cm', 'Cono de seguridad vial con cinta reflectante para alta visibilidad.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1375, 'Barrera Vial Plegable 1.2m', 'Barrera portátil para delimitar zonas de seguridad en vías.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1376, 'Tachón Reflectivo Amarillo', 'Tachón de señalización vial con reflectantes de alta intensidad.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1377, 'Tachón Solar LED Blanco', 'Tachón con luz LED solar para señalización nocturna.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1378, 'Señal de Tránsito PARE 60x60cm', 'Señal vial reflectiva con mensaje \"PARE\".', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1379, 'Señal de Velocidad Máxima 40km/h', 'Señal vial reglamentaria con límite de velocidad.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1380, 'Poste Delineador Flexible con Base', 'Delineador vial flexible con base de goma para zonas de tránsito.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1381, 'Lenteja Reflectiva Blanca', 'Lenteja de señalización vial con reflectividad de alto desempeño.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1382, 'Cinta Reflectiva Roja y Blanca 5cm x 50m', 'Cinta adhesiva para señalización de alta visibilidad.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1383, 'Barricada Plegable Amarilla', 'Barricada liviana y portátil para cierre de áreas de seguridad.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1384, 'Espejo Convexo de Seguridad 60cm', 'Espejo de tráfico para mejorar la visibilidad en esquinas y accesos.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1385, 'Topes de Estacionamiento de Caucho', 'Tope para parqueaderos que evita colisiones con bordes.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1386, 'Bolardo Metálico con Reflectivo', 'Bolardo de protección vial con material reflectante.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1387, 'Chaleco Reflectivo de Alta Visibilidad', 'Chaleco de seguridad con bandas reflectantes para operarios.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1388, 'Lámpara de Advertencia LED con Base Magnética', 'Luz de seguridad recargable con base imantada para vehículos.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1389, 'Cinta de Peligro Roja y Blanca 100m', 'Cinta no adhesiva para delimitar zonas de riesgo.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1390, 'Valla Metálica de Seguridad 2m', 'Estructura metálica portátil para control de tráfico.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1391, 'Base de Goma para Conos de Tránsito', 'Base adicional para mayor estabilidad de conos de seguridad.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1392, 'Disco PARE Retráctil para Control Vial', 'Señal portátil con base plegable para operativos de tránsito.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1393, 'Luz de Emergencia para Carretera', 'Baliza LED con múltiples modos de destello para advertencia vial.', 0, '0.00', '0.00', 1, 30, 1, 'activo', '2025-02-27 20:43:02'),
(1394, 'Andamio Metálico Modular', 'Estructura de acero para trabajos en altura.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1395, 'Plataforma de Trabajo Plegable', 'Plataforma liviana y resistente para trabajos de construcción.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1396, 'Caballetes Metálicos Reforzados', 'Soportes para trabajo en construcción y carpintería.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1397, 'Escalera de Fibra de Vidrio 6 Escalones', 'Escalera dieléctrica resistente para uso en obra.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1398, 'Mesa de Trabajo Plegable para Obra', 'Mesa portátil y resistente para trabajos de construcción.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1399, 'Banco de Trabajo con Ruedas', 'Banco con superficie de trabajo y ruedas para fácil movilidad.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1400, 'Sillas para Obreros con Respaldo', 'Sillas resistentes para descanso en obra.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1401, 'Carretilla de Obra Reforzada', 'Carretilla de acero con rueda neumática para transporte de materiales.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1402, 'Tablones de Madera para Encofrado', 'Tablones resistentes para estructuras temporales de obra.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1403, 'Cercas de Seguridad para Obras', 'Paneles de seguridad para delimitar zonas de construcción.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1404, 'Caseta Móvil para Obreros', 'Módulo portátil para oficina y descanso en obra.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1405, 'Baño Portátil para Construcción', 'Unidad sanitaria portátil para obras.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1406, 'Contenedor de Herramientas Metálico', 'Caja de almacenamiento para herramientas de construcción.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1407, 'Pupitres para Salas de Capacitación', 'Mobiliario para formación de personal en obra.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1408, 'Grúa Portátil de Construcción', 'Estructura móvil para levantar materiales pesados.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1409, 'Carpa de Sombra para Obreros', 'Estructura portátil para protección solar en obra.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1410, 'Vallas Publicitarias para Obras', 'Paneles informativos para proyectos de construcción.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1411, 'Estantería Metálica para Materiales', 'Rack de almacenamiento para herramientas y suministros.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1412, 'Mesa de Corte para Materiales', 'Mesa resistente con soporte para cortes de precisión.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1413, 'Banco de Mezcla para Albañilería', 'Estructura para preparación de mezclas de cemento.', 0, '0.00', '0.00', 1, 31, 1, 'activo', '2025-02-27 20:44:39'),
(1414, 'Andamio Metálico Modular', 'Estructura de acero resistente para trabajos en altura.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1415, 'Andamio de Aluminio Plegable', 'Andamio ligero y portátil para trabajos en interiores y exteriores.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1416, 'Andamio Multifuncional con Ruedas', 'Andamio versátil con ruedas para fácil desplazamiento.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1417, 'Andamio Tubular con Plataformas', 'Andamio reforzado con plataformas para mayor estabilidad.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1418, 'Andamio de Fibra de Vidrio', 'Andamio dieléctrico para trabajos eléctricos y de telecomunicaciones.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1419, 'Andamio en Torre con Barandas', 'Estructura de andamio con protección perimetral para mayor seguridad.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1420, 'Escalera de Aluminio de 6 Peldaños', 'Escalera liviana y resistente para tareas de mantenimiento.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1421, 'Escalera Telescópica de 4.4m', 'Escalera extensible compacta y fácil de transportar.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1422, 'Escalera de Fibra de Vidrio de 8 Peldaños', 'Escalera dieléctrica ideal para trabajos eléctricos.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1423, 'Escalera de Tijera con Plataforma', 'Escalera autoportante con superficie estable para trabajos prolongados.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1424, 'Escalera Extensible de Doble Sección', 'Escalera de aluminio de gran altura, ideal para trabajos industriales.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1425, 'Escalera Plegable Multipropósito', 'Escalera convertible en diferentes posiciones para múltiples usos.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1426, 'Plataforma de Trabajo Plegable', 'Superficie resistente para trabajos en altura con estabilidad.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1427, 'Barandilla de Seguridad para Andamios', 'Accesorio de seguridad para evitar caídas en trabajos elevados.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1428, 'Ruedas para Andamios', 'Set de ruedas reforzadas para facilitar el desplazamiento de andamios.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1429, 'Gato de Nivelación para Andamios', 'Accesorio para ajustar la altura y nivelar estructuras de andamios.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1430, 'Escalera de Acceso para Andamios', 'Escalera de acople para facilitar el acceso a estructuras de andamios.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1431, 'Escalera de Madera para Obras', 'Escalera tradicional de madera para construcción y mantenimiento.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1432, 'Pasarela para Andamios', 'Plataforma de conexión entre andamios para desplazamiento seguro.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1433, 'Andamio Suspendido Motorizado', 'Sistema de andamio colgante para trabajos en fachadas.', 0, '0.00', '0.00', 1, 32, 1, 'activo', '2025-02-27 20:46:15'),
(1434, 'Casco de Seguridad Tipo 1', 'Casco de polietileno con suspensión ajustable para protección en obra.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08');
INSERT INTO `producto` (`idproducto`, `nombre`, `descripcion`, `cantidad`, `precioCompra`, `precio`, `usuario_idusuario`, `categoria_idcategoria`, `proveedor_idproveedor`, `estado`, `fecha`) VALUES
(1435, 'Casco de Seguridad con Barbiquejo', 'Casco reforzado con barboquejo de 4 puntos para mayor estabilidad.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1436, 'Gafas de Seguridad Antiempañantes', 'Gafas resistentes a impactos y con tratamiento antiempañante.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1437, 'Gafas de Protección con Filtro UV', 'Gafas con protección UV y antiarañazos para trabajos al aire libre.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1438, 'Protector Auditivo Tipo Copa', 'Orejeras de protección auditiva con alta reducción de ruido.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1439, 'Tapones Auditivos de Espuma', 'Tapones desechables de espuma con reducción de ruido.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1440, 'Mascarilla N95', 'Mascarilla con filtro N95 para protección contra partículas en suspensión.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1441, 'Respirador de Doble Filtro', 'Respirador con cartuchos reemplazables para vapores y gases.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1442, 'Guantes de Nitrilo Resistentes', 'Guantes de nitrilo sin polvo para protección química y mecánica.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1443, 'Guantes de Cuero para Soldadura', 'Guantes reforzados en cuero para altas temperaturas.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1444, 'Guantes Anticorte Nivel 5', 'Guantes de seguridad con máxima resistencia al corte.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1445, 'Botas de Seguridad con Punta de Acero', 'Botas industriales con puntera de acero y suela antideslizante.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1446, 'Botas Dieléctricas de Caucho', 'Botas aislantes para trabajos eléctricos de alto voltaje.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1447, 'Arnés de Seguridad de 5 Puntos', 'Arnés con certificación para trabajos en altura.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1448, 'Línea de Vida Retráctil', 'Sistema de seguridad para prevenir caídas en trabajos elevados.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1449, 'Chaleco Reflectivo Alta Visibilidad', 'Chaleco de seguridad con cintas reflectivas para visibilidad nocturna.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1450, 'Traje de Bioseguridad Desechable', 'Traje impermeable desechable para trabajos en ambientes contaminados.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1451, 'Rodilleras para Trabajo', 'Rodilleras acolchonadas para protección en trabajos de impacto.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1452, 'Careta para Soldadura Automática', 'Careta con oscurecimiento automático para trabajos de soldadura.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1453, 'Faja de Soporte Lumbar', 'Faja ajustable para protección de la zona lumbar en trabajos pesados.', 0, '0.00', '0.00', 1, 33, 1, 'activo', '2025-02-27 20:48:08'),
(1454, 'Cable THHN 12 AWG', 'Cable eléctrico de cobre con aislamiento THHN, calibre 12 AWG.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1455, 'Cable THHN 10 AWG', 'Cable eléctrico de cobre con aislamiento THHN, calibre 10 AWG.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1456, 'Cable THHN 8 AWG', 'Cable eléctrico de cobre con aislamiento THHN, calibre 8 AWG.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1457, 'Cable THHN 6 AWG', 'Cable eléctrico de cobre con aislamiento THHN, calibre 6 AWG.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1458, 'Cable TW 14 AWG', 'Cable eléctrico de cobre con aislamiento TW, calibre 14 AWG.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1459, 'Cable TW 12 AWG', 'Cable eléctrico de cobre con aislamiento TW, calibre 12 AWG.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1460, 'Cable Flexible 12 AWG', 'Cable flexible con aislamiento de PVC, calibre 12 AWG.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1461, 'Cable Flexible 10 AWG', 'Cable flexible con aislamiento de PVC, calibre 10 AWG.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1462, 'Cable de Red UTP Cat 5e', 'Cable de datos UTP categoría 5e para redes Ethernet.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1463, 'Cable de Red UTP Cat 6', 'Cable de datos UTP categoría 6 para redes de alta velocidad.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1464, 'Cable Coaxial RG6', 'Cable coaxial para televisión y antenas, tipo RG6.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1465, 'Cable Coaxial RG59', 'Cable coaxial para cámaras de seguridad, tipo RG59.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1466, 'Cable de Seguridad Blindado', 'Cable blindado para sistemas de seguridad y alarmas.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1467, 'Cable para Altavoces 14 AWG', 'Cable para altavoces con conductores de cobre, calibre 14 AWG.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1468, 'Cable para Altavoces 16 AWG', 'Cable para altavoces con conductores de cobre, calibre 16 AWG.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1469, 'Conector RJ45 Cat 5e', 'Conector modular RJ45 para cableado de red UTP Cat 5e.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1470, 'Conector RJ45 Cat 6', 'Conector modular RJ45 para cableado de red UTP Cat 6.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1471, 'Conector Coaxial F Macho', 'Conector tipo F macho para cable coaxial RG6.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1472, 'Conector BNC para RG59', 'Conector BNC de compresión para cable coaxial RG59.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1473, 'Terminal de Ojal 12-10 AWG', 'Terminal de ojal para cables eléctricos de 12-10 AWG.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1474, 'Terminal de Pala 16-14 AWG', 'Terminal de pala para cables eléctricos de 16-14 AWG.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1475, 'Terminal de Empalme 22-18 AWG', 'Terminal de empalme aislado para cables de 22-18 AWG.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1476, 'Regleta de Conexión 12P', 'Regleta de conexión de 12 polos para conexiones eléctricas.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1477, 'Conector Rápido para Cable', 'Conector rápido para uniones eléctricas sin necesidad de soldadura.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:19'),
(1478, 'Cable Subterráneo 12 AWG', 'Cable eléctrico subterráneo con aislamiento resistente.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1479, 'Cable Subterráneo 10 AWG', 'Cable eléctrico subterráneo de cobre con recubrimiento especial.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1480, 'Cable Trenzado 2x14 AWG', 'Cable trenzado para conexiones eléctricas exteriores.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1481, 'Cable Trenzado 2x16 AWG', 'Cable trenzado de cobre con aislamiento PVC.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1482, 'Cable de Cobre Desnudo 4 AWG', 'Cable de cobre desnudo para sistemas de puesta a tierra.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1483, 'Cable de Cobre Desnudo 6 AWG', 'Cable de cobre trenzado sin aislamiento.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1484, 'Cable de Alumbrado Público', 'Cable eléctrico especial para alumbrado público.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1485, 'Cable de Carga para Baterías', 'Cable resistente para carga de baterías y sistemas automotrices.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1486, 'Cable Tipo SPT-1', 'Cable eléctrico tipo SPT-1 para electrodomésticos.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1487, 'Cable Tipo SPT-2', 'Cable flexible tipo SPT-2 para aplicaciones domésticas.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1488, 'Cable de Alta Temperatura', 'Cable con aislamiento resistente a altas temperaturas.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1489, 'Cable Blindado para Datos', 'Cable blindado para protección contra interferencias electromagnéticas.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1490, 'Conector de Empalme Rápido', 'Conector de empalme rápido para cables de hasta 12 AWG.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1491, 'Conector de Empalme Tipo Wago', 'Conector de presión tipo Wago para conexiones sin herramientas.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1492, 'Conector de Tornillo para Cables', 'Conector de tornillo para cables de 10 a 18 AWG.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1493, 'Regleta de Conexión 24P', 'Regleta de conexión de 24 polos con base de cerámica.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1494, 'Regleta de Conexión Modular', 'Regleta modular para instalaciones eléctricas.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1495, 'Conector para Cable de Batería', 'Conector reforzado para terminales de batería.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1496, 'Terminal Anular de Cobre', 'Terminal anular de cobre para conexiones de alta resistencia.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1497, 'Terminal Aislado de Empalme', 'Terminal de empalme aislado para uniones seguras.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1498, 'Cinta Aislante para Alta Tensión', 'Cinta aislante especial para alta tensión.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1499, 'Cinta de Autovulcanizado', 'Cinta para reparaciones y sellado de cables eléctricos.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1500, 'Cinta Reflectante para Cables', 'Cinta reflectante para señalización de cables en exteriores.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1501, 'Cinta de Protección UV', 'Cinta con resistencia UV para cableado expuesto al sol.', 0, '0.00', '0.00', 1, 34, 1, 'activo', '2025-02-27 20:51:33'),
(1502, 'Controlador Inteligente WiFi', 'Controlador central para automatización del hogar compatible con asistentes de voz.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1503, 'Interruptor Inteligente WiFi', 'Interruptor de luz con conectividad WiFi y control remoto desde app móvil.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1504, 'Sensor de Movimiento Inteligente', 'Sensor de movimiento con alertas en tiempo real y conexión a hub domótico.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1505, 'Sensor de Temperatura y Humedad', 'Sensor IoT para monitoreo ambiental en tiempo real con notificaciones.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1506, 'Enchufe Inteligente WiFi', 'Enchufe con control remoto por app y programación de encendido/apagado.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1507, 'Cerradura Inteligente', 'Cerradura electrónica con acceso mediante código, huella dactilar y app móvil.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1508, 'Cámara de Seguridad WiFi', 'Cámara IP de alta definición con detección de movimiento y visión nocturna.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1509, 'Timbre Inteligente con Cámara', 'Timbre con video en vivo, micrófono y notificaciones en el teléfono.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1510, 'Motor para Cortinas Automáticas', 'Sistema de motorización para cortinas con control remoto y app.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1511, 'Hub de Automatización', 'Centro de control para dispositivos domóticos con compatibilidad multiplataforma.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1512, 'Detector de Humo Inteligente', 'Sensor de humo con notificaciones en tiempo real y alarma sonora.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1513, 'Controlador de Iluminación RGB', 'Controlador de luces LED RGB con conexión WiFi y control por voz.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1514, 'Regulador de Intensidad de Luz', 'Dimmer inteligente para control de intensidad de iluminación desde el móvil.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1515, 'Sistema de Riego Inteligente', 'Controlador de riego automatizado con programación remota.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1516, 'Termostato Inteligente', 'Controlador de temperatura para climatización eficiente.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1517, 'Sensor de Puertas y Ventanas', 'Sensor magnético con alertas en caso de apertura no autorizada.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1518, 'Repetidor WiFi para Domótica', 'Extensor de señal WiFi para mejorar conectividad de dispositivos IoT.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1519, 'Sirena Inteligente de Seguridad', 'Sirena de alto volumen con control remoto desde aplicación móvil.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1520, 'Control Remoto Universal WiFi', 'Dispositivo para controlar televisores, aires acondicionados y más desde el móvil.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1521, 'Controlador de Persianas Inteligente', 'Automatiza la apertura y cierre de persianas mediante app o voz.', 0, '0.00', '0.00', 1, 35, 1, 'activo', '2025-02-27 20:54:21'),
(1522, 'Bombillo LED E27 9W', 'Bombillo LED de 9W, luz blanca, alta eficiencia energética.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1523, 'Bombillo LED E27 15W', 'Bombillo LED de 15W, luz cálida, ideal para interiores.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1524, 'Tubo LED T8 18W', 'Tubo LED T8 de 18W, reemplazo eficiente para tubos fluorescentes.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1525, 'Panel LED 60x60 40W', 'Panel LED de techo 60x60 cm, luz blanca neutra, bajo consumo.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1526, 'Reflector LED 50W', 'Reflector LED de 50W para exteriores, resistente al agua (IP65).', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1527, 'Reflector LED Solar 100W', 'Reflector LED solar de 100W con sensor de movimiento.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1528, 'Foco LED GU10 7W', 'Foco LED tipo GU10, ideal para iluminación de acento.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1529, 'Foco LED MR16 5W', 'Foco LED MR16, 5W, luz cálida para decoración y ambientes acogedores.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1530, 'Lámpara LED de Emergencia', 'Lámpara LED recargable con autonomía de hasta 6 horas.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1531, 'Tira LED RGB 5m', 'Tira LED de 5 metros RGB con control remoto y múltiples efectos.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1532, 'Tira LED Blanca 5m', 'Tira LED de 5 metros, luz blanca neutra, ideal para decoración.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1533, 'Lámpara LED Industrial 100W', 'Campana LED de 100W para iluminación de galpones y fábricas.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1534, 'Lámpara de Escritorio LED', 'Lámpara LED flexible con ajuste de intensidad y puerto USB.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1535, 'Farola LED Solar 60W', 'Farola LED solar con panel integrado, ideal para alumbrado público.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1536, 'Lámpara LED para Jardín', 'Lámpara LED de jardín con estaca, ideal para exteriores.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1537, 'Lámpara LED de Techo', 'Lámpara LED moderna para techos, diseño minimalista.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1538, 'Lámpara LED Colgante', 'Lámpara colgante con iluminación LED, ideal para interiores.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1539, 'Foco LED Inteligente RGB', 'Foco LED con control por WiFi, ajustable en color e intensidad.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1540, 'Linterna LED Recargable', 'Linterna LED de alta potencia con batería recargable.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1541, 'Foco LED para Piscina', 'Foco LED sumergible con control remoto para piscinas.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:57:41'),
(1542, 'Lámpara LED Panel 24W', 'Lámpara panel LED cuadrada de 24W, luz blanca neutra.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1543, 'Lámpara LED Ovalada 18W', 'Lámpara LED de techo ovalada de 18W, resistente a humedad.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1544, 'Foco LED PAR38 15W', 'Foco LED PAR38 de 15W, ideal para exteriores y jardines.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1545, 'Foco LED G9 5W', 'Foco LED tipo G9, 5W, luz cálida y compacta.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1546, 'Foco LED G4 3W', 'Foco LED G4 de 3W, pequeño y de bajo consumo.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1547, 'Lámpara LED Solar para Camino', 'Lámpara LED solar con estaca para caminos y senderos.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1548, 'Lámpara LED de Pared Exterior', 'Aplique de pared LED resistente a la intemperie.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1549, 'Lámpara LED de Pared Interior', 'Aplique LED decorativo para interiores, diseño moderno.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1550, 'Lámpara LED Suspendida 60W', 'Lámpara colgante LED de 60W, ideal para oficinas.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1551, 'Lámpara LED para Espejo', 'Luz LED para espejos de baño con instalación sencilla.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1552, 'Foco LED para Automóvil H4', 'Foco LED para faros de automóvil, alta luminosidad.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1553, 'Foco LED para Moto H7', 'Foco LED para motocicletas con mayor duración.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1554, 'Lámpara LED para Cocina', 'Lámpara LED lineal para cocinas modernas.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1555, 'Lámpara LED de Escritorio con Batería', 'Lámpara LED recargable con autonomía de 8 horas.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1556, 'Proyector LED 200W', 'Proyector LED de 200W para grandes áreas exteriores.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1557, 'Luz LED de Emergencia Portátil', 'Luz LED de emergencia con batería recargable.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1558, 'Tubo LED Sensor Movimiento', 'Tubo LED con sensor de movimiento, ideal para garajes.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1559, 'Lámpara LED Solar con Sensor', 'Lámpara solar LED con sensor de movimiento.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1560, 'Tira LED Inteligente WiFi', 'Tira LED RGB controlable por WiFi y asistente de voz.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1561, 'Lámpara LED para Acuario', 'Luz LED sumergible para acuarios, colores RGB.', 0, '0.00', '0.00', 1, 36, 1, 'activo', '2025-02-27 20:58:02'),
(1562, 'Electrodo 6013 3/32\"', 'Electrodo para soldadura revestido rutílico, ideal para trabajos generales.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1563, 'Electrodo 7018 1/8\"', 'Electrodo de baja hidrogeno para soldaduras estructurales.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1564, 'Electrodo de acero inoxidable 308L', 'Electrodo de acero inoxidable para soldadura de metales resistentes a la corrosión.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1565, 'Varilla de soldadura TIG ER70S-6', 'Varilla para soldadura TIG en acero al carbono.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1566, 'Varilla de soldadura TIG ER308L', 'Varilla TIG para acero inoxidable, alta resistencia a la corrosión.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1567, 'Alambre MIG ER70S-6 1.0mm', 'Alambre para soldadura MIG en acero al carbono.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1568, 'Alambre MIG inoxidable 308L', 'Alambre MIG de acero inoxidable para aplicaciones de alta resistencia.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1569, 'Alambre Flux Cored E71T-1', 'Alambre tubular con fundente para soldadura sin gas.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1570, 'Máquina de soldar inverter 200A', 'Soldadora inverter compacta de 200A para electrodos revestidos.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1571, 'Máquina de soldar MIG 250A', 'Soldadora MIG con alimentación de alambre y opción de gas.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1572, 'Máquina de soldar TIG 200A', 'Equipo de soldadura TIG con alta frecuencia para acero y aluminio.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1573, 'Regulador de gas para soldadura', 'Regulador de presión para cilindros de gas de soldadura.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1574, 'Manguera para gas de soldadura', 'Manguera resistente para suministro de gas en soldadura.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1575, 'Pinza de masa para soldadura', 'Pinza de masa para conexión a tierra en soldadura.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1576, 'Pinza porta electrodo', 'Pinza ergonómica para sujetar electrodos en soldadura manual.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1577, 'Antorcha TIG WP-17', 'Antorcha TIG refrigerada por aire para aplicaciones generales.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1578, 'Antorcha MIG con euroconector', 'Antorcha MIG con conexión estándar para equipos de soldadura.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1579, 'Pistola de plasma corte 40A', 'Pistola para corte por plasma de metales de hasta 10mm de espesor.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1580, 'Casco de soldador automático', 'Casco de soldador con oscurecimiento automático.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1581, 'Guantes de soldador de cuero', 'Guantes resistentes al calor para trabajos de soldadura.', 0, '0.00', '0.00', 1, 37, 1, 'activo', '2025-02-27 20:59:46'),
(1582, 'Llave de Impacto Neumática 1/2\"', 'Llave de impacto de 1/2\" con alto torque para mecánica automotriz.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1583, 'Llave de Impacto Neumática 3/4\"', 'Llave de impacto de 3/4\" ideal para trabajos industriales y automotrices.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1584, 'Taladro Neumático Reversible', 'Taladro neumático de alta potencia con función reversible.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1585, 'Amoladora Neumática Angular', 'Amoladora de 4.5\" con sistema neumático para trabajos de corte y pulido.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1586, 'Esmeriladora Neumática Recta', 'Herramienta ideal para desbaste y acabados en metal y madera.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1587, 'Lijadora Neumática Orbital', 'Lijadora orbital neumática para acabados profesionales en madera y metal.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1588, 'Lijadora de Banda Neumática', 'Lijadora neumática de banda angosta para trabajos de precisión.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1589, 'Pistola de Pintura Neumática HVLP', 'Pistola de pintura con tecnología HVLP para acabados finos.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1590, 'Pistola de Pintura de Alta Presión', 'Pistola neumática para aplicación de pintura en superficies amplias.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1591, 'Pistola de Soplado Neumática', 'Pistola de aire para limpieza de equipos y piezas mecánicas.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1592, 'Remachadora Neumática', 'Remachadora neumática de alta velocidad para trabajos industriales.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1593, 'Cizalla Neumática para Chapa', 'Cizalla de aire para corte preciso de láminas metálicas.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1594, 'Martillo Neumático para Demolición', 'Martillo neumático con cinceles intercambiables para demolición de concreto.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1595, 'Engrapadora Neumática para Madera', 'Herramienta neumática para fijación rápida de grapas en carpintería.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1596, 'Clavadora Neumática Industrial', 'Clavadora de aire comprimido para trabajos de construcción y carpintería.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1597, 'Cortador Neumático de Metales', 'Cortador de aire para metales con disco de corte de 3\".', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1598, 'Bomba Neumática para Aceite', 'Bomba de transferencia neumática para aceites y lubricantes.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1599, 'Bomba Neumática para Combustibles', 'Bomba de aire comprimido para transferencia de diésel y gasolina.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1600, 'Cortadora de Plasma Neumática', 'Cortadora de plasma de alta precisión para metales ferrosos y no ferrosos.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1601, 'Accesorios para Herramientas Neumáticas', 'Kit de mangueras, conectores y lubricadores para herramientas neumáticas.', 0, '0.00', '0.00', 1, 39, 1, 'activo', '2025-02-27 21:03:19'),
(1602, 'Aire acondicionado Split 12000 BTU', 'Equipo de aire acondicionado tipo split con eficiencia energética.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1603, 'Aire acondicionado Split 24000 BTU', 'Aire acondicionado para espacios grandes, bajo consumo energético.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1604, 'Mini Split Inverter 18000 BTU', 'Aire acondicionado inverter con ahorro de energía y control remoto.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1605, 'Aire acondicionado portátil 9000 BTU', 'Unidad portátil con control de temperatura y ruedas para fácil traslado.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1606, 'Ventilador de torre oscilante', 'Ventilador de torre con múltiples velocidades y control remoto.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1607, 'Ventilador de pared industrial', 'Ventilador de alta potencia para ventilación de espacios grandes.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1608, 'Calefactor eléctrico portátil', 'Calefactor de aire caliente con protección contra sobrecalentamiento.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1609, 'Radiador eléctrico de aceite', 'Calefactor de aceite con termostato y múltiples niveles de potencia.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1610, 'Calefactor infrarrojo de pared', 'Calefacción de bajo consumo con tecnología infrarroja.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1611, 'Deshumidificador 20L', 'Dispositivo para eliminar la humedad del aire y prevenir moho.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1612, 'Humidificador ultrasónico', 'Aparato para mejorar la calidad del aire con vapor frío.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1613, 'Extractor de aire industrial', 'Extractor de aire para mejorar la ventilación en talleres y fábricas.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1614, 'Tubo flexible para aire acondicionado portátil', 'Accesorio para redirigir el aire caliente de equipos portátiles.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1615, 'Filtro de carbón activado para aire acondicionado', 'Filtro de aire para purificación y eliminación de olores.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1616, 'Termostato digital programable', 'Dispositivo para controlar la temperatura de calefacción y aire acondicionado.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1617, 'Bomba de calor para piscina', 'Sistema de calefacción eficiente para mantener la temperatura del agua.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1618, 'Chimenea eléctrica decorativa', 'Chimenea sin humo con efecto de fuego realista.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1619, 'Ventilador industrial de pedestal', 'Ventilador potente con aspas de aluminio y altura ajustable.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1620, 'Cortina de aire para puertas comerciales', 'Dispositivo para evitar pérdida de temperatura en entradas de locales.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1621, 'Kit de instalación para aire acondicionado Split', 'Accesorios y tuberías para la instalación de equipos Split.', 0, '0.00', '0.00', 1, 40, 1, 'activo', '2025-02-27 21:05:22'),
(1622, 'Reja de seguridad para ventana', 'Reja metálica con diseño reforzado para protección de ventanas.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1623, 'Reja de hierro forjado', 'Reja decorativa para jardines y entradas con acabados en hierro forjado.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1624, 'Puerta metálica de seguridad', 'Puerta de acero reforzado con cerradura de alta seguridad.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1625, 'Puerta enrollable de acero', 'Puerta metálica enrollable para garajes y locales comerciales.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1626, 'Portón corredizo de hierro', 'Portón metálico de gran tamaño con sistema corredizo.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1627, 'Baranda de acero inoxidable', 'Baranda resistente para escaleras y balcones.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1628, 'Estructura metálica para techado', 'Soporte de acero para cubiertas de techo en bodegas y patios.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1629, 'Reja plegable de seguridad', 'Reja metálica extensible para puertas y ventanas.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1630, 'Valla metálica galvanizada', 'Valla de acero galvanizado para cercado de terrenos y jardines.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1631, 'Malla metálica de seguridad', 'Malla resistente para cerramientos de áreas industriales.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1632, 'Poste metálico para rejas', 'Poste de acero para instalación de cercas y rejas.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1633, 'Escalera metálica industrial', 'Escalera de hierro con peldaños antideslizantes.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1634, 'Estructura de acero para mezzanine', 'Marco estructural metálico para construcción de entrepisos.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1635, 'Reja de protección para mascotas', 'Reja desmontable para delimitar áreas en interiores y exteriores.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1636, 'Soportes metálicos para estantería', 'Soportes de hierro para instalación de repisas y estanterías.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1637, 'Toldo metálico retráctil', 'Estructura metálica con lona extensible para protección solar.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1638, 'Cerradura electromagnética para puertas metálicas', 'Sistema de cierre con control de acceso digital.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1639, 'Barrera metálica de contención', 'Barreras de seguridad para eventos y control de tráfico.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1640, 'Marco de acero para puertas', 'Marco resistente para instalación de puertas metálicas.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1641, 'Puerta batiente de acero', 'Puerta metálica de doble hoja con sistema de apertura batiente.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:18'),
(1642, 'Puerta metálica industrial', 'Puerta reforzada para fábricas y bodegas.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1643, 'Puerta metálica con mirilla', 'Puerta de seguridad con visor de vidrio templado.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1644, 'Portón seccional de acero', 'Portón de paneles deslizantes para garajes.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1645, 'Puerta metálica corta fuego', 'Puerta resistente al fuego con certificación de seguridad.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1646, 'Portón de aluminio reforzado', 'Portón ligero con gran resistencia a la intemperie.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1647, 'Reja decorativa de hierro', 'Reja metálica con diseños ornamentales para exteriores.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1648, 'Reja de protección para escaleras', 'Reja metálica para evitar caídas en escaleras y balcones.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1649, 'Cerramiento metálico industrial', 'Paneles de acero para delimitar áreas en fábricas y almacenes.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1650, 'Cerramiento de malla eslabonada', 'Malla de acero galvanizado para cercados.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1651, 'Verja de hierro modular', 'Sistema modular de rejas para cercos de seguridad.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1652, 'Portón automatizado de acero', 'Portón metálico con sistema de apertura automática.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1653, 'Reja para ventanas antirrobo', 'Reja metálica con diseño antivandalismo.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1654, 'Cerradura biométrica para puertas metálicas', 'Cerradura con lector de huellas digitales.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1655, 'Puerta de acero inoxidable', 'Puerta resistente a la corrosión y humedad.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1656, 'Escaleras metálicas para exteriores', 'Escaleras de acero galvanizado para exteriores.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1657, 'Pasamanos metálico para rampas', 'Pasamanos de acero inoxidable para accesibilidad.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1658, 'Puerta acústica metálica', 'Puerta con aislamiento acústico para estudios y oficinas.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1659, 'Valla de contención reforzada', 'Valla metálica de seguridad para eventos y obras.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1660, 'Puerta de acero galvanizado', 'Puerta metálica resistente a la corrosión.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1661, 'Barrera de protección peatonal', 'Estructura metálica para delimitar pasos peatonales.', 0, '0.00', '0.00', 1, 41, 1, 'activo', '2025-02-27 21:12:34'),
(1662, 'Tablero MDF 18mm', 'Tablero de fibra de densidad media para carpintería y muebles.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1663, 'Tablero aglomerado 15mm', 'Tablero compuesto de partículas de madera prensada.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1664, 'Madera pino cepillada 2x4', 'Madera estructural para construcción y carpintería.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1665, 'Madera roble maciza', 'Madera de alta resistencia ideal para muebles y pisos.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1666, 'Tablero OSB 11mm', 'Tablero de virutas orientadas para construcción y encofrados.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1667, 'Madera teca natural', 'Madera tropical resistente a la humedad y plagas.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1668, 'Tablero melamínico blanco', 'Tablero recubierto con melamina para muebles y estanterías.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1669, 'Contrachapado fenólico 18mm', 'Tablero de madera contrachapada resistente a la humedad.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1670, 'Lámina de triplex 4mm', 'Lámina delgada de madera contrachapada para interiores.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1671, 'Madera cedro rojo', 'Madera resistente y aromática para ebanistería.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1672, 'Tablero de pino alistonado', 'Tablero macizo compuesto de listones de pino encolados.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1673, 'Lámina de madera wengué', 'Madera exótica de color oscuro para muebles de lujo.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1674, 'Madera nogal maciza', 'Madera dura de tono oscuro utilizada en carpintería fina.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1675, 'Panel de bambú estructural', 'Tablero ecológico y sostenible para muebles y revestimientos.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1676, 'Chapa de madera natural', 'Lámina delgada de madera para recubrimientos y acabados.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1677, 'Madera de abeto laminada', 'Material estructural utilizado en vigas y construcción.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1678, 'Tablero de corcho prensado', 'Tablero liviano para aislamiento térmico y acústico.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1679, 'Madera de eucalipto tratada', 'Madera de rápido crecimiento resistente a la humedad.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1680, 'Tablero de madera reciclada', 'Tablero ecológico fabricado con restos de madera reutilizados.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1681, 'Listón de madera torneado', 'Listón de madera para barandillas y detalles decorativos.', 0, '0.00', '0.00', 1, 43, 1, 'activo', '2025-02-27 21:20:11'),
(1682, 'Desengrasante industrial', 'Poderoso limpiador para eliminar grasa y aceites.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1683, 'Detergente multiusos', 'Detergente líquido para limpieza general en fábricas y talleres.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1684, 'Jabón antibacterial', 'Jabón líquido con propiedades desinfectantes para manos.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1685, 'Limpiador ácido para metales', 'Limpia y desoxida metales en ambientes industriales.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1686, 'Desinfectante de superficies', 'Elimina bacterias y virus en áreas de trabajo y oficinas.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1687, 'Cloro industrial', 'Desinfectante y blanqueador de alto rendimiento para superficies.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1688, 'Alcohol isopropílico', 'Solvente y desinfectante para equipos electrónicos e industriales.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1689, 'Espuma limpiadora multiusos', 'Limpia y desinfecta superficies sin dañar acabados.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1690, 'Cera para pisos industriales', 'Protege y da brillo a pisos de alto tráfico.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1691, 'Removedor de óxido', 'Fórmula para eliminar óxido de herramientas y estructuras metálicas.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1692, 'Limpiador de vidrios', 'Producto especializado para eliminar suciedad y grasa de vidrios.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1693, 'Shampoo para alfombras', 'Limpia y desinfecta alfombras industriales y comerciales.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1694, 'Gel antibacterial industrial', 'Desinfectante en gel para manos sin enjuague.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1695, 'Neutralizador de olores', 'Elimina olores fuertes en ambientes industriales.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1696, 'Quitamanchas para textiles', 'Producto para remover manchas difíciles en ropa de trabajo.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1697, 'Absorbente industrial', 'Granulado para absorber derrames de aceites y químicos.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1698, 'Toallas desinfectantes', 'Toallas prehumedecidas para limpieza rápida de superficies.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1699, 'Pasta lavamanos con abrasivos', 'Limpia grasas y aceites sin dañar la piel.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1700, 'Removedor de adhesivos', 'Solvente industrial para eliminar pegamentos y residuos.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1701, 'Detergente biodegradable', 'Producto ecológico para limpieza en industrias.', 0, '0.00', '0.00', 1, 48, 1, 'activo', '2025-02-27 21:23:38'),
(1702, 'Toldo retráctil', 'Toldo de lona resistente con mecanismo retráctil manual o automático.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1703, 'Toldo fijo', 'Estructura fija con lona impermeable para protección solar y de lluvia.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1704, 'Carpa plegable 3x3m', 'Carpa portátil de fácil armado para exteriores.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1705, 'Carpa tipo pabellón', 'Estructura grande con lona reforzada para eventos.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1706, 'Lona plástica reforzada', 'Lona impermeable de uso industrial con ojales para fijación.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1707, 'Lona para camión', 'Lona ultra resistente para cubrir cargas de transporte pesado.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1708, 'Lona de sombra', 'Tela especial para generar sombra y reducir la temperatura.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1709, 'Toldo para ventana', 'Toldo decorativo con lona acrílica y estructura metálica.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1710, 'Carpa tipo túnel', 'Estructura curva con lona resistente para almacenamiento o eventos.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1711, 'Carpa industrial', 'Carpa grande reforzada para almacenamiento en exteriores.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1712, 'Toldo de policarbonato', 'Estructura con láminas de policarbonato para terrazas y patios.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1713, 'Lona ignífuga', 'Tela con tratamiento especial para resistencia al fuego.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1714, 'Toldo enrollable', 'Toldo con sistema de enrollado para control de luz y sombra.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1715, 'Carpa para feria', 'Carpa modular desmontable para eventos y exposiciones.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1716, 'Lona transparente', 'Lona plástica transparente para cubiertas o cerramientos temporales.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1717, 'Toldo con estructura de aluminio', 'Sistema liviano pero resistente con lona impermeable.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1718, 'Lona vinílica', 'Tela plástica gruesa con resistencia a la intemperie.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1719, 'Carpa militar', 'Carpa reforzada para campamentos y operaciones en exteriores.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1720, 'Cubierta para piscina', 'Lona especial para proteger el agua de suciedad y evaporación.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1721, 'Toldo para jardín', 'Toldo decorativo con estructura para jardines y terrazas.', 0, '0.00', '0.00', 1, 49, 1, 'activo', '2025-02-27 21:25:23'),
(1722, 'Extintor de polvo químico seco', 'Extintor ABC para fuegos de clase A, B y C.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1723, 'Extintor de CO₂', 'Extintor para incendios eléctricos y líquidos inflamables.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1724, 'Extintor de espuma', 'Extintor ideal para incendios de materiales sólidos y líquidos inflamables.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1725, 'Gabinete para extintor', 'Caja metálica de seguridad para almacenar extintores.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1726, 'Manta ignífuga', 'Tela especial resistente al fuego para sofocar llamas.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1727, 'Señalización de emergencia', 'Carteles de señalización para rutas de evacuación y equipos de emergencia.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1728, 'Sistema de rociadores automáticos', 'Sistema de aspersores de agua activados por calor.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1729, 'Alarma contra incendios', 'Sistema de detección y aviso de incendios.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1730, 'Detector de humo', 'Dispositivo para alertar la presencia de humo en el ambiente.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1731, 'Detector de monóxido de carbono', 'Dispositivo para identificar niveles peligrosos de CO en el aire.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1732, 'Hidrante contra incendios', 'Sistema de suministro de agua para bomberos.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1733, 'Manguera contra incendios', 'Manguera de alta presión para sofocar incendios.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1734, 'Bomba contra incendios', 'Bomba de agua para alimentar sistemas contra incendios.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1735, 'Puerta cortafuego', 'Puerta resistente al fuego para contener incendios en edificios.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1736, 'Pintura intumescente', 'Pintura que se expande con el calor para proteger estructuras metálicas.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1737, 'Gel retardante de fuego', 'Sustancia para recubrimiento de superficies inflamables.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1738, 'Botiquín de emergencia', 'Kit de primeros auxilios para situaciones de incendio.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1739, 'Casco de bombero', 'Casco de seguridad resistente al calor y golpes.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1740, 'Guantes ignífugos', 'Guantes resistentes a altas temperaturas.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1741, 'Ropa de bombero', 'Traje resistente al fuego para protección en incendios.', 0, '0.00', '0.00', 1, 50, 1, 'activo', '2025-02-27 21:29:49'),
(1742, 'Martillo de uña', 'Martillo de acero con mango de madera para clavar y extraer clavos.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1743, 'Destornillador plano', 'Destornillador de punta plana para tornillos ranurados.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1744, 'Destornillador de estrella', 'Destornillador de cruz para tornillos Phillips.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1745, 'Llave inglesa', 'Llave ajustable para tuercas y pernos.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1746, 'Llave de tubo', 'Llave para apretar y aflojar pernos y tuercas en espacios reducidos.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50');
INSERT INTO `producto` (`idproducto`, `nombre`, `descripcion`, `cantidad`, `precioCompra`, `precio`, `usuario_idusuario`, `categoria_idcategoria`, `proveedor_idproveedor`, `estado`, `fecha`) VALUES
(1747, 'Alicate universal', 'Alicate con función de sujeción, corte y doblado de alambres.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1748, 'Alicate de punta', 'Alicate de precisión para trabajos eléctricos y mecánicos.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1749, 'Cinta métrica', 'Cinta de medición de 5 metros con carcasa resistente.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1750, 'Serrucho de mano', 'Serrucho con hoja de acero templado para corte de madera.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1751, 'Formón para madera', 'Cincel de acero con mango ergonómico para tallado de madera.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1752, 'Nivel de burbuja', 'Herramienta para verificar la nivelación de superficies.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1753, 'Llave Allen', 'Juego de llaves hexagonales para tornillos Allen.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1754, 'Corta pernos', 'Herramienta para cortar varillas y alambres gruesos.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1755, 'Pinza de presión', 'Pinza ajustable para sujetar objetos con firmeza.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1756, 'Sierra para metales', 'Sierra manual con hoja de acero para corte de metales.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1757, 'Cincel para concreto', 'Herramienta para trabajos de demolición y tallado en concreto.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1758, 'Llave de carraca', 'Llave con mecanismo de trinquete para ajuste rápido.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1759, 'Extractor de tornillos', 'Herramienta para remover tornillos dañados o desgastados.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1760, 'Juego de limas', 'Conjunto de limas para acabado en madera y metal.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50'),
(1761, 'Cepillo de carpintero', 'Herramienta manual para rebajar y pulir madera.', 0, '0.00', '0.00', 1, 59, 1, 'activo', '2025-02-27 21:32:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `idproveedor` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` double NOT NULL,
  `estado` enum('activo','inactivo') DEFAULT 'activo',
  `usuario_idusuario` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`idproveedor`, `nombre`, `telefono`, `estado`, `usuario_idusuario`) VALUES
(1, 'otro', 0, 'activo', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(10) UNSIGNED NOT NULL,
  `usuario` varchar(50) DEFAULT NULL,
  `clave` varchar(255) DEFAULT NULL,
  `nit` varchar(20) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `direccion` varchar(30) DEFAULT NULL,
  `estado` enum('activo','inactivo') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `usuario`, `clave`, `nit`, `telefono`, `direccion`, `estado`) VALUES
(1, 'manuela', '$2y$10$ep0v3bJQzEYTqoiUtG8pX.LfH.5Ulp.iMk4w6LQjJtpyLkEeKNcYy', '0000', '0000', '43rewr', 'activo'),
(24, 'camilo', '$2y$10$1z3i4Ysty42aGg7uOfOy8.FkTtPqGO0ZMnyoEmBzqcxL5lbaJtddi', '', '', '', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `idventa` int(10) UNSIGNED NOT NULL,
  `usuario_idusuario` int(10) UNSIGNED NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `total` decimal(15,2) DEFAULT NULL,
  `nombre_cliente` varchar(100) DEFAULT NULL,
  `telefono_cliente` varchar(20) DEFAULT NULL,
  `efectivo` decimal(15,2) DEFAULT NULL,
  `cambio` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`idventa`, `usuario_idusuario`, `fecha`, `total`, `nombre_cliente`, `telefono_cliente`, `efectivo`, `cambio`) VALUES
(206, 1, '2025-04-02 21:04:19', '5000.00', '', '', '30000.00', '25000.00'),
(207, 1, '2025-04-03 23:31:10', '10000.00', '', '', '88888.00', '83888.00');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`),
  ADD KEY `categoria_FKIndex1` (`usuario_idusuario`);

--
-- Indices de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  ADD PRIMARY KEY (`idcotizacion`),
  ADD KEY `fk_cotizacion_usuario` (`usuario_idusuario`);

--
-- Indices de la tabla `detalle_cotizacion`
--
ALTER TABLE `detalle_cotizacion`
  ADD PRIMARY KEY (`iddetalle`),
  ADD KEY `fk_detalle_cotizacion` (`cotizacion_idcotizacion`),
  ADD KEY `fk_detalle_producto` (`producto_idproducto`);

--
-- Indices de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD PRIMARY KEY (`iddetalle`),
  ADD KEY `detalle_venta_FKIndex` (`venta_idventa`),
  ADD KEY `detalle_producto_FKIndex` (`producto_idproducto`);

--
-- Indices de la tabla `nomina`
--
ALTER TABLE `nomina`
  ADD PRIMARY KEY (`idnomina`),
  ADD KEY `usuario_idusuario` (`usuario_idusuario`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`),
  ADD KEY `fk_persona_usuario` (`usuario_idusuario`);

--
-- Indices de la tabla `persona_nomina`
--
ALTER TABLE `persona_nomina`
  ADD PRIMARY KEY (`idpersona`,`idnomina`),
  ADD KEY `idnomina` (`idnomina`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`idproducto`),
  ADD KEY `producto_FKIndex3` (`usuario_idusuario`),
  ADD KEY `producto_ibfk_1` (`categoria_idcategoria`),
  ADD KEY `fk_producto_proveedor` (`proveedor_idproveedor`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`idproveedor`),
  ADD KEY `fk_proveedor_usuario` (`usuario_idusuario`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`idventa`),
  ADD KEY `venta_usuario_FKIndex` (`usuario_idusuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  MODIFY `idcotizacion` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalle_cotizacion`
--
ALTER TABLE `detalle_cotizacion`
  MODIFY `iddetalle` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  MODIFY `iddetalle` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=672;

--
-- AUTO_INCREMENT de la tabla `nomina`
--
ALTER TABLE `nomina`
  MODIFY `idnomina` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1003100743;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `idproducto` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1762;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `idproveedor` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `idventa` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=208;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD CONSTRAINT `categoria_ibfk_1` FOREIGN KEY (`usuario_idusuario`) REFERENCES `usuario` (`idusuario`);

--
-- Filtros para la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  ADD CONSTRAINT `fk_cotizacion_usuario` FOREIGN KEY (`usuario_idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_cotizacion`
--
ALTER TABLE `detalle_cotizacion`
  ADD CONSTRAINT `fk_detalle_cotizacion` FOREIGN KEY (`cotizacion_idcotizacion`) REFERENCES `cotizacion` (`idcotizacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_detalle_producto` FOREIGN KEY (`producto_idproducto`) REFERENCES `producto` (`idproducto`);

--
-- Filtros para la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD CONSTRAINT `detalle_producto_fk` FOREIGN KEY (`producto_idproducto`) REFERENCES `producto` (`idproducto`),
  ADD CONSTRAINT `detalle_venta_fk` FOREIGN KEY (`venta_idventa`) REFERENCES `ventas` (`idventa`);

--
-- Filtros para la tabla `nomina`
--
ALTER TABLE `nomina`
  ADD CONSTRAINT `nomina_ibfk_1` FOREIGN KEY (`usuario_idusuario`) REFERENCES `usuario` (`idusuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `fk_persona_usuario` FOREIGN KEY (`usuario_idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `persona_nomina`
--
ALTER TABLE `persona_nomina`
  ADD CONSTRAINT `persona_nomina_ibfk_1` FOREIGN KEY (`idpersona`) REFERENCES `persona` (`idpersona`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `persona_nomina_ibfk_2` FOREIGN KEY (`idnomina`) REFERENCES `nomina` (`idnomina`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `fk_producto_proveedor` FOREIGN KEY (`proveedor_idproveedor`) REFERENCES `proveedor` (`idproveedor`),
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`categoria_idcategoria`) REFERENCES `categoria` (`idcategoria`),
  ADD CONSTRAINT `producto_ibfk_3` FOREIGN KEY (`usuario_idusuario`) REFERENCES `usuario` (`idusuario`);

--
-- Filtros para la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD CONSTRAINT `fk_proveedor_usuario` FOREIGN KEY (`usuario_idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `venta_usuario_fk` FOREIGN KEY (`usuario_idusuario`) REFERENCES `usuario` (`idusuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
