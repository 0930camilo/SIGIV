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
        $sql_detalle = "SELECT d.*, p.nombre, p.idproducto FROM detalle_ventas d 
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
        $pdf->SetMargins(10, 10, 10);
        $pdf->AddPage();
        
        // ** LOGO **
        $logo = 'logo.png'; // Ruta del logo de la empresa
        if (file_exists($logo)) {
            $pdf->Image($logo, 10, 10, 30); // Ajusta tamaño y posición
        }
        $pdf->Ln(5);
        
        // ** ENCABEZADO **
        $pdf->SetFont('Courier', 'B', 14);
        $pdf->Cell(0, 10, 'FACTURA ELECTRONICA', 0, 1, 'C');
        $pdf->SetFont('Courier', '', 10);
        $pdf->Cell(0, 6, 'No. ' . $venta['idventa'], 0, 1, 'C');
        $pdf->Cell(0, 6, 'Fecha: ' . date('d/m/Y H:i', strtotime($venta['fecha'])), 0, 1, 'C');
        $pdf->Ln(3);
        
        // ** DATOS DE LA EMPRESA **
        $pdf->SetFont('Courier', 'B', 10);
        $pdf->Cell(0, 6, 'DATOS DEL VENDEDOR', 0, 1, 'C');
        $pdf->SetFont('Courier', '', 10);
        $pdf->Cell(0, 6, 'Usuario: ' . $usuario['usuario'], 0, 1, 'C');
        $pdf->Cell(0, 6, 'NIT: ' . $usuario['nit'], 0, 1, 'C');
        $pdf->Cell(0, 6, 'Teléfono: ' . ($usuario['telefono'] ?: 'No disponible'), 0, 1, 'C');
        $pdf->Cell(0, 6, 'Direccion: ' . $usuario['direccion'], 0, 1, 'C');
        $pdf->Ln(3);
        
        // ** DATOS DEL CLIENTE **
        $pdf->SetFont('Courier', 'B', 10);
        $pdf->Cell(0, 6, 'DATOS DEL CLIENTE', 0, 1, 'C');
        $pdf->SetFont('Courier', '', 10);
        $pdf->Cell(0, 6, 'Nombre: ' . ($venta['nombre_cliente'] ?: 'No disponible'), 0, 1, 'C');
        $pdf->Cell(0, 6, 'Teléfono: ' . ($venta['telefono_cliente'] ?: 'No disponible'), 0, 1, 'C');
        $pdf->Ln(5);
      // ** TABLA DE PRODUCTOS **
$pdf->SetFont('Courier', 'B', 10);

$ancho_total = 15 + 50 + 20 + 25 + 30; // 140
$margen_izquierdo = ($pdf->GetPageWidth() - $ancho_total) / 2;

// Encabezado centrado
$pdf->SetX($margen_izquierdo);
$pdf->Cell(15, 7, 'ID', 1, 0, 'C');
$pdf->Cell(50, 7, 'Producto', 1, 0, 'C');
$pdf->Cell(20, 7, 'Cantidad', 1, 0, 'C');
$pdf->Cell(25, 7, 'Precio', 1, 0, 'C');
$pdf->Cell(30, 7, 'Subtotal', 1, 0, 'C');
$pdf->Ln();

// Cuerpo de la tabla centrado
$pdf->SetFont('Courier', '', 10);
foreach ($detalles as $detalle) {
    $pdf->SetX($margen_izquierdo);
    $pdf->Cell(15, 6, $detalle['idproducto'], 1, 0, 'C');
    $pdf->Cell(50, 6, $detalle['nombre'], 1, 0, 'L');
    $pdf->Cell(20, 6, $detalle['cantidad'], 1, 0, 'C');
    $pdf->Cell(25, 6, '$' . number_format($detalle['precio'], 2), 1, 0, 'R');
    $pdf->Cell(30, 6, '$' . number_format($detalle['subtotal'], 2), 1, 0, 'R');
    $pdf->Ln();
}


        
// ** RESUMEN TOTAL CENTRADO **
$pdf->Ln(3);
$pdf->SetFont('Courier', 'B', 12);

// Calculamos el ancho total del resumen (igual que tabla de productos)
$ancho_total = 110 + 30; // 140
$startX = ($pdf->GetPageWidth() - $ancho_total) / 2;

// TOTAL
$pdf->SetX($startX);
$pdf->Cell(110, 7, 'TOTAL:', 0, 0, 'R');
$pdf->Cell(30, 7, '$' . number_format($venta['total'], 2), 1, 1, 'R');

// EFECTIVO
$pdf->SetX($startX);
$pdf->Cell(110, 7, 'Efectivo:', 0, 0, 'R');
$pdf->Cell(30, 7, '$' . number_format($venta['efectivo'], 2), 1, 1, 'R');

// CAMBIO
$pdf->SetX($startX);
$pdf->Cell(110, 7, 'Cambio:', 0, 0, 'R');
$pdf->Cell(30, 7, '$' . number_format($venta['cambio'], 2), 1, 1, 'R');

// MENSAJE FINAL
$pdf->Ln(5);
$pdf->SetFont('Courier', 'I', 10);
$pdf->Cell(0, 6, 'Gracias por su compra', 0, 1, 'C');

// SALIDA DEL PDF
$pdf->Output('factura_' . $venta['idventa'] . '.pdf', 'D');

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
         
            
            $html .= '<table border="1"><tr>
             <th style="border: 1px solid #000; padding: 0px;">id producto</th>
            <th style="border: 1px solid #000; padding: 0px;">Producto</th>
            <th style="border: 1px solid #000; padding: 0px;">Cantidad</th>
            <th style="border: 1px solid #000; padding: 0px;">Precio</th>
            <th style="border: 1px solid #000; padding: 0px;">Subtotal</th>
            </tr>';

            foreach ($detalles as $detalle) {
                $html .= '<tr>';
                $html .= '<td style="border: 1px solid #000; padding: 0px;">' . htmlspecialchars($detalle['idproducto']) . '</td>';
                $html .= '<td style="border: 1px solid #000; padding: 0px;">' . htmlspecialchars($detalle['nombre']) . '</td>';
                $html .= '<td style="border: 1px solid #000; padding: 0px;">' . htmlspecialchars($detalle['cantidad']) . '</td>';
                $html .= '<td style="border: 1px solid #000; padding: 0px;">$' . number_format($detalle['precio'], 0) . '</td>';
                $html .= '<td style="border: 1px solid #000; padding: 0px;">$' . number_format($detalle['subtotal'], 0) . '</td>';
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
