<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('pemesanans', function (Blueprint $table) {
            // alamat terstruktur
            $table->string('provinsi')->nullable()->after('alamat');
            $table->string('kota')->nullable()->after('provinsi');
            $table->string('kecamatan')->nullable()->after('kota');
            $table->string('kode_pos', 10)->nullable()->after('kecamatan');

            // data ongkir & pilihan kurir
            $table->string('kurir')->nullable()->after('total');       // contoh: 'jne'
            $table->string('layanan')->nullable()->after('kurir');     // contoh: 'REG'
            $table->integer('ongkir')->default(0)->after('layanan');
            $table->integer('berat_total')->default(0)->after('ongkir');

            // penanda untuk logika dalam/luar Medan
            $table->boolean('is_luar_medan')->default(false)->after('berat_total');
        });
    }

    public function down(): void
    {
        Schema::table('pemesanans', function (Blueprint $table) {
            $table->dropColumn([
                'provinsi',
                'kota',
                'kecamatan',
                'kode_pos',
                'kurir',
                'layanan',
                'ongkir',
                'berat_total',
                'is_luar_medan'
            ]);
        });
    }
};
