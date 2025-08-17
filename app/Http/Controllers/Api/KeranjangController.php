<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Keranjang;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class KeranjangController extends Controller
{
    public function index()
    {
        $user = Auth::user();
        $keranjang = Keranjang::with('produk.kategori')
            ->where('user_id', $user->id_user)
            ->get();

        return response()->json($keranjang);
    }

    public function store(Request $request)
    {
        $request->validate([
            'produk_id' => 'required|exists:produks,id_produk',
            'quantity' => 'required|integer|min:1',
        ]);

        $user = Auth::user();
        $produkId = $request->produk_id;
        $quantityBaru = $request->quantity;
        $produk = \App\Models\Produk::findOrFail($produkId);
        $keranjang = Keranjang::where('user_id', $user->id_user)
            ->where('produk_id', $produkId)
            ->first();
        $jumlahSekarang = $keranjang ? $keranjang->quantity : 0;
        $jumlahTotal = $jumlahSekarang + $quantityBaru;

        if ($jumlahTotal > $produk->stok) {
            return response()->json([
                'message' => 'Jumlah yang dimasukkan melebihi stok tersedia.',
                'stok_tersedia' => $produk->stok,
                'jumlah_diminta' => $jumlahTotal
            ], 422);
        }

        if ($keranjang) {
            $keranjang->quantity = $jumlahTotal;
            $keranjang->save();
        } else {
            $keranjang = Keranjang::create([
                'user_id' => $user->id_user,
                'produk_id' => $produkId,
                'quantity' => $quantityBaru,
            ]);
        }

        $keranjang->load('produk.kategori');

        return response()->json([
            'message' => 'Produk berhasil ditambahkan ke keranjang',
            'data' => $keranjang
        ], 201);
    }

    public function update(Request $request, $id_keranjang)
    {
        $request->validate([
            'quantity' => 'required|integer|min:1',
        ]);

        $keranjang = Keranjang::where('id_keranjang', $id_keranjang)
            ->where('user_id', Auth::user()->id_user)
            ->firstOrFail();

        $keranjang->update([
            'quantity' => $request->quantity,
        ]);

        $keranjang->load('produk.kategori');

        return response()->json([
            'message' => 'Keranjang berhasil diperbarui',
            'data' => $keranjang
        ]);
    }

    public function destroy($id_keranjang)
    {
        $keranjang = Keranjang::where('id_keranjang', $id_keranjang)
            ->where('user_id', Auth::user()->id_user)
            ->firstOrFail();

        $keranjang->delete();

        return response()->json([
            'message' => 'Produk berhasil dihapus dari keranjang'
        ]);
    }

    public function hapusMassal(Request $request)
    {
        \Log::info('Hapus massal dipanggil oleh user id:', ['id' => auth()->id()]);
        \Log::info('Request hapus massal:', $request->all());

        $request->validate([
            'id_keranjang' => 'required|array|min:1',
            'id_keranjang.*' => 'integer'
        ]);

        Keranjang::where('user_id', auth()->id())
            ->whereIn('id_keranjang', $request->id_keranjang)
            ->delete();

        return response()->json(['message' => 'Item berhasil dihapus.']);
    }

}
