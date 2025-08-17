<table>
    <tr>
        <td></td>
        <th colspan="2" style="font-size: 18px; text-align: center;">
            🛠️ LAPORAN SERVIS - {{ $data['bulan_nama'] }} {{ $data['tahun'] }}
        </th>
    </tr>
</table>

<!-- Ringkasan -->
<table>
    <tr>
        <td></td>
        <th colspan="2" style="background-color: #2563EB; color: white; text-align: center;">Ringkasan</th>
    </tr>
    <tr>
        <td></td>
        <td><strong>Total Pendapatan</strong></td>
        <td>Rp {{ number_format($data['total_pendapatan'], 0, ',', '.') }}</td>
    </tr>
    <tr>
        <td></td>
        <td><strong>Total Pelanggan Servis</strong></td>
        <td style="text-align: left;">{{ $data['total_pelanggan'] ?? '0' }}</td>
    </tr>
    <tr>
        <td></td>
        <td><strong>Total Servis</strong></td>
        <td style="text-align: left;">{{ $data['total_pesanan'] }}</td>
    </tr>
</table>

<!-- Data Harian -->
<table>
    <tr>
        <td></td>
        <th colspan="2" style="background-color: #2563EB; color: white; text-align: center;">Data Harian</th>
    </tr>
    <tr style="background-color: #E0E7FF; text-align: center;">
        <td></td>
        <th>Tanggal</th>
        <th>Total Biaya</th>
    </tr>
    @foreach ($data['harian'] as $item)
        <tr>
            <td></td>
            <td>{{ $item['day'] }} {{ $data['bulan_nama'] }}</td>
            <td>Rp {{ number_format($item['total'], 0, ',', '.') }}</td>
        </tr>
    @endforeach
</table>

<!-- Servis Terbanyak -->
<table>
    <tr>
        <td></td>
        <th colspan="2" style="background-color: #2563EB; color: white; text-align: center;">Servis Terbanyak</th>
    </tr>
    <tr style="background-color: #E0E7FF; text-align: center;">
        <td></td>
        <th>Tipe Barang</th>
        <th>Total Biaya</th>
    </tr>
    @foreach ($data['top_products'] as $item)
        <tr>
            <td></td>
            <td>{{ $item['name'] }}</td>
            <td>{{ $item['price'] }}</td>
        </tr>
    @endforeach
</table>

<!-- Metode Pembayaran -->
<table>
    <tr>
        <td></td>
        <th colspan="2" style="background-color: #2563EB; color: white; text-align: center;">Metode Pembayaran Servis
        </th>
    </tr>
    <tr style="background-color: #E0E7FF; text-align: center;">
        <td></td>
        <th>Metode</th>
        <th>Jumlah dan Persentase</th>
    </tr>
    @foreach ($data['top_methods'] as $item)
        <tr>
            <td></td>
            <td>{{ $item['name'] }}</td>
            <td>{{ $item['count'] }} transaksi ({{ $item['percentage'] }}%)</td>
        </tr>
    @endforeach
</table>