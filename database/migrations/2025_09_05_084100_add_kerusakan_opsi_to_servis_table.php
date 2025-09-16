<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('servis', function (Blueprint $table) {
            $table->unsignedBigInteger('kerusakan_id')->nullable()->after('user_id');
            $table->unsignedBigInteger('estimasi_biaya')->nullable()->after('kerusakan_id');
            $table->enum('opsi_pelanggan', ['setuju', 'hubungi', 'jual'])->default('setuju')->after('estimasi_biaya');

            $table->foreign('kerusakan_id')->references('id_kerusakan')->on('jenis_kerusakan')->onDelete('set null');
        });
    }

    public function down(): void
    {
        Schema::table('servis', function (Blueprint $table) {
            $table->dropForeign(['kerusakan_id']);
            $table->dropColumn(['kerusakan_id', 'estimasi_biaya', 'opsi_pelanggan']);
        });
    }
};
