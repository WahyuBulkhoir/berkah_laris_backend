<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Pemesanan;
use App\Models\PemesananDetail;
use App\Models\Keranjang;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use App\Exports\LaporanPenjualanExport;
use Maatwebsite\Excel\Facades\Excel;
use Barryvdh\DomPDF\Facade\Pdf;

class PemesananController extends Controller
{
    public function index(Request $request)
    {
        $user = Auth::user();

        if ($user->role_id == 1) {
            $pesanan = Pemesanan::with(['details.produk', 'user'])
                ->orderBy('tgl_pemesanan', 'desc')
                ->get();
        } else {
            $pesanan = Pemesanan::with(['details.produk'])
                ->where('user_id', $user->id_user)
                ->orderBy('tgl_pemesanan', 'desc')
                ->get();
        }

        return response()->json(['data' => $pesanan]);
    }

    public function getSnapToken($id)
    {
        \Log::info('Ambil snap token untuk ID:', [
            'id' => $id,
            'user_id' => auth()->user()->id_user
        ]);

        $pemesanan = Pemesanan::where('id_pemesanan', $id)
            ->where('user_id', auth()->user()->id_user)
            ->firstOrFail();

        return response()->json([
            'snap_token' => $pemesanan->snap_token
        ]);
    }

    public function store(Request $request)
    {
        \Log::info('Data masuk ke store:', $request->all());

        $request->validate([
            'nama_penerima' => 'required|string|max:100',
            'no_hp' => 'required|string|max:20',
            'alamat' => 'required|string',
            'provinsi' => 'required|string',
            'kota' => 'required|string',
            'kecamatan' => 'nullable|string',
            'kode_pos' => 'nullable|string|max:10',
            'kurir' => 'required|string',
            'layanan' => 'required|string',
            'etd' => 'required|string',
            'ongkir' => 'required|integer|min:0',
            'berat_total' => 'required|integer|min:1',
            'selected_items' => 'required|array|min:1',
        ]);

        $user = Auth::user();

        $keranjangItems = Keranjang::with('produk')
            ->where('user_id', $user->id_user)
            ->whereIn('id_keranjang', $request->selected_items)
            ->get();

        if ($keranjangItems->isEmpty()) {
            return response()->json(['message' => 'Item keranjang tidak ditemukan atau sudah dihapus.'], 400);
        }

        // Validasi stok cukup (tanpa mengurangi)
        foreach ($keranjangItems as $item) {
            if ($item->quantity > $item->produk->stok) {
                return response()->json([
                    'message' => "Stok produk '{$item->produk->nama_produk}' tidak mencukupi. Sisa stok: {$item->produk->stok}"
                ], 422);
            }
        }

        DB::beginTransaction();
        try {
            $subtotal = $keranjangItems->sum(fn($i) => $i->produk->harga * $i->quantity);
            $grandTotal = $subtotal + (int) $request->ongkir;

            $pemesanan = Pemesanan::create([
                'user_id' => $user->id_user,
                'tgl_pemesanan' => now(),
                'cat_opsional' => $request->cat_opsional,
                'status_pesanan' => 'Pesanan Dibuat',
                'payment_status' => 'unpaid',
                'total' => $grandTotal,
                'nama_penerima' => $request->nama_penerima,
                'no_hp' => $request->no_hp,
                'alamat' => $request->alamat,
                'provinsi' => $request->provinsi,
                'kota' => $request->kota,
                'kecamatan' => $request->kecamatan,
                'kode_pos' => $request->kode_pos,
                'kurir' => strtoupper($request->kurir),
                'layanan' => strtoupper($request->layanan),
                'etd' => $request->etd,
                'ongkir' => (int) $request->ongkir,
                'berat_total' => (int) $request->berat_total,
            ]);

            foreach ($keranjangItems as $item) {
                PemesananDetail::create([
                    'pemesanan_id' => $pemesanan->id_pemesanan,
                    'produk_id' => $item->produk_id,
                    'quantity' => $item->quantity,
                    'harga_satuan' => $item->produk->harga,
                ]);
            }

            // Midtrans (tetap)
            \Midtrans\Config::$serverKey = config('services.midtrans.server_key');
            \Midtrans\Config::$isProduction = config('services.midtrans.is_production', false);
            \Midtrans\Config::$isSanitized = true;
            \Midtrans\Config::$is3ds = true;

            $orderId = 'ORDER-' . $pemesanan->id_pemesanan . '-' . uniqid();
            $params = [
                'transaction_details' => [
                    'order_id' => $orderId,
                    'gross_amount' => $grandTotal, // SUBTOTAL + ONGKIR
                ],
                'customer_details' => [
                    'first_name' => $request->nama_penerima,
                    'email' => $user->email ?? 'noemail@example.com',
                    'phone' => $request->no_hp,
                    'billing_address' => [
                        'first_name' => $request->nama_penerima,
                        'phone' => $request->no_hp,
                        'address' => $request->alamat,
                    ]
                ]
            ];

            $snapToken = \Midtrans\Snap::getSnapToken($params);
            $pemesanan->update([
                'midtrans_order_id' => $orderId,
                'snap_token' => $snapToken
            ]);

            // JANGAN hapus keranjang di sini; biarkan dihapus setelah sukses bayar (frontend onSuccess)
            DB::commit();

            return response()->json([
                'message' => 'Pemesanan berhasil dibuat.',
                'snap_token' => $snapToken,
                'data' => $pemesanan->load('details.produk')
            ], 201);
        } catch (\Exception $e) {
            DB::rollBack();
            \Log::error('Gagal membuat pemesanan: ' . $e->getMessage());
            return response()->json([
                'message' => 'Gagal menyimpan pemesanan',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function show($id_detail)
    {
        $pemesanan = Pemesanan::with('details.produk')->findOrFail($id_detail);
        return response()->json($pemesanan);
    }

    public function update(Request $request, $id_pemesanan)
    {
        $request->validate([
            'status_pesanan' => 'nullable|string|in:Pesanan Dibuat,Pesanan Diproses,Diserahkan Kekurir,Pesanan Dalam Perjalanan,Pesanan Sampai,Selesai',
            'payment_status' => 'nullable|string|in:unpaid,paid'
        ]);

        $pemesanan = Pemesanan::findOrFail($id_pemesanan);

        if ($request->has('status_pesanan')) {
            $pemesanan->status_pesanan = $request->status_pesanan;
        }

        if ($request->has('payment_status')) {
            $pemesanan->payment_status = $request->payment_status;
        }

        $pemesanan->save();

        return response()->json([
            'message' => 'Pemesanan berhasil diperbarui.',
            'data' => $pemesanan
        ]);
    }

    public function alamatRiwayat()
    {
        $user = Auth::user();

        $alamatUnik = Pemesanan::where('user_id', $user->id_user)
            ->select('nama_penerima', 'no_hp', 'alamat')
            ->distinct()
            ->get()
            ->unique(function ($item) {
                return strtolower(trim($item->nama_penerima)) . '|' .
                    strtolower(trim($item->no_hp)) . '|' .
                    strtolower(trim($item->alamat));
            })
            ->values();

        return response()->json(['data' => $alamatUnik]);
    }

    public function batalCheckout(Request $request)
    {
        $request->validate(['id_keranjang' => 'required|array']);

        $items = Keranjang::with('produk')
            ->whereIn('id_keranjang', $request->id_keranjang)
            ->get();

        foreach ($items as $item) {
            $item->produk->increment('stok', $item->quantity);
        }

        return response()->json(['message' => 'Stok berhasil dikembalikan.']);
    }

    public function laporanLabaRugi(Request $request)
    {
        $bulan = $request->input('bulan');
        $tahun = $request->input('tahun');

        if (!$bulan || !$tahun) {
            return response()->json(['message' => 'Bulan dan tahun wajib diisi'], 400);
        }

        $pemesanans = Pemesanan::with(['details.produk'])
            ->whereMonth('tgl_pemesanan', $bulan)
            ->whereYear('tgl_pemesanan', $tahun)
            ->where('status_pesanan', 'Selesai')
            ->where('payment_status', 'paid')
            ->get();

        $total_pendapatan = 0;
        $total_modal = 0;
        $harian = [];
        $produkTerjual = [];
        $metodePembayaran = [];

        foreach ($pemesanans as $pemesanan) {
            $paymentMethod = $pemesanan->payment_method ?? 'Lainnya';
            $metodePembayaran[$paymentMethod] = ($metodePembayaran[$paymentMethod] ?? 0) + 1;

            foreach ($pemesanan->details as $detail) {
                $jumlah = $detail->quantity;
                $harga = $detail->harga_satuan;
                $modal = $detail->produk->modal ?? 0;

                $total_pendapatan += $jumlah * $harga;
                $total_modal += $jumlah * $modal;

                $hari = Carbon::parse($pemesanan->tgl_pemesanan)->format('j');
                if (!isset($harian[$hari])) {
                    $harian[$hari] = 0;
                }
                $harian[$hari] += $jumlah * $harga;

                $nama_produk = $detail->produk->nama_produk ?? 'Produk Tidak Diketahui';
                if (!isset($produkTerjual[$nama_produk])) {
                    $produkTerjual[$nama_produk] = [
                        'name' => $nama_produk,
                        'sold' => 0,
                        'price' => 'Rp ' . number_format($harga, 0, ',', '.'),
                        'total' => 0,
                    ];
                }

                $produkTerjual[$nama_produk]['sold'] += $jumlah;
                $produkTerjual[$nama_produk]['total'] += $jumlah * $harga;
            }
        }

        $harianFormatted = [];

        foreach ($harian as $hari => $total) {
            if ($total <= 0)
                continue;

            $transaksiCount = $pemesanans->filter(function ($pemesanan) use ($hari) {
                return Carbon::parse($pemesanan->tgl_pemesanan)->day == $hari;
            })->count();

            $harianFormatted[] = [
                'day' => $hari,
                'total' => $total,
                'count' => $transaksiCount,
            ];
        }

        $topProduk = collect($produkTerjual)
            ->sortByDesc('sold')
            ->take(5)
            ->values()
            ->all();

        $topMetode = collect($metodePembayaran)
            ->sortByDesc(fn($count) => $count)
            ->map(function ($count, $method) use ($pemesanans) {
                $total = $pemesanans->count();
                $percentage = $total > 0 ? round(($count / $total) * 100) : 0;

                return [
                    'name' => $method,
                    'percentage' => $percentage,
                    'count' => $count,
                    'color' => 'white',
                    'icon' => 'fas fa-credit-card'
                ];
            })
            ->take(5)
            ->values()
            ->all();

        $total_pesanan = $pemesanans->count();
        $laba_rugi = $total_pendapatan - $total_modal;

        return response()->json([
            'total_pendapatan' => $total_pendapatan,
            'total_modal' => $total_modal,
            'laba_rugi' => $laba_rugi,
            'total_pesanan' => $total_pesanan,
            'harian' => $harianFormatted,
            'top_products' => $topProduk,
            'top_methods' => $topMetode,
        ]);
    }

    public function downloadLaporan(Request $request)
    {
        $bulan = $request->input('bulan');
        $tahun = $request->input('tahun');
        $tipe = $request->input('tipe');

        if (!$bulan || !$tahun || !in_array($tipe, ['pdf', 'excel'])) {
            return response()->json(['message' => 'Bulan, tahun, dan tipe wajib diisi dengan benar'], 400);
        }

        $laporanResponse = $this->laporanLabaRugi($request);
        $laporanData = $laporanResponse->getData(true);

        Carbon::setLocale('id');
        $laporanData['bulan_nama'] = Carbon::createFromDate($tahun, $bulan)->translatedFormat('F');
        $laporanData['tahun'] = $tahun;

        $filename = 'laporan-penjualan-' . strtolower($laporanData['bulan_nama']) . '-' . $tahun;

        if ($tipe === 'excel') {
            return Excel::download(new LaporanPenjualanExport($laporanData), $filename . '.xlsx');
        }

        if ($tipe === 'pdf') {
            $pdf = PDF::loadView('pdf.laporan_penjualan', ['data' => $laporanData]);
            return $pdf->download($filename . '.pdf');
        }

        return response()->json(['message' => 'Format file tidak dikenali'], 400);
    }

    public function downloadInvoice($id)
    {
        $pemesanan = Pemesanan::with(['details.produk', 'user'])->findOrFail($id);

        $pdf = Pdf::loadView('pdf.invoice', compact('pemesanan'))
            ->setPaper('A4', 'portrait');

        $filename = 'invoice-' . $pemesanan->id_pemesanan . '.pdf';

        return $pdf->download($filename);
    }

}
