<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class BarangMasuk extends Model
{
    use HasFactory;

    protected $table = 'barang_masuk';
    protected $primaryKey = 'id_barang_masuk';
    protected $fillable = ['produk_id', 'jumlah', 'tanggal', 'keterangan']; // ✅ produk_id

    public function produk()
    {
        return $this->belongsTo(Produk::class, 'produk_id', 'id_produk'); // ✅ foreign key produk_id → id_produk
    }
}

