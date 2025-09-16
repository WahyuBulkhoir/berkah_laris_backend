<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\JenisKerusakan;
use Illuminate\Http\Request;

class JenisKerusakanController extends Controller
{
    public function index()
    {
        return JenisKerusakan::all();
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'nama_kerusakan' => 'required|string',
            'estimasi_biaya' => 'nullable|numeric'
        ]);

        return JenisKerusakan::create($data);
    }

    public function update(Request $request, $id)
    {
        $jenis = JenisKerusakan::findOrFail($id);
        $data = $request->validate([
            'nama_kerusakan' => 'required|string',
            'estimasi_biaya' => 'nullable|numeric'
        ]);
        $jenis->update($data);
        return $jenis;
    }

    public function destroy($id)
    {
        JenisKerusakan::findOrFail($id)->delete();
        return response()->json(['message' => 'Jenis kerusakan dihapus']);
    }
}
