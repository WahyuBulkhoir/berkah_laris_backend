<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class PemesananDetail extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_detail';
    protected $table = 'pemesanan_details';

    protected $fillable = [
        'pemesanan_id',
        'produk_id',
        'quantity',
        'harga_satuan',
    ];

    public function pemesanan()
    {
        return $this->belongsTo(Pemesanan::class, 'pemesanan_id', 'id_pemesanan');
    }

    public function produk()
    {
        return $this->belongsTo(Produk::class, 'produk_id', 'id_produk');
    }
}
