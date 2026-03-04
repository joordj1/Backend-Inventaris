-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 04 Mar 2026 pada 07.07
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventaris_kantor`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `aset`
--

CREATE TABLE `aset` (
  `id_aset` int(11) NOT NULL,
  `id_kantor` int(11) NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `id_lokasi` int(11) NOT NULL,
  `kode_barcode` varchar(100) NOT NULL,
  `nama_aset` varchar(150) NOT NULL,
  `merk` varchar(100) DEFAULT NULL,
  `tipe` varchar(100) DEFAULT NULL,
  `tahun_perolehan` year(4) DEFAULT NULL,
  `harga_perolehan` decimal(15,2) DEFAULT NULL,
  `kondisi` enum('baik','rusak ringan','rusak berat') DEFAULT 'baik',
  `status` enum('tersedia','dipinjam','dihapus') DEFAULT 'tersedia',
  `lokasi` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `aset`
--

INSERT INTO `aset` (`id_aset`, `id_kantor`, `id_kategori`, `id_lokasi`, `kode_barcode`, `nama_aset`, `merk`, `tipe`, `tahun_perolehan`, `harga_perolehan`, `kondisi`, `status`, `lokasi`, `created_at`) VALUES
(2, 1, 1, 4, 'BRG001', 'Laptop Dell', 'Dell', 'Latitude', '2024', 12000000.00, 'baik', 'tersedia', 'Gudang Utama', '2026-03-04 03:55:13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kantor`
--

CREATE TABLE `kantor` (
  `id_kantor` int(11) NOT NULL,
  `nama_kantor` varchar(100) NOT NULL,
  `alamat` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kantor`
--

INSERT INTO `kantor` (`id_kantor`, `nama_kantor`, `alamat`, `created_at`) VALUES
(1, 'Kantor PLTA', NULL, '2026-03-04 03:46:34');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori_aset`
--

CREATE TABLE `kategori_aset` (
  `id_kategori` int(11) NOT NULL,
  `nama_kategori` varchar(100) NOT NULL,
  `deskripsi` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kategori_aset`
--

INSERT INTO `kategori_aset` (`id_kategori`, `nama_kategori`, `deskripsi`) VALUES
(1, 'Elektronik', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_aktivitas`
--

CREATE TABLE `log_aktivitas` (
  `id_log` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `aktivitas` text DEFAULT NULL,
  `waktu` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `lokasi`
--

CREATE TABLE `lokasi` (
  `id_lokasi` int(11) NOT NULL,
  `id_kantor` int(11) NOT NULL,
  `nama_lokasi` varchar(100) NOT NULL,
  `keterangan` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `lokasi`
--

INSERT INTO `lokasi` (`id_lokasi`, `id_kantor`, `nama_lokasi`, `keterangan`, `created_at`) VALUES
(4, 1, 'Gudang Utama', 'Penyimpanan alat', '2026-03-04 03:47:19');

-- --------------------------------------------------------

--
-- Struktur dari tabel `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int(11) NOT NULL,
  `id_aset` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `tanggal_pinjam` datetime NOT NULL,
  `tanggal_kembali` datetime DEFAULT NULL,
  `status` enum('dipinjam','kembali') DEFAULT 'dipinjam',
  `keterangan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `id_kantor` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL,
  `status` enum('aktif','nonaktif') DEFAULT 'aktif',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `aset`
--
ALTER TABLE `aset`
  ADD PRIMARY KEY (`id_aset`),
  ADD UNIQUE KEY `kode_barcode` (`kode_barcode`),
  ADD KEY `id_kantor` (`id_kantor`),
  ADD KEY `id_kategori` (`id_kategori`),
  ADD KEY `fk_aset_lokasi` (`id_lokasi`);

--
-- Indeks untuk tabel `kantor`
--
ALTER TABLE `kantor`
  ADD PRIMARY KEY (`id_kantor`);

--
-- Indeks untuk tabel `kategori_aset`
--
ALTER TABLE `kategori_aset`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indeks untuk tabel `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `lokasi`
--
ALTER TABLE `lokasi`
  ADD PRIMARY KEY (`id_lokasi`),
  ADD KEY `id_kantor` (`id_kantor`);

--
-- Indeks untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`),
  ADD KEY `id_aset` (`id_aset`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `id_kantor` (`id_kantor`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `aset`
--
ALTER TABLE `aset`
  MODIFY `id_aset` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `kantor`
--
ALTER TABLE `kantor`
  MODIFY `id_kantor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `kategori_aset`
--
ALTER TABLE `kategori_aset`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `lokasi`
--
ALTER TABLE `lokasi`
  MODIFY `id_lokasi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `aset`
--
ALTER TABLE `aset`
  ADD CONSTRAINT `aset_ibfk_1` FOREIGN KEY (`id_kantor`) REFERENCES `kantor` (`id_kantor`),
  ADD CONSTRAINT `aset_ibfk_2` FOREIGN KEY (`id_kategori`) REFERENCES `kategori_aset` (`id_kategori`),
  ADD CONSTRAINT `fk_aset_lokasi` FOREIGN KEY (`id_lokasi`) REFERENCES `lokasi` (`id_lokasi`);

--
-- Ketidakleluasaan untuk tabel `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  ADD CONSTRAINT `log_aktivitas_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Ketidakleluasaan untuk tabel `lokasi`
--
ALTER TABLE `lokasi`
  ADD CONSTRAINT `lokasi_ibfk_1` FOREIGN KEY (`id_kantor`) REFERENCES `kantor` (`id_kantor`);

--
-- Ketidakleluasaan untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD CONSTRAINT `peminjaman_ibfk_1` FOREIGN KEY (`id_aset`) REFERENCES `aset` (`id_aset`),
  ADD CONSTRAINT `peminjaman_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Ketidakleluasaan untuk tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_kantor`) REFERENCES `kantor` (`id_kantor`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
