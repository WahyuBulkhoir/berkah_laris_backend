<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <title>Invoice #{{ $pemesanan->id_pemesanan }}</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 12px;
            color: #000;
            margin: 20px;
        }

        .header {
            text-align: center;
            margin-bottom: 10px;
        }

        .header h1 {
            margin: 0;
            font-size: 22px;
            letter-spacing: 5px;
        }

        .header h2 {
            margin: 5px 0 0;
            font-size: 16px;
        }

        .header h4 {
            margin: 5px 0;
            font-weight: normal;
        }

        .info {
            width: 100%;
            margin: 20px 0;
            border-collapse: collapse;
        }

        .info td {
            padding: 4px 8px;
            vertical-align: top;
        }

        .info td:first-child {
            width: 140px;
            font-weight: bold;
        }

        .produk {
            border-collapse: collapse;
            width: 100%;
            margin-top: 10px;
        }

        .produk th,
        .produk td {
            border: 1px solid #000;
            padding: 6px;
            text-align: left;
        }

        .produk th {
            background: #f2f2f2;
        }

        .right {
            text-align: right;
        }

        .total {
            margin-top: 15px;
            width: 100%;
        }

        .total td {
            padding: 4px 8px;
        }

        .signature {
            margin-top: 40px;
            width: 100%;
        }

        .signature td {
            text-align: center;
            padding-top: 40px;
        }
    </style>
</head>

<body>
    <div class="header">
        <h1>INVOICE</h1>
        <h2><strong>TOKO BERKAH LARIS</strong></h2>
        <h4>Jl. Swadaya I No.456, Bandar Khalipah, Kec. Percut Sei Tuan,<br>
            Kab. Deli Serdang, Sumatera Utara 20371<br>
            Telp: 0812-3456-7890</h4>
    </div>

    <table class="info">
        <tr>
            <td>Invoice #</td>
            <td>{{ $pemesanan->id_pemesanan }}</td>
            <td><b>Tanggal</b></td>
            <td>{{ $pemesanan->tgl_pemesanan->format('d M Y H:i') }} WIB</td>
        </tr>
        <tr>
            <td>Midtrans Order ID</td>
            <td>{{ $pemesanan->midtrans_order_id ?? '-' }}</td>
            <td><b>Metode Pembayaran</b></td>
            <td>{{ $pemesanan->payment_method ?? '-' }}</td>
        </tr>
        <tr>
            <td>Penerima</td>
            <td>{{ $pemesanan->nama_penerima }}</td>
            <td><b>No. HP Penerima</b></td>
            <td>{{ $pemesanan->no_hp }}</td>
        </tr>
        <tr>
            <td>Kurir</td>
            <td>{{ $pemesanan->kurir }} - {{ $pemesanan->layanan }} ({{ $pemesanan->etd ?? '-' }})</td>
            <td><b>Berat Total</b></td>
            <td>
                @if($pemesanan->berat_total < 1000)
                    {{ $pemesanan->berat_total }} gram
                @else
                    {{ number_format($pemesanan->berat_total / 1000, 2, ',', '.') }} kg
                @endif
            </td>
        </tr>
        <tr>
            <td>Alamat</td>
            <td colspan="3">{{ $pemesanan->alamat }}, {{ $pemesanan->kecamatan }},
                {{ $pemesanan->kota }}, {{ $pemesanan->provinsi }} {{ $pemesanan->kode_pos }}
            </td>
        </tr>
    </table>

    <table class="produk">
        <thead>
            <tr>
                <th>Qty</th>
                <th>Nama Produk</th>
                <th class="right">Harga Satuan</th>
                <th class="right">Subtotal</th>
            </tr>
        </thead>
        <tbody>
            @php
                $subtotalProduk = 0;
            @endphp
            @foreach($pemesanan->details as $detail)
                @php
                    $lineTotal = $detail->quantity * $detail->harga_satuan;
                    $subtotalProduk += $lineTotal;
                @endphp
                <tr>
                    <td>{{ $detail->quantity }}</td>
                    <td>{{ $detail->produk->nama_produk }}</td>
                    <td class="right">Rp {{ number_format($detail->harga_satuan, 0, ',', '.') }}</td>
                    <td class="right">Rp {{ number_format($lineTotal, 0, ',', '.') }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>

    <table class="total">
        <tr>
            <td style="text-align:right; font-weight:bold;">Subtotal Produk :</td>
            <td style="text-align:right;">Rp {{ number_format($subtotalProduk, 0, ',', '.') }}</td>
        </tr>
        <tr>
            <td style="text-align:right; font-weight:bold;">Ongkir :</td>
            <td style="text-align:right;">Rp {{ number_format($pemesanan->ongkir, 0, ',', '.') }}</td>
        </tr>
        <tr>
            <td style="text-align:right; font-weight:bold;">TOTAL :</td>
            <td style="text-align:right;">Rp {{ number_format($pemesanan->total, 0, ',', '.') }}</td>
        </tr>
    </table>

    <table class="signature">
        <tr>
            <td>Penerima / Pembeli</td>
            <td>Toko Berkah Laris</td>
        </tr>
    </table>
</body>

</html>