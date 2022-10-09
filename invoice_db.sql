-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 09, 2022 at 05:05 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `invoice_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `faktur_jual`
--

CREATE TABLE `faktur_jual` (
  `id` int(11) NOT NULL,
  `kode` varchar(50) NOT NULL,
  `id_pelanggan` int(11) NOT NULL,
  `total_faktur` float NOT NULL,
  `total_qty` int(11) NOT NULL,
  `total_bayar` float DEFAULT NULL,
  `jatuh_tempo` date NOT NULL,
  `pajak` float DEFAULT NULL,
  `diskon` float DEFAULT NULL,
  `dibuat_oleh` int(11) NOT NULL,
  `keterangan` text DEFAULT NULL,
  `no_po` varchar(50) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'terbit',
  `dibuat_pada` datetime NOT NULL DEFAULT current_timestamp(),
  `diedit_pada` datetime DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `faktur_jual`
--

INSERT INTO `faktur_jual` (`id`, `kode`, `id_pelanggan`, `total_faktur`, `total_qty`, `total_bayar`, `jatuh_tempo`, `pajak`, `diskon`, `dibuat_oleh`, `keterangan`, `no_po`, `status`, `dibuat_pada`, `diedit_pada`) VALUES
(87, 'FJ/20220929/87', 2, 35000, 2, 0, '2022-10-29', 0, 0, 1, 'This is descripton', 'PO123', 'terbit', '2022-09-29 15:50:43', '2022-10-08 11:02:35');

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id` int(11) NOT NULL,
  `nama_pelanggan` varchar(150) NOT NULL,
  `term` int(11) NOT NULL,
  `alamat` varchar(256) NOT NULL,
  `kota` varchar(30) NOT NULL,
  `provinsi` varchar(30) NOT NULL,
  `no_telpon` varchar(15) NOT NULL,
  `aktif` int(1) NOT NULL,
  `dibuat_pada` date NOT NULL DEFAULT current_timestamp(),
  `diedit_pada` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id`, `nama_pelanggan`, `term`, `alamat`, `kota`, `provinsi`, `no_telpon`, `aktif`, `dibuat_pada`, `diedit_pada`) VALUES
(1, 'BORMA DAGO', 30, 'Jl Ir H Juanda No 365', 'Bandung', 'Jawa Barat', '012101245', 1, '2022-08-26', '2022-09-07 05:50:05'),
(2, 'BORMA RANCABELUT', 30, 'Jl Cimahi Utara No 102 RT 01 RW 01 Kutawaringin', 'Cimahi', 'Jawa Barat', '12345', 1, '2022-08-26', '2022-08-29 08:10:33');

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--

CREATE TABLE `penjualan` (
  `id` int(11) NOT NULL,
  `id_faktur` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `total` float NOT NULL,
  `dibuat_oleh` int(11) DEFAULT NULL,
  `dibuat_pada` date NOT NULL DEFAULT current_timestamp(),
  `diedit_pada` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `penjualan`
--

INSERT INTO `penjualan` (`id`, `id_faktur`, `id_produk`, `qty`, `total`, `dibuat_oleh`, `dibuat_pada`, `diedit_pada`) VALUES
(186, 87, 1, 1, 35000, 1, '2022-09-29', '0000-00-00 00:00:00'),
(188, 87, 2, 1, 125000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(189, 87, 3, 1, 85000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(190, 87, 4, 1, 65000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(191, 87, 7, 1, 65000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(192, 87, 8, 1, 85000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(193, 87, 9, 1, 75000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(194, 87, 1, 1, 35000, 1, '2022-09-29', '0000-00-00 00:00:00'),
(195, 87, 2, 1, 125000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(196, 87, 3, 1, 85000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(197, 87, 4, 1, 65000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(198, 87, 7, 1, 65000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(199, 87, 8, 1, 85000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(200, 87, 9, 1, 75000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(201, 87, 1, 1, 35000, 1, '2022-09-29', '0000-00-00 00:00:00'),
(202, 87, 2, 1, 125000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(203, 87, 3, 1, 85000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(204, 87, 4, 1, 65000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(205, 87, 7, 1, 65000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(206, 87, 8, 1, 85000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(207, 87, 9, 1, 75000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(208, 87, 1, 1, 35000, 1, '2022-09-29', '0000-00-00 00:00:00'),
(209, 87, 2, 1, 125000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(210, 87, 3, 1, 85000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(211, 87, 4, 1, 65000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(212, 87, 7, 1, 65000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(213, 87, 8, 1, 85000, 1, '2022-10-03', '0000-00-00 00:00:00'),
(214, 87, 9, 1, 75000, 1, '2022-10-03', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id` int(11) NOT NULL,
  `nama_produk` varchar(256) NOT NULL,
  `kode` varchar(50) NOT NULL,
  `unit` varchar(5) NOT NULL,
  `id_suplier` int(11) NOT NULL,
  `kategori_id` int(11) NOT NULL,
  `aktif` int(1) NOT NULL,
  `dibuat_pada` date NOT NULL DEFAULT current_timestamp(),
  `diedit_pada` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id`, `nama_produk`, `kode`, `unit`, `id_suplier`, `kategori_id`, `aktif`, `dibuat_pada`, `diedit_pada`) VALUES
(1, 'FOREV MOUSE FV-55 USB', 'ZS10001', 'PCS', 1, 1, 1, '2022-08-23', '2022-08-30 16:23:49'),
(2, 'FOREV KEYBOARD FV-Q305S GAMING', 'ZS10002', 'PCS', 1, 1, 1, '2022-08-23', '2022-08-30 16:23:54'),
(3, 'MIXIE KEYBOARD R512 WIRELESS', 'ZS10003', 'PCS', 1, 1, 1, '2022-08-23', '2022-08-30 16:23:59'),
(4, 'ZIGSCO MOUSE A01 WIRELESS', 'ZS10004', 'PCS', 1, 1, 1, '2022-08-30', '2022-08-30 16:37:08'),
(5, 'ZIGSCO MOUSE A02 WIRELESS', 'ZS10005', 'PCS', 2, 2, 1, '2022-08-30', '2022-08-30 16:43:02'),
(6, 'ZIGSCO MOUSE A03 WIRELESS', 'ZS10006', 'PCS', 1, 2, 1, '2022-08-30', '2022-08-30 16:45:19'),
(7, 'BOSSTON KEYBOARD D3200 STD USB', 'ZS10007', 'PCS', 2, 2, 1, '2022-08-30', '2022-08-30 16:57:49'),
(8, 'BOSSTON KEYBOARD   MOUSE D500 STD USB', 'ZS10008', 'PCS', 1, 2, 1, '2022-08-30', '2022-08-30 16:59:49'),
(9, 'SOYTO HEADSET GAMING G15', 'ZS10009', 'PCS', 2, 1, 1, '2022-09-01', '2022-09-01 01:13:03');

-- --------------------------------------------------------

--
-- Table structure for table `stok`
--

CREATE TABLE `stok` (
  `id` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `stok` int(12) NOT NULL,
  `peringatan_qty` int(12) NOT NULL,
  `harga_jual` float NOT NULL,
  `hpp` float NOT NULL,
  `dibuat_pada` date NOT NULL DEFAULT current_timestamp(),
  `diedit_pada` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stok`
