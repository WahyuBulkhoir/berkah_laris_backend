<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Buat admin
        User::create([
            'email' => 'admin@example.com',
            'username' => 'admin',
            'name' => 'Admin',
            'no_hp' => '08123456789',
            'alamat' => 'Admin Address',
            'password' => Hash::make('admin123'),
            'role_id' => 1,
        ]);

        // Contoh user lain
        User::create([
            'email' => 'teknisi@example.com',
            'username' => 'teknisi',
            'name' => 'Teknisi',
            'no_hp' => '082267773165',
            'alamat' => 'Teknisi Address',
            'password' => Hash::make('teknisi123'),
            'role_id' => 3,
        ]);
    }
}
