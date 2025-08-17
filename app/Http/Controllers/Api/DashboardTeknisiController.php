<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Servis;
use App\Models\User;
use Carbon\Carbon;
use DB;
use App\Exports\LaporanServisExport;
use Maatwebsite\Excel\Facades\Excel;
use PDF;

class DashboardTeknisiController extends Controller
{
    public function stats()
    {
        $totalPendapatan = Servis::where('payment_status', 'paid')->sum('total_biaya');
        $totalServis = Servis::count();

        $totalPelanggan = User::where('role_id', 2)
            ->whereHas('servis')
            ->count();

        $servisBaru = Servis::where('status_servis', 'Diproses')->count();

        $recentServis = Servis::with('user')->latest()->take(5)->get()->map(function ($s) {
            return [
                'id' => 'SERVIS-' . $s->id_servis,
                'customer' => $s->user->name,
                'status' => $s->status_servis,
                'statusColor' => $s->status_servis === 'Selesai' ? 'green' :
                    ($s->status_servis === 'Diproses' ? 'yellow' : 'blue'),
                'total' => 'Rp ' . number_format($s->total_biaya ?? 0, 0, ',', '.')
            ];
        });

        return response()->json([
            'total_pendapatan' => $totalPendapatan,
            'total_servis' => $totalServis,
            'total_pelanggan' => $totalPelanggan,
            'servis_baru' => $servisBaru,
            'recent_servis' => $recentServis
        ]);
    }

    public function monthlyService()
    {
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

        $monthly = Servis::selectRaw('MONTH(tanggal_servis) as bulan, SUM(total_biaya) as total')
            ->whereNotNull('tanggal_servis')
            ->whereYear('tanggal_servis', Carbon::now()->year)
            ->where('payment_status', 'paid')
            ->groupBy('bulan')
            ->orderBy('bulan')
            ->pluck('total', 'bulan');

        $max = $monthly->max() ?: 1;

        $result = [];
        for ($i = 1; $i <= 12; $i++) {
            $total = isset($monthly[$i]) ? (int) $monthly[$i] : 0;
            $result[] = [
                'name' => $bulanList[$i],
                'value' => $total,
                'height' => $total > 0 ? intval(($total / $max) * 100) : 0
            ];
        }

        return response()->json($result);
    }

    public function topPaymentMethods()
    {
        $year = now()->year;

        $data = Servis::select('payment_method', DB::raw('COUNT(*) as jumlah'))
            ->whereNotNull('payment_method')
            ->where('payment_status', 'paid')
            ->whereYear('tanggal_servis', $year)
            ->groupBy('payment_method')
            ->orderByDesc('jumlah')
            ->take(5)
            ->get()
            ->map(function ($item) {
                return [
                    'name' => strtoupper($item->payment_method),
                    'count' => $item->jumlah,
                ];
            });

        return response()->json($data);
    }

    public function laporanServis(Request $request)
    {
        $bulan = (int) $request->input('bulan');
        $tahun = (int) $request->input('tahun');

        $tanggalAwal = Carbon::create($tahun, $bulan, 1)->startOfMonth();
        $tanggalAkhir = Carbon::create($tahun, $bulan, 1)->endOfMonth();

        $harian = Servis::select(
            DB::raw('DAY(tanggal_servis) as day'),
            DB::raw('SUM(total_biaya) as total')
        )
            ->whereBetween('tanggal_servis', [$tanggalAwal, $tanggalAkhir])
            ->where('payment_status', 'paid')
            ->groupBy(DB::raw('DAY(tanggal_servis)'))
            ->orderBy('day')
            ->get();

        $totalPendapatan = Servis::whereBetween('tanggal_servis', [$tanggalAwal, $tanggalAkhir])
            ->where('payment_status', 'paid')
            ->sum('total_biaya');

        $totalPesanan = Servis::whereBetween('tanggal_servis', [$tanggalAwal, $tanggalAkhir])
            ->where('payment_status', 'paid')
            ->count();

        $totalPelanggan = User::where('role_id', 2)
            ->whereHas('servis', function ($query) use ($tanggalAwal, $tanggalAkhir) {
                $query->whereBetween('tanggal_servis', [$tanggalAwal, $tanggalAkhir])
                    ->where('payment_status', 'paid');
            })
            ->count();

        $topMethods = Servis::select('payment_method', DB::raw('COUNT(*) as count'))
            ->whereBetween('tanggal_servis', [$tanggalAwal, $tanggalAkhir])
            ->where('payment_status', 'paid')
            ->groupBy('payment_method')
            ->get()
            ->map(function ($item) use ($totalPesanan) {
                return [
                    'name' => $item->payment_method ?? 'Tidak diketahui',
                    'count' => $item->count,
                    'percentage' => round(($item->count / max($totalPesanan, 1)) * 100, 1),
                ];
            });

        $topService = Servis::whereBetween('tanggal_servis', [$tanggalAwal, $tanggalAkhir])
            ->where('payment_status', 'paid')
            ->orderByDesc('tanggal_servis')
            ->limit(5)
            ->get()
            ->map(function ($item) {
                return [
                    'name' => $item->tipe_barang,
                    'sold' => 1,
                    'price' => 'Rp ' . number_format($item->total_biaya, 0, ',', '.'),
                    'total' => $item->total_biaya,
                ];
            });

        Carbon::setLocale('id');
        return response()->json([
            'bulan_nama' => Carbon::createFromDate($tahun, $bulan)->translatedFormat('F'),
            'tahun' => $tahun,
            'total_pendapatan' => $totalPendapatan,
            'total_pesanan' => $totalPesanan,
            'total_pelanggan' => $totalPelanggan,
            'laba_rugi' => $totalPendapatan,
            'total_modal' => 0,
            'harian' => $harian,
            'top_products' => $topService,
            'top_methods' => $topMethods,
        ]);
    }

    public function downloadLaporanServis(Request $request)
    {
        $bulan = (int) $request->input('bulan');
        $tahun = (int) $request->input('tahun');
        $tipe = $request->input('tipe', 'pdf');

        $data = $this->laporanServis($request)->getData(true);

        if ($tipe === 'excel') {
            return Excel::download(new LaporanServisExport($data), 'laporan-servis-' . $bulan . '-' . $tahun . '.xlsx');
        } else {
            $pdf = PDF::loadView('pdf.laporan_servis', ['data' => $data]);
            return $pdf->download('laporan-servis-' . $bulan . '-' . $tahun . '.pdf');
        }
    }

    public function dailyService(Request $request)
    {
        $bulan = $request->input('bulan', now()->month);
        $tahun = $request->input('tahun', now()->year);

        $tanggalAwal = Carbon::create($tahun, $bulan, 1)->startOfMonth();
        $tanggalAkhir = Carbon::create($tahun, $bulan, 1)->endOfMonth();

        $daily = Servis::selectRaw('DAY(tanggal_servis) as day, SUM(total_biaya) as total')
            ->whereBetween('tanggal_servis', [$tanggalAwal, $tanggalAkhir])
            ->where('payment_status', 'paid')
            ->groupBy(DB::raw('DAY(tanggal_servis)'))
            ->orderBy('day')
            ->get();

        $max = $daily->max('total') ?: 1;

        $result = [];
        for ($i = 1; $i <= 31; $i++) {
            $found = $daily->firstWhere('day', $i);
            $total = $found ? $found->total : 0;
            $result[] = [
                'day' => $i,
                'total' => $total,
                'height' => $total > 0 ? intval(($total / $max) * 100) : 0,
            ];
        }

        return response()->json($result);
    }
}
