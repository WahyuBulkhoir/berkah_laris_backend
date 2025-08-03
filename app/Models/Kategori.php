<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Kategori extends Model
{
    protected $primaryKey = 'id_kategori';

    protected $fillable = [
        'nama_kategori',
        'tipe_produk'
    ];

    public function produks()
    {
        return $this->hasMany(Produk::class, 'id_kategori');
    }
}
