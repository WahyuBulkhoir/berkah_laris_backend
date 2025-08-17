<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('servis', function (Blueprint $table) {
            $table->id('id_servis');
            $table->foreignId('user_id')->constrained('users','id_user')->onDelete('cascade');
            $table->string('tipe_barang');
            $table->text('kerusakan');
            $table->text('ket_tambahan')->nullable();
            $table->date('tanggal_servis');
            $table->enum('status_servis', ['Diproses', 'Diterima', 'Dalam Perbaikan', 'Selesai'])->default('Diproses');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('servis');
    }
};
