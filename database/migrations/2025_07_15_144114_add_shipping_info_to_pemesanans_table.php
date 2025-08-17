<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('pemesanans', function (Blueprint $table) {
            $table->string('nama_penerima')->nullable()->after('user_id');
            $table->string('no_hp')->nullable()->after('nama_penerima');
            $table->text('alamat')->nullable()->after('no_hp');
        });
    }

    public function down(): void
    {
        Schema::table('pemesanans', function (Blueprint $table) {
            $table->dropColumn(['nama_penerima', 'no_hp', 'alamat']);
        });
    }
};
