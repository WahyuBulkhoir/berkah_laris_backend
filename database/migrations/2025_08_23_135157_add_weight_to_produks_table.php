<?php

// database/migrations/xxxx_xx_xx_xxxxxx_add_berat_to_produks.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('produks', function (Blueprint $table) {
            $table->integer('berat')->default(0)->after('stok'); // gram
        });
    }
    public function down(): void
    {
        Schema::table('produks', function (Blueprint $table) {
            $table->dropColumn('berat');
        });
    }
};
