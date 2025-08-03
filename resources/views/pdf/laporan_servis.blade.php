<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <title>Laporan Servis</title>
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

    <h2>LAPORAN SERVIS BULAN<br>{{ $data['bulan_nama'] ?? '-' }} {{ $data['tahun'] ?? '' }}</h2>

    <!-- RINGKASAN -->
    <table>
        <tr>
            <th>Total Pendapatan</th>
            <td>Rp {{ number_format((float) $data['total_pendapatan'] ?? 0, 0, ',', '.') }}</td>
        </tr>
        <tr>
            <th>Total Pelanggan Servis</th>
            <td>{{ $data['total_pelanggan'] ?? 0 }} pelanggan</td>
        </tr>
        <tr>
            <th>Total Servis</th>
            <td>{{ $data['total_pesanan'] ?? 0 }} servis</td>
        </tr>
    </table>

    <!-- SERVIS HARIAN -->
    @if(collect($data['harian'] ?? [])->where('total', '>', 0)->count() > 0)
        <h3>Rincian Servis Harian</h3>
        <table>
            <tr class="sub-header">
                <td>Tanggal</td>
                <td>Total Biaya</td>
            </tr>
            @foreach ($data['harian'] as $item)
                @if ($item['total'] > 0)
                    <tr>
                        <td>{{ $item['day'] }} {{ $data['bulan_nama'] }}</td>
                        <td>Rp {{ number_format((float) $item['total'], 0, ',', '.') }}</td>
                    </tr>
                @endif
            @endforeach
        </table>
    @endif

    @if(!empty($data['top_products']))
        <h3>5 Servis Tipe Barang Terbanyak</h3>
        <table>
            <thead>
                <tr>
                    <th>Tipe Barang</th>
                    <th>Total Biaya</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($data['top_products'] as $item)
                    <tr>
                        <td>{{ $item['name'] }}</td>
                        <td>{{$item['price'] }}</td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    @endif

    <!-- METODE PEMBAYARAN -->
    @if(!empty($data['top_methods']))
        <h3>Metode Pembayaran Terbanyak</h3>
        <table>
            <tr class="sub-header">
                <td>Metode</td>
                <td>Jumlah Transaksi</td>
                <td>Persentase</td>
            </tr>
            @foreach ($data['top_methods'] as $item)
                <tr>
                    <td>{{ $item['name'] }}</td>
                    <td>{{ $item['count'] ?? 0 }} transaksi</td>
                    <td>{{ $item['percentage'] ?? 0 }}%</td>
                </tr>
            @endforeach
        </table>
    @endif

</body>

</html>