<?php
require_once __DIR__ . '/../vendor/autoload.php'; // Asegúrate de que esta ruta sea correcta

if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

include '../config/conexion.php';

// Verificar si el usuario está autenticado
if (!isset($_SESSION['usuario']) || !isset($_SESSION['usuario_id'])) {
    echo json_encode(['error' => 'No autorizado.']);
    exit();
}

$usuario_id = $_SESSION['usuario_id']; // Guardar el ID del usuario en una variable

function obtenerDetallesUsuario($conn, $usuario_id) {
    $sql = "SELECT usuario, nit, telefono, direccion FROM usuario WHERE idusuario = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $usuario_id);
    $stmt->execute();
    return $stmt->get_result()->fetch_assoc();
}

// Función para obtener detalles de la venta
function obtenerDetallesVenta($conn, $venta_id, $usuario_id) {
    $sql = "SELECT * FROM ventas WHERE idventa = ?  AND usuario_idusuario = ? ORDER BY idventa DESC";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ii", $venta_id, $usuario_id);
    $stmt->execute();
    $venta = $stmt->get_result()->fetch_assoc();

    if ($venta) {
        $sql_detalle = "SELECT d.*, p.nombre FROM detalle_ventas d 
                        JOIN producto p ON d.producto_idproducto = p.idproducto 
                        WHERE d.venta_idventa = ?";
        $stmt_detalle = $conn->prepare($sql_detalle);
        $stmt_detalle->bind_param("i", $venta_id);
        $stmt_detalle->execute();
        $detalles = $stmt_detalle->get_result()->fetch_all(MYSQLI_ASSOC);
        
        return ['venta' => $venta, 'detalles' => $detalles];
    }
    return null;
}

// Consultar y mostrar detalles de la venta en PDF
if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['venta_id'])) {
    $venta_id = intval($_GET['venta_id']);
    $resultado = obtenerDetallesVenta($conn, $venta_id, $usuario_id);

    if ($resultado) {
        $venta = $resultado['venta'];
        $detalles = $resultado['detalles'];
        $usuario = obtenerDetallesUsuario($conn, $usuario_id);

        $pdf = new TCPDF();
        $pdf->AddPage();
        
      // Establecer la fuente para el título
$pdf->SetFont('Courier', 'B', 16); // Negrita, tamaño 16
$pdf->Cell(0, 10, 'Factura', 0, 1, 'C');

// Establecer la fuente para el contenido
$pdf->SetFont('Courier', '', 12); // Normal, tamaño 12
$pdf->Cell(0, 10, 'Usuario: ' . $usuario['usuario'], 0, 1, 'C');
$pdf->Cell(0, 10, 'NIT: ' . $usuario['nit'], 0, 1, 'C');
$pdf->Cell(0, 10, 'Teléfono: ' . ($usuario['telefono'] ?: 'No disponible'), 0, 1, 'C');
$pdf->Cell(0, 10, 'Direccion: ' . $usuario['direccion'], 0, 1, 'C');

$pdf->Cell(0, 10, 'Numero Factura: ' . $venta['idventa'], 0, 1, 'C');
$pdf->Cell(0, 10, 'Fecha: ' . $venta['fecha'], 0, 1, 'C');
$pdf->Cell(0, 10, 'Nombre Cliente: ' . ($venta['nombre_cliente'] ?: 'No disponible'), 0, 1, 'C');
$pdf->Cell(0, 10, 'Teléfono Cliente: ' . ($venta['telefono_cliente'] ?: 'No disponible'), 0, 1, 'C');

// Espacio antes de la tabla
$pdf->Ln(5);

// Anchos de las columnas
// Calcular el ancho total de la tabla
$anchoTotalTabla = 30 + 20 + 25 + 30; // Suma de los anchos de las celdas (Producto, Cantidad, Precio, Subtotal)

// Obtener el ancho de la página
$anchoPagina = $pdf->GetPageWidth();

// Calcular el margen izquierdo para centrar la tabla
$margenIzquierdo = ($anchoPagina - $anchoTotalTabla) / 2;

// Encabezado de la tabla
$pdf->SetFont('Courier', 'B', 10); // Tamaño de fuente más pequeño para el encabezado
$pdf->SetX($margenIzquierdo);
$pdf->Cell(30, 7, 'Producto', 1, 0, 'C');
$pdf->Cell(20, 7, 'Cantidad', 1, 0, 'C');
$pdf->Cell(25, 7, 'Precio', 1, 0, 'C');
$pdf->Cell(30, 7, 'Subtotal', 1, 0, 'C');
$pdf->Ln(); // Nueva línea después del encabezado

// Contenido de la tabla
$pdf->SetFont('Courier', '', 10); // Tamaño de fuente más pequeño para el contenido
foreach ($detalles as $detalle) {
    $pdf->SetX($margenIzquierdo); // Centrar cada fila
    $pdf->Cell(30, 6, $detalle['nombre'], 1, 0, 'C');
    $pdf->Cell(20, 6, $detalle['cantidad'], 1, 0, 'C');
    $pdf->Cell(25, 6, '$' . number_format($detalle['precio'], 0), 1, 0, 'R');
    $pdf->Cell(30, 6, '$' . number_format($detalle['subtotal'], 0), 1, 0, 'R');
    $pdf->Ln(); // Nueva línea para el siguiente producto
}



// Total de la factura
$pdf->SetFont('Courier', 'B', 12); // Negrita para el total
$pdf->Cell(0, 10, 'Total: $' . number_format($venta['total'], 0), 0, 1, 'C');
$pdf->Cell(0, 10, 'Efectivo: $' . number_format($venta['efectivo'], 0), 0, 1, 'C');
$pdf->Cell(0, 10, 'Cambio: $' . number_format($venta['cambio'], 0), 0, 1, 'C');
        $pdf->Output('factura_' . $venta_id . '.pdf', 'D');
        exit();
    } else {
        echo json_encode(['error' => 'Factura no encontrada o no autorizado para acceder a esta factura.']);
        exit();
    }
}

