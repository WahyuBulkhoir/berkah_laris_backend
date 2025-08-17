<table>
    <tr>
        <td></td>
        <th colspan="2" style="font-size: 18px; text-align: center;">
            🛒 LAPORAN PENJUALAN - {{ $data['bulan_nama'] }} {{ $data['tahun'] }}
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
        <td><strong>Total Modal</strong></td>
        <td>Rp {{ number_format($data['total_modal'], 0, ',', '.') }}</td>
    </tr>
    <tr>
        <td></td>
        <td><strong>Laba / Rugi</strong></td>
        <td>Rp {{ number_format($data['laba_rugi'], 0, ',', '.') }}</td>
    </tr>
    <tr>
        <td></td>
        <td><strong>Total Pesanan</strong></td>
        <td>{{ $data['total_pesanan'] }} transaksi</td>
    </tr>
</table>

<!-- Rincian Harian -->
@if(collect($data['harian'])->where('total', '>', 0)->count() > 0)
    <table>
        <tr>
            <td></td>
            <th colspan="2" style="background-color: #2563EB; color: white; text-align: center;">Rincian Penjualan Harian
            </th>
        </tr>
        <tr style="background-color: #E0E7FF; text-align: center;">
            <td></td>
            <th>Tanggal</th>
            <th>Jumlah Transaksi dan Total</th>
        </tr>
        @foreach ($data['harian'] as $item)
            @if ($item['total'] > 0)
                <tr>
                    <td></td>
                    <td>{{ $item['day'] }} {{ $data['bulan_nama'] }}</td>
                    <td>{{ $item['count'] ?? 0 }} transaksi (Rp {{ number_format($item['total'], 0, ',', '.') }})</td>
                </tr>
            @endif
        @endforeach
    </table>
@endif

<!-- Produk Terlaris -->
@if(!empty($data['top_products']))
    <table>
        <tr>
            <td></td>
            <th colspan="2" style="background-color: #2563EB; color: white; text-align: center;">Produk Terlaris</th>
        </tr>
        <tr style="background-color: #E0E7FF; text-align: center;">
            <td></td>
            <th>Nama Produk</th>
            <th>Jumlah dan Total</th>
        </tr>
        @foreach ($data['top_products'] as $item)
            <tr>
                <td></td>
                <td>{{ $item['name'] }}</td>
                <td>{{ $item['sold'] }} unit (Rp {{ number_format($item['total'], 0, ',', '.') }})</td>
            </tr>
        @endforeach
    </table>
@endif

<!-- Metode Pembayaran Populer -->
@if(!empty($data['top_methods']))
    <table>
        <tr>
            <td></td>
            <th colspan="2" style="background-color: #2563EB; color: white; text-align: center;">Metode Pembayaran Populer
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
@endif