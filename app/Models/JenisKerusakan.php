<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class JenisKerusakan extends Model
{
    protected $table = 'jenis_kerusakan';
    protected $primaryKey = 'id_kerusakan';
    protected $fillable = ['nama_kerusakan', 'estimasi_biaya'];

    public function servis()
    {
        return $this->hasMany(Servis::class, 'kerusakan_id', 'id_kerusakan');
    }
}