--

INSERT INTO `stok` (`id`, `id_produk`, `stok`, `peringatan_qty`, `harga_jual`, `hpp`, `dibuat_pada`, `diedit_pada`) VALUES
(1, 1, 113, 20, 35000, 15000, '2022-08-26', '2022-09-29 08:50:43'),
(2, 2, 118, 20, 125000, 80000, '2022-08-26', '2022-10-03 15:10:45'),
(3, 3, 126, 20, 85000, 40000, '2022-08-26', '2022-10-03 15:10:51'),
(4, 4, 47, 50, 65000, 35000, '2022-08-30', '2022-10-03 15:10:53'),
(5, 5, 0, 50, 75000, 45000, '2022-08-30', '0000-00-00 00:00:00'),
(6, 6, 0, 50, 145000, 85000, '2022-08-30', '0000-00-00 00:00:00'),
(7, 7, 29, 50, 65000, 45000, '2022-08-30', '2022-10-03 15:10:54'),
(8, 8, 40, 50, 85000, 65000, '2022-08-30', '2022-10-03 15:10:56'),
(9, 9, 5, 20, 75000, 41000, '2022-09-01', '2022-10-03 15:10:57');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `faktur_jual`
--
ALTER TABLE `faktur_jual`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode` (`kode`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stok`
--
ALTER TABLE `stok`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `faktur_jual`
--
ALTER TABLE `faktur_jual`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `penjualan`
--
ALTER TABLE `penjualan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=215;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `stok`
--
ALTER TABLE `stok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
