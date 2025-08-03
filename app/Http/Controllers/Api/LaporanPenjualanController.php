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

        // Daftar nama bulan singkat (seperti monthlyService)
        $bulanList = [
            1 => 'Jan',
            2 => 'Feb',
            3 => 'Mar',
            4 => 'Apr',
            5 => 'Mei',
            6 => 'Jun',
            7 => 'Jul',
            8 => 'Agu',
            9 => 'Sep',
            10 => 'Okt',
            11 => 'Nov',
            12 => 'Des'
        ];

        $data = Pemesanan::select(
            DB::raw('MONTH(tgl_pemesanan) as bulan'),
            DB::raw('SUM(total) as total_penjualan')
        )
            ->whereYear('tgl_pemesanan', $year)
            ->where('payment_status', 'paid')
            ->groupBy(DB::raw('MONTH(tgl_pemesanan)'))
            ->orderBy(DB::raw('MONTH(tgl_pemesanan)'))
            ->get()
            ->keyBy('bulan');

        // Format hasil: 12 bulan tetap muncul
        $result = [];
        for ($i = 1; $i <= 12; $i++) {
            $total = isset($data[$i]) ? (int) $data[$i]->total_penjualan : 0;

            $result[] = [
                'bulan' => $i,
                'nama_bulan' => $bulanList[$i], // Sama seperti monthlyService
                'total_penjualan' => $total
            ];
        }

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
