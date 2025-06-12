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

// Función para obtener detalles de la cotizacion
function obtenerDetallesCotizaciones($conn, $cotizacion_id, $usuario_id) {
    $sql = "SELECT * FROM cotizacion WHERE idcotizacion = ?  AND usuario_idusuario = ? ORDER BY idcotizacion DESC";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ii", $cotizacion_id, $usuario_id);
    $stmt->execute();
    $cotizacion = $stmt->get_result()->fetch_assoc();

    if ($cotizacion) {
        $sql_detalle = "SELECT d.*, p.nombre, p.idproducto FROM detalle_cotizacion d 
        JOIN producto p ON d.producto_idproducto = p.idproducto 
        WHERE d.cotizacion_idcotizacion = ?";

        $stmt_detalle = $conn->prepare($sql_detalle);
        $stmt_detalle->bind_param("i", $cotizacion_id);
        $stmt_detalle->execute();
        $detalles = $stmt_detalle->get_result()->fetch_all(MYSQLI_ASSOC);
        
        return ['cotizacion' => $cotizacion, 'detalles' => $detalles];
    }
    return null;
}

// Consultar y mostrar detalles de la cotizacion en PDF
if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['cotizacion_id'])) {
    $cotizacion_id = intval($_GET['cotizacion_id']);
    $resultado = obtenerDetallesCotizaciones($conn, $cotizacion_id, $usuario_id);

    if ($resultado) {
        $cotizacion = $resultado['cotizacion'];
        $detalles = $resultado['detalles'];
        $usuario = obtenerDetallesUsuario($conn, $usuario_id);
        $pdf = new TCPDF();
        $pdf->SetAutoPageBreak(true, 10);
        $pdf->AddPage();
        
        $pdf = new TCPDF();
        $pdf->SetMargins(10, 10, 10);
        $pdf->AddPage();
        
        // ** LOGO CENTRADO **
        $logo = 'logo.png';
        if (file_exists($logo)) {
            $logoWidth = 40;
            $pageWidth = $pdf->getPageWidth();
            $x = ($pageWidth - $logoWidth) / 2;
            $pdf->Image($logo, $x, 10, $logoWidth);
            $pdf->SetY(55); // Ajusta el espacio después del logo
        }
        
        // ** ENCABEZADO CENTRADO **
        $pdf->SetFont('Courier', 'B', 14);
        $pdf->Cell(0, 10, 'COTIZACIÓN', 0, 1, 'C');
        $pdf->SetFont('Courier', '', 10);
        $pdf->Cell(0, 6, 'No. ' . $cotizacion['idcotizacion'], 0, 1, 'C');
        $pdf->Cell(0, 6, 'Fecha: ' . date('d/m/Y H:i', strtotime($cotizacion['fecha'])), 0, 1, 'C');
        $pdf->Ln(3);
        
        // ** DATOS DEL VENDEDOR CENTRADOS **
        $pdf->SetFont('Courier', 'B', 10);
        $pdf->Cell(0, 6, 'DATOS DEL VENDEDOR', 0, 1, 'C');
        $pdf->SetFont('Courier', '', 10);
        $pdf->Cell(0, 6, 'Usuario: ' . $usuario['usuario'], 0, 1, 'C');
        $pdf->Cell(0, 6, 'NIT: ' . $usuario['nit'], 0, 1, 'C');
        $pdf->Cell(0, 6, 'Teléfono: ' . ($usuario['telefono'] ?: 'No disponible'), 0, 1, 'C');
        $pdf->Cell(0, 6, 'Dirección: ' . $usuario['direccion'], 0, 1, 'C');
        $pdf->Ln(3);
        
        // ** DATOS DEL CLIENTE CENTRADOS **
        $pdf->SetFont('Courier', 'B', 10);
        $pdf->Cell(0, 6, 'DATOS DEL CLIENTE', 0, 1, 'C');
        $pdf->SetFont('Courier', '', 10);
        $pdf->Cell(0, 6, 'Nombre: ' . ($cotizacion['nombre_cliente'] ?: 'No disponible'), 0, 1, 'C');
        $pdf->Cell(0, 6, 'Teléfono: ' . ($cotizacion['telefono_cliente'] ?: 'No disponible'), 0, 1, 'C');
        $pdf->Ln(5);
        
        // ** TABLA CENTRADA **
        $pdf->SetFont('Courier', 'B', 10);
        $tableWidth = 15 + 50 + 20 + 25 + 30; // Suma de los anchos
        $pageWidth = $pdf->getPageWidth();
        $startX = ($pageWidth - $tableWidth) / 2;
        $pdf->SetX($startX);
        
        $pdf->Cell(15, 7, 'ID', 1, 0, 'C');
        $pdf->Cell(50, 7, 'Producto', 1, 0, 'C');
        $pdf->Cell(20, 7, 'Cantidad', 1, 0, 'C');
        $pdf->Cell(25, 7, 'Precio', 1, 0, 'C');
        $pdf->Cell(30, 7, 'Subtotal', 1, 0, 'C');
        $pdf->Ln();
        
        $pdf->SetFont('Courier', '', 10);
        foreach ($detalles as $detalle) {
            $pdf->SetX($startX);
            $pdf->Cell(15, 6, $detalle['idproducto'], 1, 0, 'C');
            $pdf->Cell(50, 6, $detalle['nombre'], 1, 0, 'L');
            $pdf->Cell(20, 6, $detalle['cantidad'], 1, 0, 'C');
            $pdf->Cell(25, 6, '$' . number_format($detalle['precio'], 2), 1, 0, 'R');
            $pdf->Cell(30, 6, '$' . number_format($detalle['subtotal'], 2), 1, 0, 'R');
            $pdf->Ln();
        }
        
        // ** TOTAL CENTRADO **
        $pdf->Ln(3);
        $pdf->SetFont('Courier', 'B', 12);
        $pdf->SetX($startX);
        $pdf->Cell(110, 7, 'TOTAL:', 0, 0, 'R');
        $pdf->Cell(30, 7, '$' . number_format($cotizacion['total'], 2), 1, 1, 'R');
        $pdf->Ln(5);
        
        // ** NOTA FINAL CENTRADA **
        $pdf->SetFont('Courier', 'I', 10);
        $pdf->Cell(0, 6, 'Esta es una cotización sin valor legal.', 0, 1, 'C');
        $pdf->Cell(0, 6, 'Gracias por su interés.', 0, 1, 'C');
        
        // ** SALIDA DEL ARCHIVO **
        $pdf->Output('cotizacion_' . $cotizacion['idcotizacion'] . '.pdf', 'D');
        exit();
        
        

         }
}

