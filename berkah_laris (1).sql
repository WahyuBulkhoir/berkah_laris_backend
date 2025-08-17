-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 17, 2025 at 11:16 AM
-- Server version: 8.0.30
-- PHP Version: 8.3.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `berkah_laris`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kategoris`
--

CREATE TABLE `kategoris` (
  `id_kategori` bigint UNSIGNED NOT NULL,
  `nama_kategori` varchar(255) NOT NULL,
  `tipe_produk` enum('Baru','Bekas') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kategoris`
--

INSERT INTO `kategoris` (`id_kategori`, `nama_kategori`, `tipe_produk`, `created_at`, `updated_at`) VALUES
(1, 'Bola Lampu', 'Baru', '2025-08-12 20:31:08', '2025-08-16 10:29:53'),
(2, 'Bola Lampu', 'Bekas', '2025-08-12 20:31:16', '2025-08-12 20:31:16'),
(3, 'Bola Lampu LED', 'Baru', '2025-08-12 20:31:27', '2025-08-12 20:31:27'),
(4, 'Bola Lampu LED', 'Bekas', '2025-08-12 20:31:36', '2025-08-12 20:31:36'),
(5, 'Bola Lampu AC/DC', 'Baru', '2025-08-12 20:31:48', '2025-08-12 20:31:48'),
(6, 'Bola Lampu AC/DC', 'Bekas', '2025-08-12 20:31:52', '2025-08-12 20:31:52'),
(7, 'Setrika', 'Baru', '2025-08-12 20:32:22', '2025-08-12 20:32:22'),
(8, 'Setrika', 'Bekas', '2025-08-12 20:32:30', '2025-08-12 20:32:30'),
(9, 'Kipas Angin', 'Baru', '2025-08-12 20:32:39', '2025-08-12 20:32:39'),
(10, 'Kipas Angin', 'Bekas', '2025-08-12 20:32:47', '2025-08-12 20:32:47'),
(11, 'Kipas Angin', 'Bekas', '2025-08-12 20:32:47', '2025-08-12 20:32:47'),
(12, 'Blender', 'Baru', '2025-08-12 20:32:58', '2025-08-12 20:32:58'),
(13, 'Blender', 'Bekas', '2025-08-12 20:33:05', '2025-08-12 20:33:05');

-- --------------------------------------------------------

--
-- Table structure for table `keranjangs`
--

