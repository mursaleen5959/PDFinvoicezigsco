<?php
////////////////
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

function insert_cell($pdf,$Y,$X,$text,$alignment = 'L')
{
    $pdf -> SetY($Y);
    $pdf -> SetX($X);
    $pdf->Cell(0,5,$text,0,0,$alignment);
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

// DATA Variables go HERE --------
$invoiceNumber  = 87;  // No. Faktur
$invoiceDate    = '';  // Tgl. Faktur

$noPO           = ''; // NO. PO
$requirement    = '';  // Syarat
$dueDate        = '';  // Tgl. Jatuh Tempo
$sales          = '';  // Sales

$customers      = '';  // Pelanggan
$currencyIDR    = '';  // Mata Uang IDR
$invoiceTo      = '';  // Tagihan Ke
$sendTo         = '';  // Kirim Ke

$no             = '';  // No
$itemCode       = '';  // Kode Barang
$itemDesc       = '';  // Deskripsi Barang
$qty            = '';  // Qty
$unit           = '';  // Satuan
$unitPrice      = '';  // Harga Satuan
$disc           = '';  // Disc %
$jumlah         = '';  // Jumlah

$countPrice     = '';  // Terbilang
$description    = '';  // Deskripsi

$subTotal       = '';  // sub total
$discount       = '';  // Diskon
$ppn            = '';  // PPN 10%
$grandTotal     = '';  // Grand Total

$totalPages     = '';  // Total Halaman

// ===============================


// DATA Variables Fillins UPs

$sql = "SELECT * from faktur_jual WHERE id='{$invoiceNumber}'";
$result = $pdo->query($sql);
while ($row = $result->fetch())
{
    $Kode           = $row['kode'];         // No. Faktur
    $dueDate        = $row['jatuh_tempo'];  // Tgl. Jatuh Tempo
    $grandTotal     = $row['total_faktur'];  // Grand total
    $invoiceDate    = $row['dibuat_pada'];  // Tgl. Faktur
    $invoiceDate    = date("Y-m-d", strtotime($invoiceDate));  // Tgl. Faktur
    $noPO           = $row['no_po'];;  // NO. PO
    $deskripsi      = $row['keterangan'];  // deskripsi
    $id_pelanggan   = $row['id_pelanggan'];  //  id_pelanggan 
    $diskon         = $row['diskon'];  //  Diskon
    $pajak          = $row['pajak'];  //  pajak
}

$sql = "SELECT * from pelanggan WHERE id='{$id_pelanggan}'";
$result = $pdo->query($sql);
while ($row = $result->fetch())
{
    $customer  = $row['nama_pelanggan'];  // Pelanggan
    $invoiceTo = $row['alamat']." ,".$row['kota']." ,".$row['provinsi'];  // Tagihan Ke
    $sendTo    = $row['alamat']." ,".$row['kota']." ,".$row['provinsi'];  // Kirim Ke
    $syarat     = $row['term'];  // syarat
}


$sales          = '';  // Sales
$currencyIDR    = 'IDR';  // Mata Uang IDR
$discount       = '';  // Diskon
$ppn            = '';  // PPN 10%
//$grandTotal     = '';  // Grand Total

// ===============================

ob_start();
// PDF Object
//$pdf = new PDF();
$pdf = new PDF('P','mm',array(241.3,279.4));
$pdf->AliasNbPages();
$pdf->AddPage();
// $pdf->Image('source_template/template.jpg',0,0,210,0);
$pdf->Image('source_template/template.jpg',0,0,235,0);
$pdf->SetFont('Arial','',10);

//////====

$f = new NumberFormatter("ind", NumberFormatter::SPELLOUT);
//echo $f->format(32560)." Rupiah";
$currency_formatter = new NumberFormatter('en_GB',  NumberFormatter::CURRENCY);
$currency_formatter->setSymbol(NumberFormatter::CURRENCY_SYMBOL, '');
$currency_formatter->setAttribute(NumberFormatter::FRACTION_DIGITS, 0);
/////=====
// $pdf->SetTextColor(255,255,255);

insert_cell($pdf,21.5,150,$Kode);
insert_cell($pdf,21.5,182,$invoiceDate);
insert_cell($pdf,47,180,$dueDate);
insert_cell($pdf,31,180,$noPO);
insert_cell($pdf,39,180,"NET ".$syarat);

insert_cell($pdf,30,60,$customer);
insert_cell($pdf,36,60,$currencyIDR);


$pdf->SetFont('Arial','',8);
$pdf -> SetY(50);
$pdf -> SetX(35);
$pdf->MultiCell(50,4,$invoiceTo,0,'C');

$pdf -> SetY(50);
$pdf -> SetX(85);
$pdf->MultiCell(50,4,$sendTo,0,'C');


$sql = "SELECT * from penjualan WHERE id_faktur='{$invoiceNumber}'";
$result = $pdo->query($sql);

//$pdf->SetFont('Arial','',9);
$x_axis = 33;
$y_axis = 73;
$count=0;
$subTotal   = 0;
//$grandTotal = 0;
while ($row = $result->fetch())
{
    $count+=1;
    $qty        = $row['qty'];
    $jumlah  = $row['total'];

    // Getting Product Data
    $product_id = $row['id_produk'];
    $product_sql = "SELECT * from produk WHERE id='{$product_id}'";
    $product_result = $pdo->query($product_sql);
    while ($product_row = $product_result->fetch())
    {
        $no             = $product_row['id'];  // No
        $itemCode       = $product_row['kode'];  // Kode Barang
        $itemDesc       = $product_row['nama_produk'];  // Deskripsi Barang
        //$qty            = $row[''];  // Qty
        $unit           = $product_row['unit'];  // Satuan
        //$disc           = $product_row[''];  // Disc %
        //$jumlah         = $product_row[''];  // Jumlah
    }
    $stok_sql = "SELECT * from stok WHERE id_produk='{$product_id}'";
    $stok_result = $pdo->query($stok_sql);
    while ($stok_row = $stok_result->fetch())
    {
        $unitPrice      = $stok_row['harga_jual'];  // Harga Satuan
    }
    // Filling Up DATA

    //insert_cell($pdf,$y_axis,$x_axis,$no);
    insert_cell($pdf,$y_axis,$x_axis,$count);
    insert_cell($pdf,$y_axis,$x_axis+7,$itemCode);
    //====================
    //insert_cell($pdf,$y_axis,$x_axis+32,$itemDesc);
    //$pdf -> SetY(55);
    $pdf -> SetX($x_axis+29.5);
    $pdf->MultiCell(65,4,$itemDesc,0,'L');
    $last_axis = $pdf->GetY();

    //insert_cell($pdf,$y_axis,$x_axis+190,$last_axis);
    //====================

    insert_cell($pdf,$y_axis,$x_axis+95,$qty);
    insert_cell($pdf,$y_axis,$x_axis+98,$unit);
    
    
    //insert_cell($pdf,$y_axis,$x_axis+115,$unitPrice);
    $pdf -> SetY($y_axis);
    $pdf -> SetX($x_axis+115);
    $pdf->Cell(21,5,$currency_formatter->formatCurrency($unitPrice, 'IDR'),0,0,'R');

    //insert_cell($pdf,60,40,$disc);
    //insert_cell($pdf,$y_axis,$x_axis+153,$jumlah);
    $pdf -> SetY($y_axis);
    $pdf -> SetX($x_axis+153);
    $pdf->Cell(21,5,$currency_formatter->formatCurrency($jumlah, 'IDR'),0,0,'R');
    
    $subTotal+=$jumlah;
    //$grandTotal+=$jumlah;


    if($last_axis>=175)
    {
        // Sub Total & Grand Total
        $pdf -> SetY(206);
        $pdf -> SetX($x_axis+30);
        $pdf->MultiCell(60,4,strtoupper($f->format($subTotal)." Rupiah"),0,'C');
        $pdf -> SetY(221);
        $pdf -> SetX($x_axis+10);
        $pdf->MultiCell(80,4,$deskripsi,0,'C');

        insert_cell($pdf,206,$x_axis+153,$currency_formatter->formatCurrency($subTotal, 'IDR'), PHP_EOL);
        //insert_cell($pdf,225,$x_axis+153,$currency_formatter->formatCurrency($grandTotal, 'IDR'), PHP_EOL);
        $subTotal = 0;
        //$grandTotal = 0;
        $pdf->AddPage();
        $pdf->Image('source_template/template.jpg',0,0,235,0);
        $pdf->SetFont('Arial','',10);
        insert_cell($pdf,21.5,150,$Kode);

        $pdf->SetFont('Arial','',8);
        insert_cell($pdf,21.5,180,$invoiceDate);
        $pdf->SetFont('Arial','',10);
        insert_cell($pdf,47,180,$dueDate);
        insert_cell($pdf,31,180,$noPO);
        insert_cell($pdf,39,180,"NET ".$syarat);

        insert_cell($pdf,30,60,$customer);
        insert_cell($pdf,36,60,$currencyIDR);


        $pdf->SetFont('Arial','',8);
        $pdf -> SetY(50);
        $pdf -> SetX(35);
        $pdf->MultiCell(50,4,$invoiceTo,0,'C');

        $pdf -> SetY(50);
        $pdf -> SetX(85);
        $pdf->MultiCell(50,4,$sendTo,0,'C');

        $x_axis = 33;
        $y_axis = 73;

    }
    else{
        $y_axis = $last_axis + 1;
    }
    //    $x_axis += 0;
}
insert_cell($pdf,206,$x_axis+153,$currency_formatter->formatCurrency($subTotal, 'IDR'), PHP_EOL);
insert_cell($pdf,225,$x_axis+153,$currency_formatter->formatCurrency($grandTotal, 'IDR'), PHP_EOL);
$pdf -> SetY(206);
$pdf -> SetX($x_axis+30);
$pdf->MultiCell(60,4,strtoupper($f->format($grandTotal)." Rupiah"),0,'C');
$pdf -> SetY(221);
$pdf -> SetX($x_axis+10);
$pdf->MultiCell(80,4,$deskripsi,0,'C');

insert_cell($pdf,211,$x_axis+153,$diskon);
insert_cell($pdf,216,$x_axis+153,$pajak);

$filename="file.pdf";
header('Content-type: application/pdf');
ob_clean();
$pdf->Output('I',$filename);