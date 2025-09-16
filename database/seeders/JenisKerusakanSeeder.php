<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\JenisKerusakan;

class JenisKerusakanSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $data = [
            ['nama_kerusakan' => 'Layar Retak / Pecah', 'estimasi_biaya' => 500000],
            ['nama_kerusakan' => 'Baterai Drop / Rusak', 'estimasi_biaya' => 250000],
            ['nama_kerusakan' => 'Mesin / IC Bermasalah', 'estimasi_biaya' => 750000],
            ['nama_kerusakan' => 'Speaker Tidak Berfungsi', 'estimasi_biaya' => 150000],
            ['nama_kerusakan' => 'Software / OS Error', 'estimasi_biaya' => 200000],
            ['nama_kerusakan' => 'Keyboard Rusak', 'estimasi_biaya' => 300000],
            ['nama_kerusakan' => 'Port Charger Bermasalah', 'estimasi_biaya' => 180000],
        ];

        foreach ($data as $item) {
            JenisKerusakan::firstOrCreate(['nama_kerusakan' => $item['nama_kerusakan']], $item);
        }
    }
}