// Consultar cotizacion por ID o rango de fechas
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['buscar_cotizacion_id']) && !empty($_POST['id_cotizacion'])) {
        $cotizacion_id = intval($_POST['id_cotizacion']);
        $resultado = obtenerDetallesCotizaciones($conn, $cotizacion_id, $usuario_id);

        if ($resultado) {
            $cotizacion = $resultado['cotizacion'];
            $cotizacion['total'] = number_format($cotizacion['total'], 0);
            echo json_encode(['success' => true, 'cotizacion' => [$cotizacion]]);
        } else {
            echo json_encode(['error' => 'cotizacion no encontrada o no autorizado para acceder a esta cotizacion.']);
        }
    
    } elseif (isset($_POST['buscar_factura_id']) && !empty($_POST['id_cotizacion'])) {
        $cotizacion_id = intval($_POST['id_cotizacion']);
        $resultado = obtenerDetallesCotizaciones($conn, $cotizacion_id, $usuario_id);

        if ($resultado) {
            $cotizacion = $resultado['cotizacion'];
            $detalles = $resultado['detalles'];

            $html = '<h1>cotizacion</h1>';
            $html .= '<p>Numero de cotizacion: ' . $cotizacion['idcotizacion'] . '</p>';
            $html .= '<p>Nombre Cliente: ' . ($cotizacion['nombre_cliente']  ?: 'No disponible') . '</p>';
            $html .= '<p>Teléfono Cliente: ' . ($cotizacion['telefono_cliente'] ?: 'No disponible') . '</p>';
            $html .= '<p>Fecha: ' . $cotizacion['fecha'] . '</p>';
         
            $html .= '<table style="width:100%; border-collapse: collapse;">';
$html .= '<tr>
    <th style="border: 1px solid #000; padding: 0px;">ID Producto</th>
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


       
            $html .= '</table>';
            $html .= '<p>Total: $' . number_format($cotizacion['total'], 0) . '</p>';
          
            echo json_encode(['success' => true, 'html' => $html]);
        } else {
            echo json_encode(['error' => 'Factura no encontrada o no autorizado para acceder a esta factura.']);
        }
    } else {
        // Listar todas las cotizacion del usuario si no se especifica ningún filtro
        $sql = "SELECT * FROM cotizacion WHERE usuario_idusuario = ? ORDER BY idcotizacion DESC";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $usuario_id);
        $stmt->execute();
        $result = $stmt->get_result();

        $cotizaciones = []; // Inicializar un array para almacenar las cotizaciones
        while ($row = $result->fetch_assoc()) {
            $row['total'] = number_format($row['total'], 0);
            $cotizaciones[] = $row; // Agregar cada cotización al array
        }
        
        echo json_encode(['success' => true, 'cotizacion' => $cotizaciones]);
    }
    exit();
}
?>

