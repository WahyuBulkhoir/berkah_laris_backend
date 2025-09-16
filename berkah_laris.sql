-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 16 Sep 2025 pada 13.24
-- Versi server: 8.0.30
-- Versi PHP: 8.3.22

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
-- Struktur dari tabel `barang_masuk`
--

CREATE TABLE `barang_masuk` (
  `id_barang_masuk` bigint UNSIGNED NOT NULL,
  `produk_id` bigint UNSIGNED NOT NULL,
  `jumlah` int NOT NULL DEFAULT '0',
  `tanggal` date NOT NULL,
  `keterangan` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `barang_masuk`
--

INSERT INTO `barang_masuk` (`id_barang_masuk`, `produk_id`, `jumlah`, `tanggal`, `keterangan`, `created_at`, `updated_at`) VALUES
(1, 19, 3, '2025-09-04', 'tidak ada', '2025-09-04 04:47:50', '2025-09-04 04:47:50'),
(2, 20, 3, '2025-09-02', 'tidak ada', '2025-09-04 07:02:07', '2025-09-04 07:02:07'),
(3, 8, 3, '2025-09-07', 'tidak ada', '2025-09-06 22:29:22', '2025-09-06 22:29:22');

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
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
-- Struktur dari tabel `jenis_kerusakan`
--

CREATE TABLE `jenis_kerusakan` (
  `id_kerusakan` bigint UNSIGNED NOT NULL,
  `nama_kerusakan` varchar(255) NOT NULL,
  `estimasi_biaya` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `jenis_kerusakan`
--

INSERT INTO `jenis_kerusakan` (`id_kerusakan`, `nama_kerusakan`, `estimasi_biaya`, `created_at`, `updated_at`) VALUES
(11, 'TV Ic Vertical Kena', 150000, '2025-09-06 06:50:53', '2025-09-06 06:54:52'),
(12, 'TV Power Suplay Rusak', 150000, '2025-09-06 06:51:18', '2025-09-06 06:54:59'),
(13, 'TV Warna Tidak Beraturan/ Ic Micom Kena', 150000, '2025-09-06 06:52:06', '2025-09-06 06:55:09'),
(14, 'TV Flayback Kena', 200000, '2025-09-06 06:52:20', '2025-09-06 06:55:22'),
(15, 'TV Layar Gelap/Ganti Tabung', 250000, '2025-09-06 06:52:53', '2025-09-06 06:55:32'),
(16, 'Kipas Dengung Tidak Berputar/Bushingnya Kena', 50000, '2025-09-06 06:54:04', '2025-09-06 06:54:04'),
(17, 'Kipas Mati Total Terkena Thermofuse', 50000, '2025-09-06 06:54:28', '2025-09-06 06:55:40'),
(18, 'Kipas Putaran Lambat/Capasitor Kena', 50000, '2025-09-06 06:56:06', '2025-09-06 06:56:06'),
(19, 'Kipas Spul Terbakar', 150000, '2025-09-06 06:56:32', '2025-09-06 06:56:32'),
(20, 'Magicom Terkena Thermofuse', 50000, '2025-09-06 08:03:24', '2025-09-06 08:05:24'),
(21, 'Magicom Terkena Thermostat', 50000, '2025-09-06 08:04:03', '2025-09-06 08:05:32'),
(22, 'Tumpul pada Pisau Blender', 50000, '2025-09-06 08:04:53', '2025-09-06 08:04:53'),
(23, 'Pisau Blender Patah', 50000, '2025-09-06 08:06:55', '2025-09-06 08:06:55'),
(24, 'Kerusakan pada Komponen Driver Speaker', 50000, '2025-09-06 08:08:53', '2025-09-06 08:08:53');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jobs`
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
-- Struktur dari tabel `job_batches`
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
-- Struktur dari tabel `kategoris`
--

CREATE TABLE `kategoris` (
  `id_kategori` bigint UNSIGNED NOT NULL,
  `nama_kategori` varchar(255) NOT NULL,
  `tipe_produk` enum('Baru','Bekas') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `kategoris`
--

INSERT INTO `kategoris` (`id_kategori`, `nama_kategori`, `tipe_produk`, `created_at`, `updated_at`) VALUES
(1, 'Bola Lampu', 'Baru', '2025-08-12 20:31:08', '2025-08-16 10:29:53'),
(3, 'Bola Lampu LED', 'Baru', '2025-08-12 20:31:27', '2025-08-12 20:31:27'),
(5, 'Bola Lampu AC/DC', 'Baru', '2025-08-12 20:31:48', '2025-08-12 20:31:48'),
(7, 'Setrika', 'Baru', '2025-08-12 20:32:22', '2025-08-12 20:32:22'),
(9, 'Kipas Angin', 'Baru', '2025-08-12 20:32:39', '2025-08-12 20:32:39'),
(10, 'Kipas Angin', 'Bekas', '2025-08-12 20:32:47', '2025-08-12 20:32:47'),
(12, 'Blender', 'Baru', '2025-08-12 20:32:58', '2025-08-12 20:32:58'),
(13, 'Blender', 'Bekas', '2025-08-12 20:33:05', '2025-08-12 20:33:05'),
(48, 'Televisi', 'Baru', '2025-09-06 07:01:24', '2025-09-06 07:01:24'),
(49, 'Televisi', 'Bekas', '2025-09-06 07:01:31', '2025-09-06 07:01:31');

-- --------------------------------------------------------

--
-- Struktur dari tabel `keranjangs`
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
-- Dumping data untuk tabel `keranjangs`
--

INSERT INTO `keranjangs` (`id_keranjang`, `user_id`, `produk_id`, `quantity`, `created_at`, `updated_at`) VALUES
(245, 38, 20, 1, '2025-08-21 17:35:24', '2025-08-21 17:35:24'),
(251, 41, 20, 1, '2025-08-21 21:18:52', '2025-08-21 21:18:52'),
(268, 39, 20, 1, '2025-09-16 05:40:24', '2025-09-16 05:40:24');

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `migrations`
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
(21, '2025_07_24_144602_add_payment_method_to_servis_table', 13),
(22, '2025_08_23_134947_add_shipping_fields_to_pemesanans_table', 14),
(23, '2025_08_23_135157_add_weight_to_produks_table', 14),
(24, '2025_09_03_051624_remove_is_luar_medan_from_pemesanans_table', 15),
(25, '2025_09_03_074116_remove_berat_from_produks_table', 16),
(26, '2025_09_03_074333_add_berat_to_produks_table', 17),
(27, '2025_09_03_094824_add_etd_to_pemesanans_table', 18),
(28, '2025_09_04_052008_add_deskripsi_minus_to_produks_table', 19),
(29, '2025_09_04_111314_create_barang_masuks_table', 20),
(30, '2025_09_05_083947_create_jenis_kerusakans_table', 21),
(31, '2025_09_05_084100_add_kerusakan_opsi_to_servis_table', 21);

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pemesanans`
--

CREATE TABLE `pemesanans` (
  `id_pemesanan` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `nama_penerima` varchar(255) DEFAULT NULL,
  `no_hp` varchar(255) DEFAULT NULL,
  `alamat` text,
  `provinsi` varchar(255) DEFAULT NULL,
  `kota` varchar(255) DEFAULT NULL,
  `kecamatan` varchar(255) DEFAULT NULL,
  `kode_pos` varchar(10) DEFAULT NULL,
  `tgl_pemesanan` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cat_opsional` text,
  `status_pesanan` enum('Pesanan Dibuat','Pesanan Diproses','Diserahkan Kekurir','Pesanan Dalam Perjalanan','Pesanan Sampai','Selesai') NOT NULL DEFAULT 'Pesanan Dibuat',
  `midtrans_order_id` varchar(255) DEFAULT NULL,
  `snap_token` varchar(255) DEFAULT NULL,
  `payment_status` enum('unpaid','paid','failed','expired') NOT NULL DEFAULT 'unpaid',
  `payment_method` varchar(255) DEFAULT NULL,
  `total` int NOT NULL DEFAULT '0',
  `kurir` varchar(255) DEFAULT NULL,
  `layanan` varchar(255) DEFAULT NULL,
  `etd` varchar(255) DEFAULT NULL,
  `ongkir` int NOT NULL DEFAULT '0',
  `berat_total` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `pemesanans`
--

INSERT INTO `pemesanans` (`id_pemesanan`, `user_id`, `nama_penerima`, `no_hp`, `alamat`, `provinsi`, `kota`, `kecamatan`, `kode_pos`, `tgl_pemesanan`, `cat_opsional`, `status_pesanan`, `midtrans_order_id`, `snap_token`, `payment_status`, `payment_method`, `total`, `kurir`, `layanan`, `etd`, `ongkir`, `berat_total`, `created_at`, `updated_at`) VALUES
(241, 39, 'Damanik Toretto', '083198617414', 'binjai utara', 'SUMATERA UTARA', 'BINJAI', 'BINJAI UTARA', '20712', '2025-09-03 09:53:18', 'semoga produknya sesuai', 'Selesai', 'ORDER-241-68b8100eb8b48', '2b5344dc-a254-4a49-8c94-1d7f63ebb532', 'paid', 'bank_transfer', 237000, 'POS', 'POS REGULER', '3 day', 17000, 1500, '2025-09-03 02:53:18', '2025-09-06 11:10:27'),
(242, 39, 'Damanik Toretto', '083198617414', 'Bandung', 'SUMATERA UTARA', 'TOBA SAMOSIR', 'BOR-BOR', '20712', '2025-09-03 10:27:16', 'tidak ada', 'Selesai', 'ORDER-242-68b818049caca', '695561e2-299d-42d3-91de-ad4b654666c0', 'paid', 'bank_transfer', 1071000, 'LION', 'JAGOPACK', '4-7 day', 540000, 5700, '2025-09-03 03:27:16', '2025-09-06 22:40:40'),
(243, 39, 'Damanik Toretto', '083198617414', 'Rumah Kos Ibuk Adek, dijalan bandes no.52 binuang, Kp. Dalam. di sebelah kiri jalan masuk mushalla shobirin.', 'SUMATERA BARAT', 'PADANG', 'PAUH', '26165', '2025-09-03 17:58:25', 'tidak ada', 'Pesanan Dalam Perjalanan', 'ORDER-243-68b881c1bd5a8', 'd9ddf961-3ee7-4ac0-a059-d1299ee67027', 'paid', 'akulaku', 39000, 'TIKI', 'DAT', '3 day', 22000, 150, '2025-09-03 10:58:25', '2025-09-06 11:10:22'),
(244, 39, 'Damanik Toretto', '083198617414', 'Bandung', 'SUMATERA UTARA', 'ASAHAN', 'AIR BATU', '20715', '2025-09-04 06:33:32', 'tidak ada', 'Diserahkan Kekurir', 'ORDER-244-68b932bc161e4', '284206b4-5279-4c15-82bb-3923df73ee5a', 'paid', 'bank_transfer', 105000, 'LION', 'BIGPACKFAST', '2-3 day', 83000, 400, '2025-09-03 23:33:32', '2025-09-06 11:10:20'),
(245, 39, 'Damanik Toretto', '083198617414', 'Gang Merdeka Medan Timur', 'SUMATERA UTARA', 'MEDAN', 'MEDAN TIMUR', '20717', '2025-09-07 06:14:34', 'tidak ada', 'Pesanan Diproses', 'ORDER-245-68bd22ca8c032', '4ddc6a01-0129-4502-9181-fecb27ca7262', 'paid', 'bank_transfer', 485000, 'JNE', 'REG', '6 day', 45000, 3000, '2025-09-06 23:14:34', '2025-09-06 23:15:08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pemesanan_details`
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
-- Dumping data untuk tabel `pemesanan_details`
--

INSERT INTO `pemesanan_details` (`id_detail`, `pemesanan_id`, `produk_id`, `quantity`, `harga_satuan`, `created_at`, `updated_at`) VALUES
(256, 241, 20, 1, 220000, '2025-09-03 02:53:18', '2025-09-03 02:53:18'),
(257, 242, 4, 1, 26000, '2025-09-03 03:27:16', '2025-09-03 03:27:16'),
(258, 242, 8, 1, 15000, '2025-09-03 03:27:16', '2025-09-03 03:27:16'),
(259, 242, 12, 1, 120000, '2025-09-03 03:27:16', '2025-09-03 03:27:16'),
(260, 242, 13, 1, 140000, '2025-09-03 03:27:16', '2025-09-03 03:27:16'),
(261, 242, 17, 1, 230000, '2025-09-03 03:27:16', '2025-09-03 03:27:16'),
(262, 243, 3, 1, 17000, '2025-09-03 10:58:25', '2025-09-03 10:58:25'),
(263, 244, 3, 1, 17000, '2025-09-03 23:33:32', '2025-09-03 23:33:32'),
(264, 244, 7, 1, 5000, '2025-09-03 23:33:32', '2025-09-03 23:33:32'),
(265, 245, 20, 2, 220000, '2025-09-06 23:14:34', '2025-09-06 23:14:34');

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
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
-- Dumping data untuk tabel `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(429, 'App\\Models\\User', 1, 'admin-token', 'abad0d2a70a9f05844b69f101a4b445791e984ff44b719d56d9e7654c5d28247', '[\"*\"]', '2025-08-21 21:45:44', NULL, '2025-08-21 21:02:36', '2025-08-21 21:45:44'),
(431, 'App\\Models\\User', 39, 'pelanggan-token', '6f493219837e7fdf287f76df0d129bd663e8ee9fc0f97167c41be7496e0019cf', '[\"*\"]', '2025-08-24 03:25:28', NULL, '2025-08-24 03:06:13', '2025-08-24 03:25:28'),
(432, 'App\\Models\\User', 39, 'pelanggan-token', 'f4fd744c9b38f22ac522b9a7ff282c90c66705f1010e2adb2a782574b573ad3d', '[\"*\"]', '2025-08-24 07:53:11', NULL, '2025-08-24 03:37:24', '2025-08-24 07:53:11'),
(471, 'App\\Models\\User', 39, 'pelanggan-token', '1dd8f4ba41056ef37781ea0e02f4a5f23c5fb25cc190507118708d8727ad1ae6', '[\"*\"]', '2025-09-16 05:59:54', NULL, '2025-09-16 05:59:49', '2025-09-16 05:59:54');

-- --------------------------------------------------------

--
-- Struktur dari tabel `produks`
--

CREATE TABLE `produks` (
  `id_produk` bigint UNSIGNED NOT NULL,
  `id_kategori` bigint UNSIGNED NOT NULL,
  `nama_produk` varchar(255) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `harga` int NOT NULL,
  `modal` decimal(15,2) NOT NULL DEFAULT '0.00',
  `stok` int NOT NULL,
  `berat` int NOT NULL DEFAULT '1000',
  `gambar_produk` varchar(255) DEFAULT NULL,
  `deskripsi` text,
  `deskripsi_minus` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `produks`
--

INSERT INTO `produks` (`id_produk`, `id_kategori`, `nama_produk`, `sku`, `harga`, `modal`, `stok`, `berat`, `gambar_produk`, `deskripsi`, `deskripsi_minus`, `created_at`, `updated_at`) VALUES
(2, 1, 'Bola Supra 18w Hanoch', 'PRD-002', 23000, 17800.00, 0, 250, 'produk/1755081413_hanoch-18w.jpeg', 'Bola lampu LED Supra 18W dari Hanoch adalah lampu LED kapsul dengan daya 18 watt, fitting E27, dan dirancang untuk memberikan pencahayaan yang terang dengan umur pakai yang panjang. Lampu ini memiliki beberapa spesifikasi teknis yang perlu diperhatikan.', NULL, '2025-08-12 20:36:53', '2025-09-04 09:23:53'),
(3, 1, 'Bola Supra 12w Hanoch', 'PRD-003', 17000, 13400.00, 4, 150, 'produk/1755081455_hanoch-12w.jpg', 'Lampu Hannochs 12W adalah lampu LED yang tersedia dalam berbagai model, termasuk lampu emergency dan downlight. Lampu ini dikenal hemat energi, memiliki umur pakai yang panjang, dan tersedia dalam berbagai pilihan warna cahaya. Beberapa model juga dilengkapi fitur darurat yang akan menyala otomatis saat listrik padam.', NULL, '2025-08-12 20:37:35', '2025-09-03 23:33:45'),
(4, 1, 'Bola Supra 22w Hanoch', 'PRD-004', 26000, 20800.00, 2, 250, 'produk/1755081518_hanoch-22w.jpeg', 'Bola lampu LED Hannochs 22 Watt adalah lampu LED hemat energi yang diproduksi oleh Hannochs, sebuah merek elektronik Indonesia. Lampu ini dikenal karena kualitasnya yang baik dan masa pakainya yang panjang, mencapai 15.000 jam.', NULL, '2025-08-12 20:38:38', '2025-09-04 09:24:04'),
(5, 3, 'Bola Led Vario 22w Hanoch', 'PRD-005', 29000, 22500.00, 0, 350, 'produk/1755081680_hanoch-led-22w.jpeg', 'Lampu LED Hannochs Vario 22 watt adalah bohlam LED yang hemat energi dengan daya 22 watt dan dirancang untuk penggunaan di dalam ruangan. Lampu ini menghasilkan cahaya putih (Cool Daylight) dengan voltase 220-240V dan memiliki fitting E27. Umur lampu ini diklaim mencapai 10.000 jam dengan sudut pencahayaan 180 derajat.', NULL, '2025-08-12 20:41:20', '2025-09-03 01:21:17'),
(6, 3, 'Bola Led Vario 70 w Hanoch', 'PRD-006', 170000, 133750.00, 0, 500, 'produk/1755081767_hanoch-led-70w.jpeg', 'Lampu LED Vario 70 watt dari Hannochs adalah lampu LED hemat energi dengan cahaya putih terang (Cool Daylight 6500 K). Lampu ini memiliki daya 70 watt, menghasilkan 8000 lumens, dan umur lampu hingga 10.000 jam.', NULL, '2025-08-12 20:42:47', '2025-09-03 01:21:25'),
(7, 3, 'Bola Led Omi Hamura 10w', 'PRD-007', 5000, 3450.00, 4, 250, 'produk/1755081851_hamura-led-10w.jpg', 'Lampu LED Omi Hamura 10W adalah lampu LED dengan daya 10 watt yang menghasilkan cahaya putih (cool daylight) dengan suhu warna 6500K. Lampu ini memiliki umur pakai hingga 8.000 jam dan menggunakan fitting E27', NULL, '2025-08-12 20:44:11', '2025-09-04 09:23:13'),
(8, 3, 'Bola Led Omi Hamura 20w', 'PRD-008', 15000, 6300.00, 3, 350, 'produk/1755081981_hamura-led-30w.jpeg', 'Bola lampu LED Omi Hamura 30W adalah lampu LED dengan daya 30 watt yang menghasilkan cahaya putih terang (cool daylight) dengan suhu warna 6500K. Lampu ini memiliki umur lampu hingga 8.000 jam dan menggunakan fitting E27.', NULL, '2025-08-12 20:46:21', '2025-09-06 22:29:22'),
(9, 5, 'Bola AC/DC Orenchi 15W', 'PRD-009', 30000, 25300.00, 0, 110, 'produk/1755082163_orenchi-acdc-15w.jpeg', 'Lampu bola AC/DC Orenchi 15W adalah lampu LED darurat yang dapat menyala baik saat ada listrik maupun saat padam. Lampu ini memiliki beberapa keunggulan, seperti hemat energi hingga 90%, umur lampu yang panjang, dan ramah lingkungan. Selain itu, lampu ini juga sudah memenuhi standar SNI.', NULL, '2025-08-12 20:49:23', '2025-09-04 09:22:57'),
(10, 5, 'Bola AC/DC Orenchi 20W', 'PRD-010', 35000, 25300.00, 0, 250, 'produk/1755082229_orenchi-acdc-20w.jpeg', 'Lampu LED AC/DC Orenchi 20W adalah lampu darurat yang dapat menyala baik saat ada listrik maupun saat mati lampu. Lampu ini hemat energi, memiliki umur panjang, dan sudah memenuhi standar SNI.', NULL, '2025-08-12 20:50:29', '2025-09-03 00:50:22'),
(11, 7, 'Setrika Miyako El2000', 'PRD-011', 120000, 93000.00, 0, 800, 'produk/1755083366_miyako-el2000.jpeg', 'Setrika Miyako EI-2000 B adalah setrika listrik dengan tapak besi berlapis krom yang dilapisi chrome. Setrika ini memiliki desain Classic Style yang memungkinkan jangkauan yang fleksibel ke saku dan celah kancing. Dilengkapi dengan pengatur suhu yang dapat disesuaikan untuk berbagai jenis bahan pakaian, serta pegangan ergonomis untuk kenyamanan penggunaan.', NULL, '2025-08-12 21:09:26', '2025-09-03 01:25:30'),
(12, 7, 'Setrika Miyako El1000', 'PRD-012', 120000, 93000.00, 2, 600, 'produk/1755083413_miyako-el1000.jpeg', 'Setrika Miyako EL1000 adalah setrika listrik yang dirancang untuk membuat proses menyetrika pakaian menjadi lebih mudah dan nyaman. Setrika ini memiliki alas setrika (sole plate) dengan lapisan anti lengket (non-stick) yang terbuat dari Teflon, memungkinkan setrika meluncur dengan lancar di atas kain tanpa menempel.', NULL, '2025-08-12 21:10:13', '2025-09-04 09:24:36'),
(13, 7, 'Setrika Maspion HA125', 'PRD-013', 140000, 111000.00, 2, 1000, 'produk/1755083490_maspion.jpeg', 'Setrika Maspion HA125 adalah setrika listrik yang memiliki daya 350 Watt dan tegangan 220 Volt. Setrika ini dilengkapi dengan tapak setrika anti lengket (non-stick soleplate) untuk memudahkan proses menyetrika dan mencegah pakaian menempel. Selain itu, setrika ini juga memiliki fitur pengaturan suhu yang dapat disesuaikan dengan jenis kain.', NULL, '2025-08-12 21:11:30', '2025-09-04 09:26:20'),
(14, 9, 'Deskfan 12’ Kingston', 'PRD-014', 120000, 101500.00, 3, 2000, 'produk/1755083566_kingston.jpg', 'Kipas angin meja Kingston 12 inci adalah kipas angin meja yang memiliki ukuran 12 inci. Kipas ini dilengkapi dengan tiga pengaturan kecepatan dan motor yang tidak berisik. Selain itu, kipas ini memiliki desain yang stylish dan tersedia dalam berbagai warna. Kipas ini juga dilengkapi dengan grill yang tahan gores dan motor yang berkualitas tinggi.', NULL, '2025-08-12 21:12:46', '2025-09-04 09:26:00'),
(15, 9, 'Deskfan 12’ Miyako', 'PRD-015', 186000, 170000.00, 5, 5000, 'produk/1755083659_miyako-kipasaingin.jpeg', 'Kipas angin meja Miyako 12 inci, seperti KAD-1227 B GB, adalah kipas angin 2-in-1 yang bisa berfungsi sebagai kipas meja (desk fan) dan kipas dinding (wall fan). Kipas ini memiliki baling-baling yang kokoh dan motor yang bertenaga, namun tetap menghasilkan suara yang halus saat beroperasi. KAD-1227 B GB juga dilengkapi dengan fitur keamanan Thermofuse yang memutus arus listrik jika terjadi overheat pada motor.', NULL, '2025-08-12 21:14:19', '2025-09-03 01:23:40'),
(16, 9, 'Deskfan 8’ hyperlite', 'PRD-016', 80000, 69500.00, 3, 2000, 'produk/1755083744_hyperlite-kipasangin.jpeg', 'Kipas angin meja Hyperlite 8 inci, yang juga dikenal sebagai Deskfan 8\' Hyperlite, adalah kipas angin mini yang dirancang untuk ditempatkan di meja atau permukaan datar lainnya. Kipas ini memiliki beberapa pilihan model, termasuk yang bertema karakter animasi seperti Doraemon, Hello Kitty, Iron Man, Mickey Mouse, dan Minion.', NULL, '2025-08-12 21:15:44', '2025-09-04 09:26:10'),
(17, 9, 'Standfan miyako 1606pl', 'PRD-017', 230000, 187000.00, 5, 3500, 'produk/1755083825_miyako-standfan.webp', 'Kipas angin berdiri (Stand Fan) Miyako KAS-1606X PL adalah kipas angin berukuran 16 inci dengan desain elegan berwarna hitam. Kipas ini memiliki tiga pilihan kecepatan yang dapat disesuaikan dan dilengkapi dengan kaki berbentuk silang yang kokoh dan stabil.', NULL, '2025-08-12 21:17:05', '2025-09-03 03:27:32'),
(18, 9, 'Standfan Carslan', 'PRD-018', 125000, 111000.00, 0, 3000, 'produk/1755083886_carslan.jpg', 'Stand fan Carslan adalah kipas angin berdiri yang tersedia dalam berbagai ukuran, seperti 16 inci dan 18 inci, dan dilengkapi dengan berbagai fitur untuk kenyamanan pengguna. Kipas ini memiliki beberapa pilihan kecepatan angin, motor yang kuat dan tidak berisik, serta desain yang kokoh dan stabil.', NULL, '2025-08-12 21:18:06', '2025-09-04 09:26:30'),
(19, 12, 'Blender Utu 2 tabung', 'PRD-019', 110000, 100000.00, 3, 3000, 'produk/1755083952_blender-utu.jpeg', 'Blender UTU 2 tabung, khususnya tipe UT-T26N, adalah alat dapur serbaguna yang dirancang untuk menghaluskan berbagai jenis bahan makanan. Blender ini dilengkapi dua tabung dengan kapasitas berbeda (biasanya 1 liter dan 0.5 liter), serta dua tombol kecepatan dan fungsi pulse untuk pengaturan yang lebih presisi. Material tabung umumnya kaca, yang dikenal mudah dibersihkan dan tidak meninggalkan noda.', NULL, '2025-08-12 21:19:12', '2025-09-04 04:47:50'),
(20, 12, 'Blender Miyako', 'PRD-020', 220000, 178000.00, 1, 1500, 'produk/1755405358_miyako-blender.jpeg', 'Blender Miyako adalah alat dapur serbaguna yang dirancang untuk membantu pengolahan makanan, terutama dalam hal menghaluskan, mencampur, dan menggiling bahan-bahan. Blender ini umumnya tersedia dalam berbagai model dengan fitur dan kapasitas yang berbeda-beda, namun secara umum, blender Miyako dikenal karena kemudahan penggunaan, daya tahan, dan harga yang terjangkau.', NULL, '2025-08-12 21:20:09', '2025-09-06 23:15:08'),
(53, 1, 'Bola Supra 6w Hanoch', 'PRD-001', 12000, 9350.00, 0, 150, 'produk/1755405184_hanoch-6w.jpeg', 'Bola lampu LED Hannochs Supra 6W adalah lampu LED kapsul dengan daya 6 watt yang menghasilkan cahaya putih (Cool Daylight 6500 K). Lampu ini memiliki spesifikasi: voltase 220-240V, lumen 520, diameter 50mm, tinggi 95mm, dan fitting E27. Umur lampu diklaim mencapai 10.000 jam atau sekitar 416 hari.', NULL, '2025-08-16 21:33:04', '2025-09-03 01:22:27'),
(57, 49, 'TV Tabung Samsung 21\"', 'PRD-021', 300000, 150000.00, 5, 12000, 'produk/1757167515_tv6.jpg', 'TV tabung Samsung 21\" adalah televisi Cathode Ray Tube (CRT) dengan ukuran layar 21 inci, yang menawarkan desain sederhana, praktis, dan terjangkau, ideal untuk ruang kecil atau keluarga yang mencari pengalaman menonton dasar namun berkualitas', '1. Warna Kurang Terang\r\n2. Bodinya Jelek', '2025-07-06 07:05:15', '2025-09-06 10:17:23'),
(58, 49, 'TV Tabung LG 14\"', 'PRD-022', 250000, 125000.00, 2, 10000, 'produk/1757167697_tv2.jpg', 'TV Tabung LG 14\" adalah TV dengan teknologi lama yang menggunakan tabung untuk menampilkan gambar, berukuran 14 inci, dan cocok untuk ruang kecil karena ukurannya yang ringkas.', '1. Warna Kurang Terang\r\n2. Bodi Tabung nya Jelek', '2025-07-13 07:08:17', '2025-09-06 07:08:17'),
(59, 49, 'TV Tabung Polytron 21\"', 'PRD-023', 350000, 175000.00, 3, 13000, 'produk/1757167942_tv3.jpg', 'TV Tabung Polytron 21\" adalah televisi jenis CRT dengan layar datar (slim) yang menawarkan gambar cerah dan suara jernih, serta fitur seperti memori program TV, equalizer, dan radio FM bawaan pada beberapa model. Ditenagai dengan listrik 80 Watt.', '1. Bodi Jelek\r\n2. Warna Layar Kurang Jelas', '2025-08-21 07:12:22', '2025-09-06 23:17:07'),
(60, 10, 'Kipas Angin Wallfan 18\"', 'PRD-024', 100000, 80000.00, 2, 7000, 'produk/1757168272_kipasaingin1.jpg', 'Kipas Angin Wallfan 18\" adalah kipas angin dinding berukuran 18 inci dengan baling-baling besi atau aluminium yang kuat, dirancang untuk sirkulasi udara di ruangan luas seperti kantor atau rumah.', '1. Kondisi Bodi Kipasnya Buruk\r\n2. Warna Kipas Pudar', '2025-08-24 07:17:52', '2025-09-06 07:17:52'),
(61, 10, 'Kipas Angin Arashi Standfan 18\"', 'PRD-025', 110000, 90000.00, 2, 5000, 'produk/1757168423_kipasangin2.jpg', 'Kipas Angin Arashi Standfan 18\" adalah kipas angin multifungsi 3-in-1 yang kokoh dan stabil, berukuran 18 inci, dengan baling-baling berbahan aluminium atau stainless steel dan jaring pelindung besi.', '1. Bodi Sedikit Buruk\r\n2. Warna Sedikit Pudar', '2025-07-26 07:20:23', '2025-09-06 07:20:23'),
(62, 10, 'Kipas Angin Deskfan Arashi 16\"', 'PRD-026', 130000, 100000.00, 1, 3000, 'produk/1757168646_kipasangin4.jpg', 'Kipas Angin Deskfan Arashi 16\" adalah kipas angin meja serbaguna dengan baling-baling aluminium 16 inci, motor 50 watt, dan jaring pelindung besi. Kipas ini menghasilkan angin kencang dan kuat, stabil, tidak bising, serta memiliki 3 pilihan kecepatan angin.', '1. Warna Sedikit Pudar\r\n2. Bodi Mulus', '2025-09-06 07:24:06', '2025-09-06 07:24:06'),
(63, 10, 'Kipas Angin Standfan Miyako 18\"', 'PRD-027', 130000, 80000.00, 6, 8000, 'produk/1757168752_kipasangin5.jpg', 'Kipas Angin Standfan Miyako KSB-18 adalah kipas angin berdiri berukuran 18 inci dengan desain industrial, yang dirancang untuk menghasilkan hembusan angin kencang dan merata.', '1. Bodi Mulus\r\n2. Warna Sedikit Pudar', '2025-09-06 07:25:52', '2025-09-06 07:25:52');

-- --------------------------------------------------------

--
-- Struktur dari tabel `roles`
--

CREATE TABLE `roles` (
  `id_role` bigint UNSIGNED NOT NULL,
  `nama_role` enum('admin','pelanggan','teknisi') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `roles`
--

INSERT INTO `roles` (`id_role`, `nama_role`, `created_at`, `updated_at`) VALUES
(1, 'admin', '2025-07-03 13:33:17', '2025-07-04 13:33:17'),
(2, 'pelanggan', '2025-07-03 13:33:28', '2025-07-04 13:33:28'),
(3, 'teknisi', '2025-07-18 10:23:03', '2025-07-18 10:23:03');

-- --------------------------------------------------------

--
-- Struktur dari tabel `servis`
--

CREATE TABLE `servis` (
  `id_servis` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `kerusakan_id` bigint UNSIGNED DEFAULT NULL,
  `estimasi_biaya` bigint UNSIGNED DEFAULT NULL,
  `opsi_pelanggan` enum('setuju','hubungi','jual') NOT NULL DEFAULT 'setuju',
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
-- Dumping data untuk tabel `servis`
--

INSERT INTO `servis` (`id_servis`, `user_id`, `kerusakan_id`, `estimasi_biaya`, `opsi_pelanggan`, `tipe_barang`, `kerusakan`, `ket_tambahan`, `tanggal_servis`, `status_servis`, `total_biaya`, `payment_status`, `payment_method`, `created_at`, `updated_at`) VALUES
(53, 39, 16, 50000, 'setuju', 'Kipas Miyako', 'Kerusakan dibagian kapasitor dan bagian boshing nya', 'Perlu penggantian kapasitor dan boshing nya', '2025-07-06', 'Selesai', 50000, 'paid', 'bank_transfer', '2025-08-16 08:33:03', '2025-08-16 08:36:08'),
(54, 39, 23, 50000, 'setuju', 'Blender', 'Perputaran blender tidak stabil', 'Perlu penggantian karet blender', '2025-07-13', 'Selesai', 15000, 'paid', 'bank_transfer', '2025-08-16 08:39:36', '2025-08-16 09:01:51'),
(55, 39, 24, 50000, 'setuju', 'Speaker Kecil', 'Baterai sudah mulai berjamur', 'Perlu penggantian baterai speaker', '2025-07-20', 'Selesai', 30000, 'paid', 'bank_transfer', '2025-08-16 08:43:37', '2025-08-16 09:02:32'),
(56, 39, 20, 50000, 'setuju', 'Magicom', 'Kotoran menumpuk mengakibatkan panas tidak maksimal', 'Perlu pembersihan mendalam', '2025-08-07', 'Selesai', 40000, 'paid', 'qris', '2025-08-16 08:45:44', '2025-08-16 09:03:03'),
(57, 39, 12, 150000, 'setuju', 'Tv Tabung', 'Kerusakan dibagian komponen yang berada didalam tv', 'Perlu penggantian beberapa komponen yang rusak', '2025-08-02', 'Selesai', 150000, 'unpaid', NULL, '2025-08-16 08:48:58', '2025-08-16 08:49:47'),
(58, 38, 15, 150000, 'setuju', 'Tv LED', 'Kerusakan dibagian lampu yang berada di dalam komponen tv', 'Perlu penggantian lampu yang berada dalam komponen tv', '2025-08-06', 'Selesai', 250000, 'unpaid', NULL, '2025-08-16 08:51:28', '2025-09-06 22:47:42'),
(59, 38, 16, 50000, 'setuju', 'Kipas Kosmos', 'Kerusakan dibagian kapasitor dan bagian boshing nya', 'Perlu penggantian kapasitor 1.5 dan boshing pada kipas nya', '2025-08-10', 'Selesai', 100000, 'paid', 'akulaku', '2025-08-16 08:53:06', '2025-08-16 08:58:31'),
(60, 38, 23, 50000, 'setuju', 'Blender Philip', 'Kerusakan dibagian pisau blendernya', 'Perlu penggantian pisau blendernya yang tumpul', '2025-08-10', 'Selesai', 25000, 'paid', 'qris', '2025-08-16 08:54:52', '2025-08-16 08:58:03'),
(61, 38, 23, 50000, 'setuju', 'Blender Miyako', 'Kerusakan dibagian pisau dan kabel penghubung blender', 'Perlu penggantian pisau yang tumpul dan kabel yang sudah luka', '2025-07-26', 'Selesai', 40000, 'paid', 'qris', '2025-08-16 08:56:36', '2025-08-16 08:57:30'),
(75, 39, 22, 50000, 'setuju', 'Blender', 'Tumpul pada Pisau Blender', 'tidak ada', '2025-09-07', 'Diproses', NULL, 'unpaid', NULL, '2025-09-06 23:20:38', '2025-09-06 23:20:38');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sessions`
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
-- Dumping data untuk tabel `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('EJm2WCANrzmcL0IZZyEeZ81qVCqlPUpB0Q8oj7cR', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQjF6djd6UlA3WlNvWGFWTTgwUmlab2RKN0xLd245a29TTWU1NUtOVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756891436),
('L0T8gae8b4tN6vZxYYGFtfaXB4ABvEzDt8HXDj1x', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVjFPc0hRNkRVcThWOXR4b2xCbm9RV3IyT3NIT3hSZUVBT3BRcEpqcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1758027237),
('mUOrGJWKw2ub1xWlD77Ml8UV8WmDgNjZQjGA7h63', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoialhncDJVbmVLa0xPMlhaeFR4eXNad1I5SnZBVVlZZWVnT2U0aklabiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756898378);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
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
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id_user`, `role_id`, `username`, `name`, `email`, `no_hp`, `alamat`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 1, 'admin', 'Admin', 'sicombomail@gmail.com', '08123456789', 'Admin Address', '2025-07-04 10:25:19', '$2y$12$RCsi2VqsDuvqxWCCY5LEx.DGuV7UaUsCafeZtt86jOwrZLdXmfBoq', 'P1Z90EuzhpsLVZdnOrjaU6c9aFL9ZBd5TBiru9GDZ8pORtvh3sndnpbUoGEo', '2025-07-04 06:35:42', '2025-07-10 04:41:26'),
(37, 3, 'teknisi', 'Teknisi', 'teknisi@example.com', '080987654321', 'Teknisi Address', '2025-07-18 03:50:20', '$2y$12$NzdnyxxWRep6WELtRoHwPeMX2JrHDtIW9pm8TR.adyPf75JCmY0yq', NULL, '2025-07-18 03:31:58', '2025-07-18 03:50:20'),
(38, 2, 'damanik', 'Wahyu Setiawan', 'bulwahyu8@gmail.com', '082267773165', 'Padang', '2025-08-13 07:53:55', '$2y$12$qNBOZ/yLcwO2S9taJSW.1e.7oLRsbUyYOHylEzxGDjD1wCj7SrEji', 'S0Rn6hSiyLBip6UFnai3LWTdtxMX1Iag6so25klosvKpTitQv47xZEo8bzuO', '2025-08-13 07:53:34', '2025-08-16 11:21:19'),
(39, 2, 'wahyu', 'Damanik Toretto', 'wahyu76558@gmail.com', '083198617414', 'Bandung', '2025-08-16 08:30:36', '$2y$12$eo7GiEzniJZeu4XLLXEzreMTL8W1lUEqJdC9hzsydarXWNPnuOIyu', 'i7fVfZVpwGK20ZriG3jkz7nx12v4yI6egGmq4qZQSmNYugKPKsCPKXfhIgOw', '2025-08-16 08:29:53', '2025-08-18 08:07:27'),
(41, 2, 'barunih', 'Wahyu Bulkhoir', 'wahyubulkhoir8@gmail.com', '082267773165', 'Padang', '2025-08-21 20:52:45', '$2y$12$pwz.52QVDIEAPjxZ4P7UDuHc8gMc9WoGUkVpgiS8UEBqGKU5bHMGi', NULL, '2025-08-21 20:49:36', '2025-08-21 20:52:45');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD PRIMARY KEY (`id_barang_masuk`),
  ADD KEY `barang_masuk_produk_id_foreign` (`produk_id`);

--
-- Indeks untuk tabel `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `jenis_kerusakan`
--
ALTER TABLE `jenis_kerusakan`
  ADD PRIMARY KEY (`id_kerusakan`);

--
-- Indeks untuk tabel `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indeks untuk tabel `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `kategoris`
--
ALTER TABLE `kategoris`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indeks untuk tabel `keranjangs`
--
ALTER TABLE `keranjangs`
  ADD PRIMARY KEY (`id_keranjang`),
  ADD UNIQUE KEY `keranjangs_user_id_produk_id_unique` (`user_id`,`produk_id`),
  ADD KEY `keranjangs_produk_id_foreign` (`produk_id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indeks untuk tabel `pemesanans`
--
ALTER TABLE `pemesanans`
  ADD PRIMARY KEY (`id_pemesanan`),
  ADD KEY `pemesanans_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `pemesanan_details`
--
ALTER TABLE `pemesanan_details`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `pemesanan_details_pemesanan_id_foreign` (`pemesanan_id`),
  ADD KEY `pemesanan_details_produk_id_foreign` (`produk_id`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indeks untuk tabel `produks`
--
ALTER TABLE `produks`
  ADD PRIMARY KEY (`id_produk`),
  ADD UNIQUE KEY `produks_sku_unique` (`sku`),
  ADD KEY `produks_id_kategori_foreign` (`id_kategori`);

--
-- Indeks untuk tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_role`);

--
-- Indeks untuk tabel `servis`
--
ALTER TABLE `servis`
  ADD PRIMARY KEY (`id_servis`),
  ADD KEY `servis_user_id_foreign` (`user_id`),
  ADD KEY `servis_kerusakan_id_foreign` (`kerusakan_id`);

--
-- Indeks untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `barang_masuk`
--
ALTER TABLE `barang_masuk`
  MODIFY `id_barang_masuk` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jenis_kerusakan`
--
ALTER TABLE `jenis_kerusakan`
  MODIFY `id_kerusakan` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT untuk tabel `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `kategoris`
--
ALTER TABLE `kategoris`
  MODIFY `id_kategori` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT untuk tabel `keranjangs`
--
ALTER TABLE `keranjangs`
  MODIFY `id_keranjang` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=269;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT untuk tabel `pemesanans`
--
ALTER TABLE `pemesanans`
  MODIFY `id_pemesanan` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;

--
-- AUTO_INCREMENT untuk tabel `pemesanan_details`
--
ALTER TABLE `pemesanan_details`
  MODIFY `id_detail` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=267;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=472;

--
-- AUTO_INCREMENT untuk tabel `produks`
--
ALTER TABLE `produks`
  MODIFY `id_produk` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT untuk tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `id_role` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `servis`
--
ALTER TABLE `servis`
  MODIFY `id_servis` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id_user` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD CONSTRAINT `barang_masuk_produk_id_foreign` FOREIGN KEY (`produk_id`) REFERENCES `produks` (`id_produk`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `keranjangs`
--
ALTER TABLE `keranjangs`
  ADD CONSTRAINT `keranjangs_produk_id_foreign` FOREIGN KEY (`produk_id`) REFERENCES `produks` (`id_produk`) ON DELETE CASCADE,
  ADD CONSTRAINT `keranjangs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pemesanans`
--
ALTER TABLE `pemesanans`
  ADD CONSTRAINT `pemesanans_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pemesanan_details`
--
ALTER TABLE `pemesanan_details`
  ADD CONSTRAINT `pemesanan_details_pemesanan_id_foreign` FOREIGN KEY (`pemesanan_id`) REFERENCES `pemesanans` (`id_pemesanan`) ON DELETE CASCADE,
  ADD CONSTRAINT `pemesanan_details_produk_id_foreign` FOREIGN KEY (`produk_id`) REFERENCES `produks` (`id_produk`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `produks`
--
ALTER TABLE `produks`
  ADD CONSTRAINT `produks_id_kategori_foreign` FOREIGN KEY (`id_kategori`) REFERENCES `kategoris` (`id_kategori`);

--
-- Ketidakleluasaan untuk tabel `servis`
--
ALTER TABLE `servis`
  ADD CONSTRAINT `servis_kerusakan_id_foreign` FOREIGN KEY (`kerusakan_id`) REFERENCES `jenis_kerusakan` (`id_kerusakan`) ON DELETE SET NULL,
  ADD CONSTRAINT `servis_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id_role`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
