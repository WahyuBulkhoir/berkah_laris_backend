<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Servis extends Model
{
    protected $primaryKey = 'id_servis';
    protected $fillable = [
        'user_id',
        'tipe_barang',
        'kerusakan',
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
}
