<?php

namespace App\Http\Controllers\Api;

use App\Models\BarangMasuk;
use App\Models\Produk;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class BarangMasukController extends Controller
{
    public function index()
    {
        $data = BarangMasuk::with('produk')->orderBy('tanggal', 'desc')->paginate(10);
        return response()->json($data);
    }

    public function store(Request $request)
    {
        $request->validate([
            'produk_id' => 'required|exists:produks,id_produk', // ✅ tabel produks
            'jumlah' => 'required|integer|min:1',
            'tanggal' => 'required|date',
        ]);

        // Simpan barang masuk
        $barangMasuk = BarangMasuk::create([
            'produk_id' => $request->produk_id,  // ✅ konsisten produk_id
            'jumlah' => $request->jumlah,
            'tanggal' => $request->tanggal,
            'keterangan' => $request->keterangan
        ]);

        // Update stok di tabel produk
        $produk = Produk::findOrFail($request->produk_id);
        $produk->stok += $request->jumlah;
        $produk->save();

        return response()->json([
            'message' => 'Barang masuk berhasil dicatat',
            'data' => $barangMasuk
        ], 201);
    }

}
