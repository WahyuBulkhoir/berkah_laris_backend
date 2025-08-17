<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Produk;
use Illuminate\Support\Facades\Storage;

class ProdukController extends Controller
{
    public function index(Request $request)
    {
        $perPage = $request->input('per_page', 10);
        $search = $request->input('search');
        $kategori = $request->input('kategori');

        $query = Produk::with('kategori');

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('nama_produk', 'like', "%$search%")
                    ->orWhere('sku', 'like', "%$search%");
            });
        }

        if ($kategori) {
            $query->where('id_kategori', $kategori);
        }

        $produk = $query->orderBy('nama_produk', 'asc')->paginate($perPage);

        return response()->json($produk);
    }

    public function all()
    {
        $produk = Produk::with('kategori')
            ->orderBy('nama_produk', 'asc')
            ->get();

        return response()->json($produk);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id_kategori' => 'required|exists:kategoris,id_kategori',
            'nama_produk' => 'required|string|max:255',
            'sku' => 'required|string|unique:produks,sku',
            'harga' => 'required|numeric',
            'modal' => 'required|numeric|min:0',
            'stok' => 'required|integer',
            'gambar_produk' => 'nullable|image|max:1000',
            'deskripsi' => 'nullable|string',
        ]);

        if ($request->hasFile('gambar_produk')) {
            $file = $request->file('gambar_produk');
            $filename = time() . '_' . $file->getClientOriginalName();
            $file->storeAs('public/produk', $filename);
            $validated['gambar_produk'] = 'produk/' . $filename;
        }

        $produk = Produk::create($validated);

        return response()->json([
            'message' => 'Produk berhasil ditambahkan',
            'data' => $produk
        ], 201);
    }

    public function show($id_produk)
    {
        $produk = Produk::with('kategori')->where('id_produk', $id_produk)->firstOrFail();
        return response()->json($produk);
    }

    public function update(Request $request, $id_produk)
    {
        $produk = Produk::where('id_produk', $id_produk)->firstOrFail();

        $validated = $request->validate([
            'id_kategori' => 'sometimes|required|exists:kategoris,id_kategori',
            'nama_produk' => 'sometimes|required|string|max:255',
            'sku' => 'sometimes|required|string|unique:produks,sku,' . $produk->id_produk . ',id_produk',
            'harga' => 'sometimes|required|numeric',
            'modal' => 'sometimes|required|numeric|min:0',
            'stok' => 'sometimes|required|integer',
            'gambar_produk' => 'nullable|image|max:1000',
            'deskripsi' => 'nullable|string',
        ]);

        if ($request->hasFile('gambar_produk')) {
            if ($produk->gambar_produk && Storage::exists('public/' . $produk->gambar_produk)) {
                Storage::delete('public/' . $produk->gambar_produk);
            }

            $file = $request->file('gambar_produk');
            $filename = time() . '_' . $file->getClientOriginalName();
            $file->storeAs('public/produk', $filename);
            $validated['gambar_produk'] = 'produk/' . $filename;
        }

        $produk->update($validated);

        return response()->json([
            'message' => 'Produk berhasil diperbarui',
            'data' => $produk
        ]);
    }

    public function destroy($id_produk)
    {
        $produk = Produk::where('id_produk', $id_produk)->firstOrFail();

        if ($produk->gambar_produk && Storage::exists('public/' . $produk->gambar_produk)) {
            Storage::delete('public/' . $produk->gambar_produk);
        }

        $produk->delete();

        return response()->json([
            'message' => 'Produk berhasil dihapus'
        ]);
    }
}
