<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Pemesanan extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_pemesanan';
    protected $table = 'pemesanans';

    protected $fillable = [
        'user_id',
        'tgl_pemesanan',
        'cat_opsional',
        'status_pesanan',
        'midtrans_order_id',
        'snap_token',
        'payment_status',
        'payment_method',
        'total',
        'nama_penerima',
        'no_hp',
        'alamat',
    ];

    protected $casts = [
        'tgl_pemesanan' => 'datetime',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'id_user');
    }

    public function produk()
    {
        return $this->belongsTo(Produk::class, 'produk_id', 'id_produk');
    }

    public function details()
    {
        return $this->hasMany(PemesananDetail::class, 'pemesanan_id', 'id_pemesanan');
    }
}
