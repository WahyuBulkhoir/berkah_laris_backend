<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('produks', function (Blueprint $table) {
            if (!Schema::hasColumn('produks', 'berat')) {
                $table->integer('berat')->default(1000)->after('stok');
                // default 1000 gram (1 kg)
            }
        });
    }

    public function down(): void
    {
        Schema::table('produks', function (Blueprint $table) {
            if (Schema::hasColumn('produks', 'berat')) {
                $table->dropColumn('berat');
            }
        });
    }
};
