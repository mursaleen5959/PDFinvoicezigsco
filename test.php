<?php
////////////////
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

function insert_cell($pdf,$Y,$X,$text)
{
    $pdf -> SetY($Y);
    $pdf -> SetX($X);
    $pdf->Cell(0,5,$text,0,0,'L');
    
}


function wh_log($log_msg)
{
    $log_filename = "log";
    if (!file_exists($log_filename)) 
    {
        // create directory/folder uploads.
        mkdir($log_filename, 777, true);
    }
    $log_file_data = $log_filename.'/log_' . date('d-M-Y') . '.log';
    // if you don't add `FILE_APPEND`, the file will be erased each time you add a log
    file_put_contents($log_file_data, $log_msg . "\n", FILE_APPEND);
} 
//wh_log("this is my log message");

// Necessary File includes
require_once('db.php');
require_once('conf.php');
require_once('fpdf/fpdf.php');
require_once('fpdf/extension.php');

// ===============================

ob_start();
// PDF Object
//$pdf = new PDF();
$pdf = new PDF('P','mm',array(241.3,279.4)); 
//$pdf = new PDF('P','in',array(9.5,11)); 

$pdf->AddPage();
//$pdf->AddPage('P','in',array(9,11));
//$pdf->AddPage('P','mm',array(100,150));
$pdf->Image('source_template/template.jpg',20,0,190,0);
$pdf->SetFont('Arial','',10);

$invoice = 87;
$sql = "SELECT * from penjualan WHERE id_faktur='{$invoice}'";
$result = $pdo->query($sql);

while ($row = $result->fetch())
{
    insert_cell($pdf,90,90,"THIS IS THE ID FOR TESTING PURPOSE : ".$row['id']);
}

$filename="file.pdf";
header('Content-type: application/pdf');
ob_clean();
$pdf->Output('I',$filename);