CREATE TABLE `keranjangs` (
  `id_keranjang` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `produk_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `keranjangs`
--

INSERT INTO `keranjangs` (`id_keranjang`, `user_id`, `produk_id`, `quantity`, `created_at`, `updated_at`) VALUES
(236, 39, 10, 1, '2025-08-17 03:48:51', '2025-08-17 03:48:51');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_roles_table', 1),
(2, '0001_01_01_000001_create_users_table', 1),
(3, '0001_01_01_000002_create_cache_table', 1),
(4, '0001_01_01_000003_create_jobs_table', 1),
(5, '2025_07_09_172536_create_kategoris_table', 2),
(6, '2025_07_09_172537_create_produks_table', 2),
(7, '2025_07_10_115002_create_personal_access_tokens_table', 3),
(8, '2025_07_11_025715_add_sku_to_produk_table', 4),
(9, '2025_07_12_020757_create_servis_table', 5),
(10, '2025_07_15_034544_create_keranjangs_table', 6),
(11, '2025_07_15_090124_create_pemesanans_table', 7),
(12, '2025_07_15_144114_add_shipping_info_to_pemesanans_table', 8),
(13, '2025_07_17_060444_add_snap_token_to_pemesanans_table', 9),
(16, '2025_07_17_110833_add_biaya_and_payment_to_servis_table', 10),
(17, '2025_07_21_100711_add_modal_to_produks_table', 11),
(18, '2025_07_23_053644_add_payment_method_to_pemesanans_table', 12),
(21, '2025_07_24_144602_add_payment_method_to_servis_table', 13);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pemesanans`
--

CREATE TABLE `pemesanans` (
  `id_pemesanan` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `nama_penerima` varchar(255) DEFAULT NULL,
  `no_hp` varchar(255) DEFAULT NULL,
  `alamat` text,
  `tgl_pemesanan` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cat_opsional` text,
  `status_pesanan` enum('Pesanan Dibuat','Pesanan Diproses','Diserahkan Kekurir','Pesanan Dalam Perjalanan','Pesanan Sampai','Selesai') NOT NULL DEFAULT 'Pesanan Dibuat',
  `midtrans_order_id` varchar(255) DEFAULT NULL,
  `snap_token` varchar(255) DEFAULT NULL,
  `payment_status` enum('unpaid','paid','failed','expired') NOT NULL DEFAULT 'unpaid',
  `payment_method` varchar(255) DEFAULT NULL,
  `total` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pemesanans`
--

INSERT INTO `pemesanans` (`id_pemesanan`, `user_id`, `nama_penerima`, `no_hp`, `alamat`, `tgl_pemesanan`, `cat_opsional`, `status_pesanan`, `midtrans_order_id`, `snap_token`, `payment_status`, `payment_method`, `total`, `created_at`, `updated_at`) VALUES
(213, 38, 'Kevin Sanjaya', '082267773165', 'Medan, Sumatera Utara', '2025-07-17 04:40:05', 'Semoga barang sampai dengan selamat', 'Selesai', 'ORDER-213-68a15d2598618', 'e88168d3-84b4-4219-917b-dcc3e3d6a1be', 'paid', 'qris', 30000, '2025-08-16 21:40:05', '2025-08-16 22:40:52'),
(214, 38, 'Andi Pratama', '087648954312', 'Tebing tinggi, Sumatera Utara', '2025-07-05 04:42:05', 'Semoga amanah nih berkah laris', 'Selesai', 'ORDER-214-68a15d9d42fe6', '8b688460-a78a-49f7-a72c-ade15d3166b0', 'paid', 'qris', 120000, '2025-08-16 21:42:05', '2025-08-16 22:40:54'),
(215, 38, 'Wahyu Setiawan', '082267773165', 'Jalan Jenderal Sudirman No. 05, Kisaran, Kabupaten Asahan, Sumatera Utara, Kode Pos 21211', '2025-07-19 04:43:28', 'Semoga produknya sesuai', 'Selesai', 'ORDER-215-68a15df0e80aa', '33c04680-4235-4ede-9679-fb684b4de27c', 'paid', 'qris', 140000, '2025-08-16 21:43:28', '2025-08-16 22:40:55'),
(216, 38, 'Karunia Indah', '082267773165', 'Jalan Asahan km. 3, Nagori Pamatang Simalungun, Kecamatan Siantar, Kabupaten Simalungun, Provinsi Sumatera Utara, Kode Pos 21151', '2025-07-26 04:45:07', 'Bubblewrap don\'t forget min', 'Selesai', 'ORDER-216-68a15e53383e5', 'e9b33b2d-a6ca-47c1-9ad3-add011cabf1f', 'paid', 'bank_transfer', 220000, '2025-08-16 21:45:07', '2025-08-17 03:01:59'),
(217, 38, 'Gita Sekar', '082267773165', 'Jalan T. Amir Hamzah No.1, Stabat, Kabupaten Langkat, Sumatera Utara, dengan kode pos 20814', '2025-07-30 04:46:33', 'Let\'s go checkout lagi', 'Selesai', 'ORDER-217-68a15ea9648b2', '5a485db8-9712-4ac5-b28b-74e8aa8b1d40', 'paid', 'bank_transfer', 125000, '2025-08-16 21:46:33', '2025-08-17 03:01:58'),
(218, 39, 'Fiony Jayawardana', '083198617414', 'Jl. Jend. Ahmad Yani No.9, RT.001/RW.003, Sukaasih, Kec. Tangerang, Kota Tangerang, Banten 15111', '2025-08-17 05:30:09', 'Semoga barangnya sesuai', 'Selesai', 'ORDER-218-68a168e1a9a4d', 'af6cda6e-a25b-42fd-8b0e-041049aff052', 'paid', 'qris', 170000, '2025-08-16 22:30:09', '2025-08-17 03:01:56'),
(219, 39, 'Freya Alveria', '083198617414', 'Komplek Perkantoran Pemerintah Daerah Kabupaten Tangerang, Jl. H. Soleh Achmad, Tigaraksa, Tangerang, Banten 15720.', '2025-08-23 05:32:22', 'Semangat min jualannya', 'Selesai', 'ORDER-219-68a169668f7c9', 'ed7245ea-bb15-4223-9e3a-146b8b0b1250', 'paid', 'akulaku', 30000, '2025-08-16 22:32:22', '2025-08-16 22:40:44'),
(220, 39, 'Ivan Purnama', '083198617414', 'Jl. Raya Soreang No.17, Pamekaran, Kec. Soreang, Kabupaten Bandung, Jawa Barat 40912.', '2025-08-16 05:34:19', 'Semoga cepat sampainya min', 'Selesai', 'ORDER-220-68a169db1d5e7', 'e756a201-5afb-4d2e-92d7-c1ddef50f3e4', 'paid', 'qris', 120000, '2025-08-16 22:34:19', '2025-08-16 22:40:42'),
(221, 39, 'Damanik Toretto', '081265483716', 'Kantor Bupati Deli Serdang, Jalan Negara No. 10, Lubuk Pakam, Kabupaten Deli Serdang, Sumatera Utara, 20511.', '2025-08-09 05:36:00', 'Kalau bagus nanti beli disini lagi deh', 'Selesai', 'ORDER-221-68a16a40204b2', '05e395e5-a494-4ed2-9517-3b5a0e0fffd4', 'paid', 'cstore', 230000, '2025-08-16 22:36:00', '2025-08-16 22:40:39'),
(223, 39, 'Gilang Dirga', '083198617414', 'Jl. Panji No. 158, Kepanjen, Malan, Jawa Tengah', '2025-08-02 05:57:26', 'Semoga sukses usahanya min', 'Selesai', 'ORDER-223-68a16f4647feb', '63335fc6-9ade-47b0-8978-b2e2275da35b', 'paid', 'bank_transfer', 29000, '2025-08-16 22:57:26', '2025-08-17 03:01:54'),
(224, 39, 'Freya Alveria', '083198617414', 'Komplek Perkantoran Pemerintah Daerah Kabupaten Tangerang, Jl. H. Soleh Achmad, Tigaraksa, Tangerang, Banten 15720.', '2025-08-17 10:49:10', 'tidak ada', 'Selesai', 'ORDER-224-68a1b3a6e57cb', 'aadc5bcf-cca6-4266-88ef-eb03dcf9bc7b', 'paid', 'bank_transfer', 30000, '2025-08-17 03:49:10', '2025-08-17 03:58:50');

-- --------------------------------------------------------

--
-- Table structure for table `pemesanan_details`
--

CREATE TABLE `pemesanan_details` (
  `id_detail` bigint UNSIGNED NOT NULL,
  `pemesanan_id` bigint UNSIGNED NOT NULL,
  `produk_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL,
  `harga_satuan` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pemesanan_details`
--

INSERT INTO `pemesanan_details` (`id_detail`, `pemesanan_id`, `produk_id`, `quantity`, `harga_satuan`, `created_at`, `updated_at`) VALUES
(224, 213, 9, 1, 30000, '2025-08-16 21:40:05', '2025-08-16 21:40:05'),
(225, 214, 12, 1, 120000, '2025-08-16 21:42:05', '2025-08-16 21:42:05'),
(226, 215, 13, 1, 140000, '2025-08-16 21:43:28', '2025-08-16 21:43:28'),
(227, 216, 20, 1, 220000, '2025-08-16 21:45:07', '2025-08-16 21:45:07'),
(228, 217, 18, 1, 125000, '2025-08-16 21:46:33', '2025-08-16 21:46:33'),
(229, 218, 6, 1, 170000, '2025-08-16 22:30:09', '2025-08-16 22:30:09'),
(230, 219, 9, 1, 30000, '2025-08-16 22:32:22', '2025-08-16 22:32:22'),
(231, 220, 14, 1, 120000, '2025-08-16 22:34:19', '2025-08-16 22:34:19'),
(232, 221, 17, 1, 230000, '2025-08-16 22:36:00', '2025-08-16 22:36:00'),
(234, 223, 5, 1, 29000, '2025-08-16 22:57:26', '2025-08-16 22:57:26'),
(235, 224, 8, 2, 15000, '2025-08-17 03:49:10', '2025-08-17 03:49:10');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(355, 'App\\Models\\User', 30, 'pelanggan-token', 'b103b41491042eb7ab0e708136b024b1bbc2e656777fd91edcba6c85027e2f7e', '[\"*\"]', '2025-08-13 07:52:16', NULL, '2025-08-13 07:52:04', '2025-08-13 07:52:16'),
(360, 'App\\Models\\User', 37, 'teknisi-token', '4f53556b2c5b476376c81b2e853bbc12360db8450d8ad08065531cd377cf7027', '[\"*\"]', '2025-08-13 18:32:34', NULL, '2025-08-13 18:32:21', '2025-08-13 18:32:34');

-- --------------------------------------------------------

--
-- Table structure for table `produks`
--

CREATE TABLE `produks` (
  `id_produk` bigint UNSIGNED NOT NULL,
  `id_kategori` bigint UNSIGNED NOT NULL,
  `nama_produk` varchar(255) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `harga` int NOT NULL,
  `modal` decimal(15,2) NOT NULL DEFAULT '0.00',
  `stok` int NOT NULL,
  `gambar_produk` varchar(255) DEFAULT NULL,
  `deskripsi` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `produks`
--

INSERT INTO `produks` (`id_produk`, `id_kategori`, `nama_produk`, `sku`, `harga`, `modal`, `stok`, `gambar_produk`, `deskripsi`, `created_at`, `updated_at`) VALUES
(2, 2, 'Bola Supra 18w Hanoch', 'PRD-002', 23000, 17800.00, 4, 'produk/1755081413_hanoch-18w.jpeg', 'Bola lampu LED Supra 18W dari Hanoch adalah lampu LED kapsul dengan daya 18 watt, fitting E27, dan dirancang untuk memberikan pencahayaan yang terang dengan umur pakai yang panjang. Lampu ini memiliki beberapa spesifikasi teknis yang perlu diperhatikan.', '2025-08-12 20:36:53', '2025-08-12 20:39:13'),
(3, 1, 'Bola Supra 12w Hanoch', 'PRD-003', 17000, 13400.00, 8, 'produk/1755081455_hanoch-12w.jpg', 'Lampu Hannochs 12W adalah lampu LED yang tersedia dalam berbagai model, termasuk lampu emergency dan downlight. Lampu ini dikenal hemat energi, memiliki umur pakai yang panjang, dan tersedia dalam berbagai pilihan warna cahaya. Beberapa model juga dilengkapi fitur darurat yang akan menyala otomatis saat listrik padam.', '2025-08-12 20:37:35', '2025-08-12 20:37:35'),
(4, 2, 'Bola Supra 22w Hanoch', 'PRD-004', 26000, 20800.00, 5, 'produk/1755081518_hanoch-22w.jpeg', 'Bola lampu LED Hannochs 22 Watt adalah lampu LED hemat energi yang diproduksi oleh Hannochs, sebuah merek elektronik Indonesia. Lampu ini dikenal karena kualitasnya yang baik dan masa pakainya yang panjang, mencapai 15.000 jam.', '2025-08-12 20:38:38', '2025-08-12 21:22:09'),
(5, 3, 'Bola Led Vario 22w Hanoch', 'PRD-005', 29000, 22500.00, 3, 'produk/1755081680_hanoch-led-22w.jpeg', 'Lampu LED Hannochs Vario 22 watt adalah bohlam LED yang hemat energi dengan daya 22 watt dan dirancang untuk penggunaan di dalam ruangan. Lampu ini menghasilkan cahaya putih (Cool Daylight) dengan voltase 220-240V dan memiliki fitting E27. Umur lampu ini diklaim mencapai 10.000 jam dengan sudut pencahayaan 180 derajat.', '2025-08-12 20:41:20', '2025-08-16 22:57:54'),
(6, 3, 'Bola Led Vario 70 w Hanoch', 'PRD-006', 170000, 133750.00, 3, 'produk/1755081767_hanoch-led-70w.jpeg', 'Lampu LED Vario 70 watt dari Hannochs adalah lampu LED hemat energi dengan cahaya putih terang (Cool Daylight 6500 K). Lampu ini memiliki daya 70 watt, menghasilkan 8000 lumens, dan umur lampu hingga 10.000 jam.', '2025-08-12 20:42:47', '2025-08-16 22:30:41'),
(7, 4, 'Bola Led Omi Hamura 10w', 'PRD-007', 5000, 3450.00, 5, 'produk/1755081851_hamura-led-10w.jpg', 'Lampu LED Omi Hamura 10W adalah lampu LED dengan daya 10 watt yang menghasilkan cahaya putih (cool daylight) dengan suhu warna 6500K. Lampu ini memiliki umur pakai hingga 8.000 jam dan menggunakan fitting E27', '2025-08-12 20:44:11', '2025-08-12 20:44:11'),
(8, 4, 'Bola Led Omi Hamura 20w', 'PRD-008', 15000, 6300.00, 1, 'produk/1755081981_hamura-led-30w.jpeg', 'Bola lampu LED Omi Hamura 30W adalah lampu LED dengan daya 30 watt yang menghasilkan cahaya putih terang (cool daylight) dengan suhu warna 6500K. Lampu ini memiliki umur lampu hingga 8.000 jam dan menggunakan fitting E27.', '2025-08-12 20:46:21', '2025-08-17 03:49:25'),
(9, 6, 'Bola AC/DC Orenchi 15W', 'PRD-009', 30000, 25300.00, 2, 'produk/1755082163_orenchi-acdc-15w.jpeg', 'Lampu bola AC/DC Orenchi 15W adalah lampu LED darurat yang dapat menyala baik saat ada listrik maupun saat padam. Lampu ini memiliki beberapa keunggulan, seperti hemat energi hingga 90%, umur lampu yang panjang, dan ramah lingkungan. Selain itu, lampu ini juga sudah memenuhi standar SNI.', '2025-08-12 20:49:23', '2025-08-16 22:32:44'),
(10, 5, 'Bola AC/DC Orenchi 20W', 'PRD-010', 35000, 25300.00, 4, 'produk/1755082229_orenchi-acdc-20w.jpeg', 'Lampu LED AC/DC Orenchi 20W adalah lampu darurat yang dapat menyala baik saat ada listrik maupun saat mati lampu. Lampu ini hemat energi, memiliki umur panjang, dan sudah memenuhi standar SNI.', '2025-08-12 20:50:29', '2025-08-16 10:40:15'),
(11, 7, 'Setrika Miyako El2000', 'PRD-011', 120000, 93000.00, 5, 'produk/1755083366_miyako-el2000.jpeg', 'Setrika Miyako EI-2000 B adalah setrika listrik dengan tapak besi berlapis krom yang dilapisi chrome. Setrika ini memiliki desain Classic Style yang memungkinkan jangkauan yang fleksibel ke saku dan celah kancing. Dilengkapi dengan pengatur suhu yang dapat disesuaikan untuk berbagai jenis bahan pakaian, serta pegangan ergonomis untuk kenyamanan penggunaan.', '2025-08-12 21:09:26', '2025-08-12 21:09:26'),
(12, 8, 'Setrika Miyako El1000', 'PRD-012', 120000, 93000.00, 3, 'produk/1755083413_miyako-el1000.jpeg', 'Setrika Miyako EL1000 adalah setrika listrik yang dirancang untuk membuat proses menyetrika pakaian menjadi lebih mudah dan nyaman. Setrika ini memiliki alas setrika (sole plate) dengan lapisan anti lengket (non-stick) yang terbuat dari Teflon, memungkinkan setrika meluncur dengan lancar di atas kain tanpa menempel.', '2025-08-12 21:10:13', '2025-08-16 21:42:18'),
(13, 7, 'Setrika Maspion HA125', 'PRD-13', 140000, 111000.00, 3, 'produk/1755083490_maspion.jpeg', 'Setrika Maspion HA125 adalah setrika listrik yang memiliki daya 350 Watt dan tegangan 220 Volt. Setrika ini dilengkapi dengan tapak setrika anti lengket (non-stick soleplate) untuk memudahkan proses menyetrika dan mencegah pakaian menempel. Selain itu, setrika ini juga memiliki fitur pengaturan suhu yang dapat disesuaikan dengan jenis kain.', '2025-08-12 21:11:30', '2025-08-16 21:43:43'),
(14, 9, 'Deskfan 12’ Kingston', 'PRD-14', 120000, 101500.00, 3, 'produk/1755083566_kingston.jpg', 'Kipas angin meja Kingston 12 inci adalah kipas angin meja yang memiliki ukuran 12 inci. Kipas ini dilengkapi dengan tiga pengaturan kecepatan dan motor yang tidak berisik. Selain itu, kipas ini memiliki desain yang stylish dan tersedia dalam berbagai warna. Kipas ini juga dilengkapi dengan grill yang tahan gores dan motor yang berkualitas tinggi.', '2025-08-12 21:12:46', '2025-08-16 22:34:49'),
(15, 9, 'Deskfan 12’ Miyako', 'PRD-015', 186000, 170000.00, 5, 'produk/1755083659_miyako-kipasaingin.jpeg', 'Kipas angin meja Miyako 12 inci, seperti KAD-1227 B GB, adalah kipas angin 2-in-1 yang bisa berfungsi sebagai kipas meja (desk fan) dan kipas dinding (wall fan). Kipas ini memiliki baling-baling yang kokoh dan motor yang bertenaga, namun tetap menghasilkan suara yang halus saat beroperasi. KAD-1227 B GB juga dilengkapi dengan fitur keamanan Thermofuse yang memutus arus listrik jika terjadi overheat pada motor.', '2025-08-12 21:14:19', '2025-08-12 21:14:19'),
(16, 10, 'Deskfan 8’ hyperlite', 'PRD-16', 80000, 69500.00, 3, 'produk/1755083744_hyperlite-kipasangin.jpeg', 'Kipas angin meja Hyperlite 8 inci, yang juga dikenal sebagai Deskfan 8\' Hyperlite, adalah kipas angin mini yang dirancang untuk ditempatkan di meja atau permukaan datar lainnya. Kipas ini memiliki beberapa pilihan model, termasuk yang bertema karakter animasi seperti Doraemon, Hello Kitty, Iron Man, Mickey Mouse, dan Minion.', '2025-08-12 21:15:44', '2025-08-12 21:15:44'),
(17, 9, 'Standfan miyako 1606pl', 'PRD-017', 230000, 187000.00, 6, 'produk/1755083825_miyako-standfan.webp', 'Kipas angin berdiri (Stand Fan) Miyako KAS-1606X PL adalah kipas angin berukuran 16 inci dengan desain elegan berwarna hitam. Kipas ini memiliki tiga pilihan kecepatan yang dapat disesuaikan dan dilengkapi dengan kaki berbentuk silang yang kokoh dan stabil.', '2025-08-12 21:17:05', '2025-08-16 22:36:29'),
(18, 11, 'Standfan Carslan', 'PRD-18', 125000, 111000.00, 0, 'produk/1755083886_carslan.jpg', 'Stand fan Carslan adalah kipas angin berdiri yang tersedia dalam berbagai ukuran, seperti 16 inci dan 18 inci, dan dilengkapi dengan berbagai fitur untuk kenyamanan pengguna. Kipas ini memiliki beberapa pilihan kecepatan angin, motor yang kuat dan tidak berisik, serta desain yang kokoh dan stabil.', '2025-08-12 21:18:06', '2025-08-16 21:46:33'),
(19, 12, 'Blender Utu 2 tabung', 'PRD-019', 110000, 100000.00, 1, 'produk/1755083952_blender-utu.jpeg', 'Blender UTU 2 tabung, khususnya tipe UT-T26N, adalah alat dapur serbaguna yang dirancang untuk menghaluskan berbagai jenis bahan makanan. Blender ini dilengkapi dua tabung dengan kapasitas berbeda (biasanya 1 liter dan 0.5 liter), serta dua tombol kecepatan dan fungsi pulse untuk pengaturan yang lebih presisi. Material tabung umumnya kaca, yang dikenal mudah dibersihkan dan tidak meninggalkan noda.', '2025-08-12 21:19:12', '2025-08-13 07:54:19'),
(20, 13, 'Blender Miyako', 'PRD-020', 220000, 178000.00, 0, 'produk/1755405358_miyako-blender.jpeg', 'Blender Miyako adalah alat dapur serbaguna yang dirancang untuk membantu pengolahan makanan, terutama dalam hal menghaluskan, mencampur, dan menggiling bahan-bahan. Blender ini umumnya tersedia dalam berbagai model dengan fitur dan kapasitas yang berbeda-beda, namun secara umum, blender Miyako dikenal karena kemudahan penggunaan, daya tahan, dan harga yang terjangkau.', '2025-08-12 21:20:09', '2025-08-16 22:38:12'),
(53, 1, 'Bola Supra 6w Hanoch', 'PRD-001', 12000, 9350.00, 5, 'produk/1755405184_hanoch-6w.jpeg', 'Bola lampu LED Hannochs Supra 6W adalah lampu LED kapsul dengan daya 6 watt yang menghasilkan cahaya putih (Cool Daylight 6500 K). Lampu ini memiliki spesifikasi: voltase 220-240V, lumen 520, diameter 50mm, tinggi 95mm, dan fitting E27. Umur lampu diklaim mencapai 10.000 jam atau sekitar 416 hari.', '2025-08-16 21:33:04', '2025-08-16 21:33:04');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id_role` bigint UNSIGNED NOT NULL,
  `nama_role` enum('admin','pelanggan','teknisi') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id_role`, `nama_role`, `created_at`, `updated_at`) VALUES
(1, 'admin', '2025-07-03 13:33:17', '2025-07-04 13:33:17'),
(2, 'pelanggan', '2025-07-03 13:33:28', '2025-07-04 13:33:28'),
(3, 'teknisi', '2025-07-18 10:23:03', '2025-07-18 10:23:03');

-- --------------------------------------------------------

--
-- Table structure for table `servis`
--

CREATE TABLE `servis` (
  `id_servis` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `tipe_barang` varchar(255) NOT NULL,
  `kerusakan` text NOT NULL,
  `ket_tambahan` text,
  `tanggal_servis` date NOT NULL,
  `status_servis` enum('Diproses','Diterima','Dalam Perbaikan','Selesai') NOT NULL DEFAULT 'Diproses',
  `total_biaya` bigint UNSIGNED DEFAULT NULL,
  `payment_status` enum('unpaid','paid') NOT NULL DEFAULT 'unpaid',
  `payment_method` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `servis`
--

INSERT INTO `servis` (`id_servis`, `user_id`, `tipe_barang`, `kerusakan`, `ket_tambahan`, `tanggal_servis`, `status_servis`, `total_biaya`, `payment_status`, `payment_method`, `created_at`, `updated_at`) VALUES
(53, 39, 'Kipas Miyako', 'Kerusakan dibagian kapasitor dan bagian boshing nya', 'Perlu penggantian kapasitor dan boshing nya', '2025-07-06', 'Selesai', 50000, 'paid', 'bank_transfer', '2025-08-16 08:33:03', '2025-08-16 08:36:08'),
(54, 39, 'Blender', 'Perputaran blender tidak stabil', 'Perlu penggantian karet blender', '2025-07-13', 'Selesai', 15000, 'paid', 'bank_transfer', '2025-08-16 08:39:36', '2025-08-16 09:01:51'),
(55, 39, 'Speaker Kecil', 'Baterai sudah mulai berjamur', 'Perlu penggantian baterai speaker', '2025-07-20', 'Selesai', 30000, 'paid', 'bank_transfer', '2025-08-16 08:43:37', '2025-08-16 09:02:32'),
(56, 39, 'Magicom', 'Kotoran menumpuk mengakibatkan panas tidak maksimal', 'Perlu pembersihan mendalam', '2025-08-30', 'Selesai', 40000, 'paid', 'qris', '2025-08-16 08:45:44', '2025-08-16 09:03:03'),
(57, 39, 'Tv Tabung', 'Kerusakan dibagian komponen yang berada didalam tv', 'Perlu penggantian beberapa komponen yang rusak', '2025-08-02', 'Selesai', 150000, 'unpaid', NULL, '2025-08-16 08:48:58', '2025-08-16 08:49:47'),
(58, 38, 'Tv LED', 'Kerusakan dibagian lampu yang berada di dalam komponen tv', 'Perlu penggantian lampu yang berada dalam komponen tv', '2025-08-06', 'Selesai', 300000, 'unpaid', NULL, '2025-08-16 08:51:28', '2025-08-16 08:51:50'),
(59, 38, 'Kipas Kosmos', 'Kerusakan dibagian kapasitor dan bagian boshing nya', 'Perlu penggantian kapasitor 1.5 dan boshing pada kipas nya', '2025-08-10', 'Selesai', 100000, 'paid', 'akulaku', '2025-08-16 08:53:06', '2025-08-16 08:58:31'),
(60, 38, 'Blender Philip', 'Kerusakan dibagian pisau blendernya', 'Perlu penggantian pisau blendernya yang tumpul', '2025-08-19', 'Selesai', 25000, 'paid', 'qris', '2025-08-16 08:54:52', '2025-08-16 08:58:03'),
(61, 38, 'Blender Miyako', 'Kerusakan dibagian pisau dan kabel penghubung blender', 'Perlu penggantian pisau yang tumpul dan kabel yang sudah luka', '2025-07-26', 'Selesai', 40000, 'paid', 'qris', '2025-08-16 08:56:36', '2025-08-16 08:57:30');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text,
  `payload` longtext NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('Ct8T0YaZDns203YUMRTRwsolJMjjXAlQSMTZJ2O7', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVDBuQUI5M1c2bFV1NTNrUXdQeXFaTzNGNGdYT1ZwRDd5RTNDc0xrbiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTcyOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvZW1haWwvdmVyaWZ5LzQwLzNhMDg0NzEyODI0ZWU0MTBlYjM2MGE0NDI1ZTk3NDk4NjcyMzliODY/ZXhwaXJlcz0xNzU1NDMyNDU1JnNpZ25hdHVyZT02NjU0MTI5OWE4OGFjY2ZkY2RjYWZiOWJhOGMwMGI1Y2U1NjYwZjY3MDJjYThiMWVmMmJhMGZmZDM4MGY4MDVjIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755428900),
('T52WFS20JnAOi8NkJGa9G9lXROtnR8J2eJRV9RNn', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSlo3b21jSXZxendDTEJUY1A4NDExMFBuWWxvbmtxTGpqRkpndkNzOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTcyOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvZW1haWwvdmVyaWZ5LzM4LzIwZWNiNjIxM2JmNjBhOGE0MzQxMTE2NmIyMTM5MWM4MWUzYWY3MGE/ZXhwaXJlcz0xNzU1MTAwNDE4JnNpZ25hdHVyZT02M2JkOGExOWQ2ODI0ODA3MTQxMzNlYTY0NjQyYjQxZDIzMjE2YWUzM2MwYmI5YWRiNTk3ZGE3Y2IyNTUyMDYyIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755096835),
('TKEG9zClqYjbq9j6FkWnPuS4WNiMIgM2tIBBDJWc', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZDZXZnozOFlVRXMzeFB6SkdQTzBUTUs2RXNqekVaUmI5MjY4VEtVRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTcyOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvZW1haWwvdmVyaWZ5LzM5Lzc5MDY3MjA2YjE2YTc0ODhjOTRjY2RjYjc2OTc5MDk5MWQyN2RjY2U/ZXhwaXJlcz0xNzU1MzYxNzk1JnNpZ25hdHVyZT01MjQzMzZmNmU2Mzc5M2YwNjhlYmYzYTI0M2I3MGQxMjcwZDk4NTcxMWQ5NGYzNDcyZWQ3YzJjZDU4NTAzMzNiIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1755358236);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `no_hp` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `role_id`, `username`, `name`, `email`, `no_hp`, `alamat`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 1, 'admin', 'Admin', 'sicombomail@gmail.com', '08123456789', 'Admin Address', '2025-07-04 10:25:19', '$2y$12$RCsi2VqsDuvqxWCCY5LEx.DGuV7UaUsCafeZtt86jOwrZLdXmfBoq', 'P1Z90EuzhpsLVZdnOrjaU6c9aFL9ZBd5TBiru9GDZ8pORtvh3sndnpbUoGEo', '2025-07-04 06:35:42', '2025-07-10 04:41:26'),
(37, 3, 'teknisi', 'Teknisi', 'teknisi@example.com', '080987654321', 'Teknisi Address', '2025-07-18 03:50:20', '$2y$12$NzdnyxxWRep6WELtRoHwPeMX2JrHDtIW9pm8TR.adyPf75JCmY0yq', NULL, '2025-07-18 03:31:58', '2025-07-18 03:50:20'),
(38, 2, 'damanik', 'Wahyu Setiawan', 'bulwahyu8@gmail.com', '082267773165', 'Padang', '2025-08-13 07:53:55', '$2y$12$qNBOZ/yLcwO2S9taJSW.1e.7oLRsbUyYOHylEzxGDjD1wCj7SrEji', 'S0Rn6hSiyLBip6UFnai3LWTdtxMX1Iag6so25klosvKpTitQv47xZEo8bzuO', '2025-08-13 07:53:34', '2025-08-16 11:21:19'),
(39, 2, 'wahyu', 'Damanik Toretto', 'wahyu76558@gmail.com', '083198617414', 'Bandung', '2025-08-16 08:30:36', '$2y$12$LucXCmIuaDStsNpPJScXCuhOkHbBtt4JZGRwKVNusKnwHnBVDgwCC', 'JffLT2WJ2Wd2jSDCMptmVY1hNLOmONhHPUPcEMEtu6nZmrA4qBsWQBqptwk1', '2025-08-16 08:29:53', '2025-08-16 11:45:17'),
(40, 2, 'bulkhoir', 'Pelanggan Tiga', 'wahyubulkhoir8@gmail.com', '086785187362', 'Padang Panjang', '2025-08-17 04:08:20', '$2y$12$YcLZYbqHSJnd3ZZobsJI5u60zuYBtoD.7EB6iZWFRdOT7LVceptgW', 'GA8qvkEdZV0mk9cYCXdPqvIe4PmCr02oGHKO2IajcwATXoPpbPVR5Wl9vMiu', '2025-08-17 04:07:33', '2025-08-17 04:10:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kategoris`
--
ALTER TABLE `kategoris`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `keranjangs`
--
ALTER TABLE `keranjangs`
  ADD PRIMARY KEY (`id_keranjang`),
  ADD UNIQUE KEY `keranjangs_user_id_produk_id_unique` (`user_id`,`produk_id`),
  ADD KEY `keranjangs_produk_id_foreign` (`produk_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `pemesanans`
--
ALTER TABLE `pemesanans`
  ADD PRIMARY KEY (`id_pemesanan`),
  ADD KEY `pemesanans_user_id_foreign` (`user_id`);

--
-- Indexes for table `pemesanan_details`
--
ALTER TABLE `pemesanan_details`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `pemesanan_details_pemesanan_id_foreign` (`pemesanan_id`),
  ADD KEY `pemesanan_details_produk_id_foreign` (`produk_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `produks`
--
ALTER TABLE `produks`
  ADD PRIMARY KEY (`id_produk`),
  ADD UNIQUE KEY `produks_sku_unique` (`sku`),
  ADD KEY `produks_id_kategori_foreign` (`id_kategori`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_role`);

--
-- Indexes for table `servis`
--
ALTER TABLE `servis`
  ADD PRIMARY KEY (`id_servis`),
  ADD KEY `servis_user_id_foreign` (`user_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kategoris`
--
ALTER TABLE `kategoris`
  MODIFY `id_kategori` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `keranjangs`
--
ALTER TABLE `keranjangs`
  MODIFY `id_keranjang` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=237;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `pemesanans`
--
ALTER TABLE `pemesanans`
  MODIFY `id_pemesanan` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=225;

--
-- AUTO_INCREMENT for table `pemesanan_details`
--
ALTER TABLE `pemesanan_details`
  MODIFY `id_detail` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=236;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=398;

--
-- AUTO_INCREMENT for table `produks`
--
ALTER TABLE `produks`
  MODIFY `id_produk` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id_role` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `servis`
--
ALTER TABLE `servis`
  MODIFY `id_servis` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `keranjangs`
--
ALTER TABLE `keranjangs`
  ADD CONSTRAINT `keranjangs_produk_id_foreign` FOREIGN KEY (`produk_id`) REFERENCES `produks` (`id_produk`) ON DELETE CASCADE,
  ADD CONSTRAINT `keranjangs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `pemesanans`
--
ALTER TABLE `pemesanans`
  ADD CONSTRAINT `pemesanans_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `pemesanan_details`
--
ALTER TABLE `pemesanan_details`
  ADD CONSTRAINT `pemesanan_details_pemesanan_id_foreign` FOREIGN KEY (`pemesanan_id`) REFERENCES `pemesanans` (`id_pemesanan`) ON DELETE CASCADE,
  ADD CONSTRAINT `pemesanan_details_produk_id_foreign` FOREIGN KEY (`produk_id`) REFERENCES `produks` (`id_produk`) ON DELETE CASCADE;

--
-- Constraints for table `produks`
--
ALTER TABLE `produks`
  ADD CONSTRAINT `produks_id_kategori_foreign` FOREIGN KEY (`id_kategori`) REFERENCES `kategoris` (`id_kategori`);

--
-- Constraints for table `servis`
--
ALTER TABLE `servis`
  ADD CONSTRAINT `servis_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id_role`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
