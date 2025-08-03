<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Servis;
use Midtrans\Snap;
use Midtrans\Config;

class ServisController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $servis = Servis::with('user')->latest()->get();
        return response()->json([
            'message' => 'Daftar servis berhasil diambil',
            'data' => $servis
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'tipe_barang' => 'required|string',
            'kerusakan' => 'required|string',
            'ket_tambahan' => 'nullable|string',
            'tanggal_servis' => 'required|date',
        ]);

        $user = $request->user(); // Ambil dari token

        $adaServis = Servis::where('user_id', $user->id_user)
            ->where('status_servis', 'Diproses')
            ->exists();

        if ($adaServis) {
            return response()->json([
                'message' => 'Anda sudah mengajukan servis. Tunggu sampai statusnya "Diterima" sebelum mengajukan lagi.'
            ], 403);
        }

        $servis = Servis::create([
            ...$validated,
            'user_id' => $user->id_user,
            'status_servis' => 'Diproses'
        ]);

        return response()->json([
            'message' => 'Servis berhasil diajukan',
            'data' => $servis
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show($id_servis)
    {
        $servis = Servis::with('user')->findOrFail($id_servis);

        return response()->json([
            'message' => 'Detail servis berhasil diambil',
            'data' => $servis
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
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

    /**
     * Update status & biaya oleh admin.
     */
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

    /**
     * Remove the specified resource from storage.
     */
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
            ->orderByDesc('created_at')
            ->get();

        return response()->json([
            'message' => 'Daftar servis user berhasil diambil',
            'data' => $servis
        ]);
    }

    /**
     * Generate Snap Token untuk pembayaran servis.
     */
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

        $orderId = 'SERVIS-' . $servis->id_servis;

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
}
