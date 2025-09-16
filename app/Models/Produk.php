<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Produk extends Model
{
    protected $primaryKey = 'id_produk';
    protected $fillable = [
        'id_kategori',
        'nama_produk',
        'sku',
        'harga',
        'modal',
        'stok',
        'berat',
        'gambar_produk',
        'deskripsi',
        'deskripsi_minus',
    ];
    public function kategori()
    {
        return $this->belongsTo(Kategori::class, 'id_kategori', 'id_kategori');
    }
}
