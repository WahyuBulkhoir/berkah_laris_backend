<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Database\Seeder;

User::create([
    'email' => 'admin@example.com',
    'username' => 'admin',
    'name' => 'Admin',
    'no_hp' => '08123456789',
    'alamat' => 'Admin Address',
    'password' => Hash::make('admin123'),
    'role_id' => 1,
]);

User::create([
    'email' => 'teknisi@example.com',
    'username' => 'teknisi',
    'name' => 'Teknisi',
    'no_hp' => '080987654321',
    'alamat' => 'Teknisi Address',
    'password' => Hash::make('teknisi123'),
    'role_id' => 3,
]);

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();

        User::factory()->create([
            'name' => 'Test User',
            'email' => 'test@example.com',
        ]);

        $this->call([
            JenisKerusakanSeeder::class,
        ]);
    }
}
