<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Laporan Penjualan</title>
    <style>
        body {
            font-family: DejaVu Sans, sans-serif;
            font-size: 12px;
            color: #333;
        }

        h2,
        h3 {
            margin-top: 25px;
            margin-bottom: 10px;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th,
        td {
            border: 1px solid #999;
            padding: 6px 10px;
            text-align: left;
        }

        th {
            background-color: #E0E7FF;
        }

        .sub-header {
            background-color: #E0E7FF;
            font-weight: bold;
            text-align: center;
        }

        .text-right {
            text-align: right;
        }

        .no-border td {
            border: none;
        }
    </style>
</head>

<body>

    <h2>LAPORAN PENJUALAN BULAN<br>{{ $data['bulan_nama'] ?? '-' }} {{ $data['tahun'] ?? '' }}</h2>

    <!-- RINGKASAN -->
    <table>
        <tr>
            <th>Total Pendapatan</th>
            <td>Rp {{ number_format($data['total_pendapatan'] ?? 0, 0, ',', '.') }}</td>
        </tr>
        <tr>
            <th>Total Modal</th>
            <td>Rp {{ number_format($data['total_modal'] ?? 0, 0, ',', '.') }}</td>
        </tr>
        <tr>
            <th>Laba / Rugi</th>
            <td>Rp {{ number_format($data['laba_rugi'] ?? 0, 0, ',', '.') }}</td>
        </tr>
        <tr>
            <th>Total Pesanan</th>
            <td>{{ $data['total_pesanan'] ?? 0 }} transaksi</td>
        </tr>
    </table>

    <!-- RINCIAN HARIAN -->
    <h3>Rincian Penjualan Harian</h3>
    <table>
        <tr class="sub-header">
            <td>Tanggal</td>
            <td>Jumlah Transaksi</td>
            <td>Total Penjualan</td>
        </tr>
        @foreach ($data['harian'] ?? [] as $item)
            @if (($item['total'] ?? 0) > 0)
                <tr>
                    <td>{{ $item['day'] }} {{ $data['bulan_nama'] }}</td>
                    <td>{{ $item['count'] ?? 0 }} transaksi</td>
                    <td>Rp {{ number_format($item['total'] ?? 0, 0, ',', '.') }}</td>
                </tr>
            @endif
        @endforeach
    </table>

    <!-- PRODUK TERLARIS -->
    <h3>5 Produk Terlaris</h3>
    <table>
        <tr class="sub-header">
            <td>Nama Produk</td>
            <td>Jumlah Terjual</td>
            <td>Harga Satuan</td>
            <td>Total</td>
        </tr>
        @foreach ($data['top_products'] ?? [] as $item)
            <tr>
                <td>{{ $item['name'] }}</td>
                <td>{{ $item['sold'] }} unit</td>
                <td>{{ $item['price'] }}</td>
                <td>Rp {{ number_format($item['total'] ?? 0, 0, ',', '.') }}</td>
            </tr>
        @endforeach
    </table>

    <!-- METODE PEMBAYARAN -->
    <h3>Metode Pembayaran Populer</h3>
    <table>
        <tr class="sub-header">
            <td>Metode</td>
            <td>Jumlah Pesanan</td>
            <td>Persentase</td>
        </tr>
        @foreach ($data['top_methods'] ?? [] as $item)
            <tr>
                <td>{{ $item['name'] }}</td>
                <td>{{ $item['count'] }}</td>
                <td>{{ $item['percentage'] }}%</td>
            </tr>
        @endforeach
    </table>

</body>

</html>