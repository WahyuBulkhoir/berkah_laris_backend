<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Pemesanan;
use App\Models\User;
use App\Models\Produk;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;
use DB;

class DashboardController extends Controller
{
    public function stats(Request $request)
    {
        $bulan = $request->input('bulan');
        $tahun = $request->input('tahun');

        $totalPenjualan = Pemesanan::whereYear('tgl_pemesanan', $tahun)
            ->where('payment_status', 'paid')
            ->sum('total');

        $totalPesanan = \App\Models\Pemesanan::whereYear('tgl_pemesanan', $tahun)
            ->where('payment_status', 'paid')
            ->count();
        $totalProduk = \App\Models\Produk::count();

        $totalPelanggan = \App\Models\User::where('role_id', 2)
            ->whereHas('pemesanan')
            ->count();

        $pesananBaru = \App\Models\Pemesanan::where('status_pesanan', 'Pesanan Dibuat')
            ->count();

        return response()->json([
            'total_penjualan' => $totalPenjualan,
            'total_produk' => $totalProduk,
            'total_pelanggan' => $totalPelanggan,
            'pesanan_baru' => $pesananBaru,
            'total_pesanan' => $totalPesanan,
        ]);
    }

    public function topProducts(Request $request)
    {
        $tahun = $request->input('tahun', now()->year);

        $data = DB::table('pemesanan_details')
            ->join('pemesanans', 'pemesanan_details.pemesanan_id', '=', 'pemesanans.id_pemesanan')
            ->join('produks', 'pemesanan_details.produk_id', '=', 'produks.id_produk')
            ->select(
                'produks.nama_produk as name',
                'produks.gambar_produk',
                DB::raw('SUM(pemesanan_details.quantity) as sold')
            )
            ->whereYear('pemesanans.tgl_pemesanan', $tahun)
            ->where('pemesanans.payment_status', 'paid')
            ->groupBy('produks.id_produk', 'produks.nama_produk', 'produks.gambar_produk')
            ->orderByDesc('sold')
            ->limit(5)
            ->get();

        $maxSold = $data->max('sold') ?: 1;

        $result = $data->map(function ($item, $index) use ($maxSold) {
            $colors = ['blue', 'green', 'red', 'blue', 'green'];
            $icons = [
                'fas fa-mobile-alt',
                'fas fa-headphones',
                'fas fa-laptop',
                'fas fa-camera',
                'fas fa-tv'
            ];

            $filename = str_replace('produk/', '', $item->gambar_produk);

            $gambarUrl = $item->gambar_produk && Storage::disk('public')->exists('produk/' . $filename)
                ? asset('storage/produk/' . $filename)
                : null;

            Log::info('Dashboard TopProduk Gambar URL', [
                'nama_produk' => $item->name,
                'gambar_produk' => $item->gambar_produk,
                'final_filename' => $filename,
                'url' => $gambarUrl,
                'file_exists' => Storage::disk('public')->exists('produk/' . $filename)
            ]);

            return [
                'name' => $item->name,
                'sold' => $item->sold,
                'gambar' => $gambarUrl,
                'percentage' => round(($item->sold / $maxSold) * 100),
                'icon' => $icons[$index % count($icons)],
                'color' => $colors[$index % count($colors)]
            ];
        });

        return response()->json([
            'tahun' => $tahun,
            'top_products' => $result
        ]);
    }

    public function recentOrders()
    {
        $orders = \App\Models\Pemesanan::select('midtrans_order_id', 'nama_penerima', 'status_pesanan', 'total')
            ->orderByDesc('tgl_pemesanan')
            ->limit(5)
            ->get();

        return response()->json([
            'data' => $orders
        ]);
    }

    public function lowStockProducts()
    {
        $produk = Produk::with('kategori')
            ->where('stok', '<', 5)
            ->orderBy('stok', 'asc')
            ->limit(5)
            ->get();

        return response()->json([
            'data' => $produk
        ]);
    }

}
