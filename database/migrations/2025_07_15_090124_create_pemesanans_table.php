<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        // Tabel utama pemesanan
        Schema::create('pemesanans', function (Blueprint $table) {
            $table->id('id_pemesanan');
            $table->unsignedBigInteger('user_id');
            $table->dateTime('tgl_pemesanan')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->text('cat_opsional')->nullable();
            $table->enum('status_pesanan', [
                'Pesanan Dibuat',
                'Pesanan Diproses',
                'Diserahkan Kekurir',
                'Pesanan Dalam Perjalanan',
                'Pesanan Sampai',
                'Selesai'
            ])->default('Pesanan Dibuat');
            $table->string('midtrans_order_id')->nullable();
            $table->enum('payment_status', ['unpaid', 'paid', 'failed', 'expired'])->default('unpaid');
            $table->integer('total')->default(0);
            $table->timestamps();

            $table->foreign('user_id')->references('id_user')->on('users')->onDelete('cascade');
        });

        // Tabel detail pemesanan
        Schema::create('pemesanan_details', function (Blueprint $table) {
            $table->id('id_detail');
            $table->unsignedBigInteger('pemesanan_id');
            $table->unsignedBigInteger('produk_id');
            $table->integer('quantity');
            $table->integer('harga_satuan');
            $table->timestamps();

            $table->foreign('pemesanan_id')->references('id_pemesanan')->on('pemesanans')->onDelete('cascade');
            $table->foreign('produk_id')->references('id_produk')->on('produks')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pemesanan_details');
        Schema::dropIfExists('pemesanans');
    }
};