// Consultar ventas por ID o rango de fechas
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['buscar_ventas_id']) && !empty($_POST['id_venta'])) {
        $venta_id = intval($_POST['id_venta']);
        $resultado = obtenerDetallesVenta($conn, $venta_id, $usuario_id);

        if ($resultado) {
            $venta = $resultado['venta'];
            $venta['total'] = number_format($venta['total'], 0);
            echo json_encode(['success' => true, 'ventas' => [$venta]]);
        } else {
            echo json_encode(['error' => 'Venta no encontrada o no autorizado para acceder a esta venta.']);
        }
    } elseif (isset($_POST['sumatoria_rango_fecha']) && !empty($_POST['fecha_inicio']) && !empty($_POST['fecha_fin'])) {
        $fecha_inicio = $_POST['fecha_inicio'];
        $fecha_fin = $_POST['fecha_fin'];
    
        // Consulta para la sumatoria total de ventas
        $sql_total = "SELECT SUM(total) AS total_sum FROM ventas WHERE usuario_idusuario = ? AND DATE(fecha) BETWEEN ? AND ?";
        $stmt_total = $conn->prepare($sql_total);
        $stmt_total->bind_param("iss", $usuario_id, $fecha_inicio, $fecha_fin);
        $stmt_total->execute();
        $result_total = $stmt_total->get_result();
        $sumatoria = $result_total->fetch_assoc();
    
        // Consulta para calcular la ganancia total en el rango de fechas
        $sql_ganancia = "
            SELECT 
                SUM((dv.subtotal - (p.precioCompra * dv.cantidad))) AS ganancia_total
            FROM 
                ventas v
            JOIN 
                detalle_ventas dv ON v.idventa = dv.venta_idventa
            JOIN 
                producto p ON dv.producto_idproducto = p.idproducto
            WHERE 
                v.usuario_idusuario = ? AND DATE(v.fecha) BETWEEN ? AND ?";
        
        $stmt_ganancia = $conn->prepare($sql_ganancia);
        $stmt_ganancia->bind_param("iss", $usuario_id, $fecha_inicio, $fecha_fin);
        $stmt_ganancia->execute();
        $result_ganancia = $stmt_ganancia->get_result();
        $ganancia = $result_ganancia->fetch_assoc();
    
        // Verificación para asegurarse de que la consulta de ganancia esté funcionando correctamente
        if ($sumatoria && $ganancia) {
            $total_sum = number_format($sumatoria['total_sum'], 0);
            $ganancia_total = number_format($ganancia['ganancia_total'], 0);
    
            // Si la ganancia es NULL, es posible que no haya datos o que algo haya salido mal
            if ($ganancia['ganancia_total'] === null) {
                $ganancia_total = 0; // Establece en 0 si no hay resultados
            }
    
            echo json_encode([
                'success' => true, 
                'total_sum' => $total_sum, 
                'ganancia_total' => $ganancia_total
            ]);
        } else {
            // Mensajes de error si alguna consulta falla
            if (!$sumatoria) {
                echo json_encode(['error' => 'No se encontraron ventas para el rango de fechas especificado.']);
            } 
            if (!$ganancia) {
                echo json_encode(['error' => 'No se encontraron ganancias para el rango de fechas especificado.']);
            }
        }
    
    
    } elseif (isset($_POST['buscar_factura_id']) && !empty($_POST['id_venta'])) {
        $venta_id = intval($_POST['id_venta']);
        $resultado = obtenerDetallesVenta($conn, $venta_id, $usuario_id);

        if ($resultado) {
            $venta = $resultado['venta'];
            $detalles = $resultado['detalles'];

            $html = '<h1>Factura</h1>';
            $html .= '<p>Numero de factura: ' . $venta['idventa'] . '</p>';
            $html .= '<p>Nombre Cliente: ' . ($venta['nombre_cliente']  ?: 'No disponible') . '</p>';
            $html .= '<p>Teléfono Cliente: ' . ($venta['telefono_cliente'] ?: 'No disponible') . '</p>';
            $html .= '<p>Fecha: ' . $venta['fecha'] . '</p>';
         
            
            $html .= '<table border="1"><tr><th>Producto</th><th>Cantidad</th><th>Precio</th><th>Subtotal</th></tr>';

            foreach ($detalles as $detalle) {
                $html .= '<tr>';
                $html .= '<td>' . htmlspecialchars($detalle['nombre']) . '</td>';
                $html .= '<td>' . htmlspecialchars($detalle['cantidad']) . '</td>';
                $html .= '<td>$' . number_format($detalle['precio'], 0) . '</td>';
                $html .= '<td>$' . number_format($detalle['subtotal'], 0) . '</td>';
                $html .= '</tr>';
                
            }

       
            $html .= '</table>';
            $html .= '<p>Total: $' . number_format($venta['total'], 0) . '</p>';
            $html .= '<p>Efectivo: $' . number_format($venta['efectivo'], 0) . '</p>';
            $html .= '<p>Cambio: $' . number_format($venta['cambio'], 0) . '</p>';
            echo json_encode(['success' => true, 'html' => $html]);
        } else {
            echo json_encode(['error' => 'Factura no encontrada o no autorizado para acceder a esta factura.']);
        }
    } else {
        // Listar todas las ventas del usuario si no se especifica ningún filtro
        $sql = "SELECT * FROM ventas WHERE usuario_idusuario = ? ORDER BY idventa DESC";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $usuario_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $ventas = [];

        while ($venta = $result->fetch_assoc()) {
            $venta['total'] = number_format($venta['total'], 0);
            $ventas[] = $venta;
        }

        echo json_encode(['success' => true, 'ventas' => $ventas]);
    }
    exit();
}
?>
