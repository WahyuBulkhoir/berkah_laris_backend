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
        Schema::create('barang_masuk', function (Blueprint $table) {
            $table->bigIncrements('id_barang_masuk');
            $table->unsignedBigInteger('produk_id');
            $table->integer('jumlah')->default(0);
            $table->date('tanggal');
            $table->text('keterangan')->nullable();
            $table->timestamps();

            // Relasi ke produk
            $table->foreign('produk_id')
                ->references('id_produk')->on('produks')
                ->onDelete('cascade');
        });
    }

    /**
     * Rollback migration.
     */
    public function down(): void
    {
        Schema::dropIfExists('barang_masuk');
    }
};
