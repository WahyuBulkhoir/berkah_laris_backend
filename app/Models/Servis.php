<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Servis extends Model
{
    protected $primaryKey = 'id_servis';
    protected $fillable = [
        'user_id',
        'kerusakan_id',
        'tipe_barang',
        'kerusakan',
        'estimasi_biaya',
        'opsi_pelanggan',
        'ket_tambahan',
        'tanggal_servis',
        'status_servis',
        'total_biaya',
        'payment_status',
        'payment_method',
    ];
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'id_user');
    }
    public function jenisKerusakan()
    {
        return $this->belongsTo(JenisKerusakan::class, 'kerusakan_id', 'id_kerusakan');
    }
}
