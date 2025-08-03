<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::table('servis', function (Blueprint $table) {
            $table->unsignedBigInteger('total_biaya')->nullable()->after('status_servis');
            $table->enum('payment_status', ['unpaid', 'paid'])->default('unpaid')->after('total_biaya');
        });
    }

    public function down()
    {
        Schema::table('servis', function (Blueprint $table) {
            $table->dropColumn(['total_biaya', 'payment_status']);
        });
    }
};
