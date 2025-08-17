<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Pemesanan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class LaporanPenjualanController extends Controller
{
    public function getLaporanHarian(Request $request)
    {
        $year = $request->input('tahun', now()->year);

        $data = Pemesanan::select(
            DB::raw('MONTH(tgl_pemesanan) as bulan'),
            DB::raw('SUM(total) as total_penjualan')
        )
            ->whereYear('tgl_pemesanan', $year)
            ->where('payment_status', 'paid')
            ->groupBy(DB::raw('MONTH(tgl_pemesanan)'))
            ->orderBy(DB::raw('MONTH(tgl_pemesanan)'))
            ->get();

        // Format hasil: buat 12 bulan, isi 0 kalau tidak ada data
        $result = collect(range(1, 12))->map(function ($bulan) use ($data) {
            $penjualan = $data->firstWhere('bulan', $bulan);
            return [
                'bulan' => $bulan,
                'nama_bulan' => Carbon::create()->locale('id')->month($bulan)->translatedFormat('M'),
                'total_penjualan' => $penjualan ? (int) $penjualan->total_penjualan : 0
            ];
        });

        return response()->json([
            'tahun' => $year,
            'data' => $result
        ]);
    }

    public function getTotalPesananTahunan(Request $request)
    {
        $tahun = $request->input('tahun', now()->year);

        $totalPesanan = Pemesanan::whereYear('tgl_pemesanan', $tahun)
            ->where('status_pesanan', 'Selesai')
            ->where('payment_status', 'paid')
            ->count();

        return response()->json([
            'tahun' => $tahun,
            'total_pesanan_selesai' => $totalPesanan
        ]);
    }

}
