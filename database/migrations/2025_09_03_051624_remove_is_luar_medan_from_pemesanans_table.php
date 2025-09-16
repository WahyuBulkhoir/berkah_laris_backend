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
        Schema::table('pemesanans', function (Blueprint $table) {
            $table->dropColumn('is_luar_medan');
        });
    }

    public function down()
    {
        Schema::table('pemesanans', function (Blueprint $table) {
            $table->boolean('is_luar_medan')->default(false);
        });
    }

};
