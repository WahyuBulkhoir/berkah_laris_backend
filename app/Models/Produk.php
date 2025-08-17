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
        'gambar_produk',
        'deskripsi'
    ];
    public function kategori()
    {
        return $this->belongsTo(Kategori::class, 'id_kategori');
    }
}
