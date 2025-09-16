<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Servis;
use App\Models\JenisKerusakan;
use Midtrans\Snap;
use Midtrans\Config;

class ServisController extends Controller
{
    public function index()
    {
        $servis = Servis::with('user')
            ->orderBy('tanggal_servis', 'desc')
            ->get();

        return response()->json([
            'message' => 'Daftar servis berhasil diambil',
            'data' => $servis
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'tipe_barang' => 'required|string',
            'kerusakan_id' => 'required|exists:jenis_kerusakan,id_kerusakan', // ✅ arahkan ke PK asli
            'ket_tambahan' => 'nullable|string',
            'tanggal_servis' => 'required|date',
            'opsi_pelanggan' => 'required|in:setuju,hubungi,jual',
        ]);

        $user = $request->user();

        $adaServis = Servis::where('user_id', $user->id_user)
            ->where('status_servis', 'Diproses')
            ->exists();

        if ($adaServis) {
            return response()->json([
                'message' => 'Anda sudah mengajukan servis. Tunggu sampai statusnya "Diterima" sebelum mengajukan lagi.'
            ], 403);
        }

        $jenisKerusakan = JenisKerusakan::findOrFail($validated['kerusakan_id']);

        $servis = Servis::create([
            'user_id' => $user->id_user,
            'tipe_barang' => $validated['tipe_barang'],
            'kerusakan_id' => $jenisKerusakan->id_kerusakan,
            'kerusakan' => $jenisKerusakan->nama_kerusakan, // simpan nama untuk history
            'estimasi_biaya' => $jenisKerusakan->estimasi_biaya,
            'ket_tambahan' => $validated['ket_tambahan'] ?? null,
            'tanggal_servis' => $validated['tanggal_servis'],
            'opsi_pelanggan' => $validated['opsi_pelanggan'],
            'status_servis' => 'Diproses'
        ]);

        return response()->json([
            'message' => 'Servis berhasil diajukan',
            'data' => $servis
        ], 201);
    }

    public function show($id_servis)
    {
        $servis = Servis::with('user')->findOrFail($id_servis);

        return response()->json([
            'message' => 'Detail servis berhasil diambil',
            'data' => $servis
        ]);
    }

    public function update(Request $request, $id)
    {
        $servis = Servis::findOrFail($id);

        $validated = $request->validate([
            'status_servis' => 'in:Diproses,Diterima,Dalam Perbaikan,Selesai',
            'kerusakan' => 'nullable|string',
            'ket_tambahan' => 'nullable|string',
            'total_biaya' => 'nullable|numeric|min:0',
        ]);

        $servis->update($validated);

        return response()->json([
            'message' => 'Data servis berhasil diupdate',
            'data' => $servis
        ]);
    }

    public function updateStatusBiaya(Request $request, $id)
    {
        $request->validate([
            'status_servis' => 'required|string',
            'total_biaya' => 'nullable|numeric|min:0',
        ]);

        $servis = Servis::findOrFail($id);
        $servis->status_servis = $request->status_servis;

        if ($request->status_servis === 'Selesai') {
            $servis->total_biaya = $request->total_biaya;
            $servis->payment_status = 'unpaid';
        }

        $servis->save();

        return response()->json([
            'message' => 'Status dan biaya servis diperbarui.',
            'data' => $servis
        ]);
    }

    public function destroy($id_servis)
    {
        $servis = Servis::findOrFail($id_servis);
        $servis->delete();
        return response()->json(['message' => 'Servis deleted']);
    }

    public function userServis(Request $request)
    {
        $user = $request->user();

        $servis = Servis::where('user_id', $user->id_user)
            ->orderBy('tanggal_servis', 'desc')
            ->get();

        return response()->json([
            'message' => 'Daftar servis user berhasil diambil',
            'data' => $servis
        ]);
    }

    public function getSnapToken($id_servis)
    {
        $servis = Servis::with('user')->findOrFail($id_servis);

        if ($servis->payment_status === 'paid') {
            return response()->json(['message' => 'Servis sudah dibayar'], 400);
        }

        Config::$serverKey = config('services.midtrans.server_key');
        Config::$isProduction = false;
        Config::$isSanitized = true;
        Config::$is3ds = true;

        $orderId = 'SERVIS-' . $servis->id_servis . '-' . uniqid();

        $params = [
            'transaction_details' => [
                'order_id' => $orderId,
                'gross_amount' => (int) $servis->total_biaya,
            ],
            'customer_details' => [
                'first_name' => $servis->user->nama,
                'email' => $servis->user->email,
            ],
        ];

        $snapToken = Snap::getSnapToken($params);

        $servis->update(['midtrans_order_id' => $orderId]);

        return response()->json([
            'token' => $snapToken,
            'order_id' => $orderId,
        ]);
    }

    public function updateOpsiPelanggan(Request $request, $id_servis)
    {
        $validated = $request->validate([
            'opsi_pelanggan' => 'required|in:setuju,hubungi,jual',
        ]);

        $servis = Servis::findOrFail($id_servis);

        $servis->opsi_pelanggan = $validated['opsi_pelanggan'];
        $servis->save();

        return response()->json([
            'message' => 'Opsi pelanggan berhasil diperbarui',
            'data' => $servis
        ]);
    }
}
