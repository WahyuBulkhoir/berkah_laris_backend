<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use Illuminate\Foundation\Auth\EmailVerificationRequest;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\MidtransCallbackController;
use App\Http\Controllers\Api\ProdukController;
use App\Http\Controllers\Api\KategoriController;
use App\Http\Controllers\Api\ContactController;
use App\Http\Controllers\Api\PasswordController;
use App\Http\Controllers\Api\ServisController;
use App\Http\Controllers\Api\KeranjangController;
use App\Http\Controllers\Api\PemesananController;
use App\Http\Controllers\Api\LaporanPenjualanController;
use App\Http\Controllers\Api\DashboardController;
use App\Http\Controllers\Api\DashboardTeknisiController;

/*
|--------------------------------------------------------------------------
| Public Routes
|--------------------------------------------------------------------------
*/

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::post('/midtrans/callback', [MidtransCallbackController::class, 'handle']);

// Email verification
Route::get('/email/verify/{id}/{hash}', [AuthController::class, 'verify'])
    ->middleware(['signed'])
    ->name('verification.verify');

Route::post('/email/resend', [AuthController::class, 'resendVerification'])
    ->middleware('auth:api');

Route::post('/email/verification-notification', function (Request $request) {
    $request->user()->sendEmailVerificationNotification();
    return response()->json(['message' => 'Verification link sent!']);
})->middleware('auth:api');

//Lupa Password
Route::post('/forgot-password', [PasswordController::class, 'sendResetLinkEmail']);
Route::post('/reset-password', [PasswordController::class, 'resetPassword']);

/*
|--------------------------------------------------------------------------
| Authenticated Routes (Sanctum Protected)
|--------------------------------------------------------------------------
*/

Route::middleware('auth:sanctum')->group(function () {

    // Auth
    Route::post('/logout', [AuthController::class, 'logout']);

    // Produk & Kategori
    Route::apiResource('produk', ProdukController::class);
    Route::get('/produk-all', [ProdukController::class, 'all']);
    Route::apiResource('kategori', KategoriController::class);

    // Servis
    Route::put('/servis/{id}/status-biaya', [ServisController::class, 'updateStatusBiaya']);
    Route::get('/servis/{id}/snap', [ServisController::class, 'getSnapToken']);
    Route::get('/servis/riwayat', [ServisController::class, 'userServis']);
    Route::apiResource('servis', ServisController::class);

    // Keranjang
    Route::post('/keranjang/hapus-massal', [KeranjangController::class, 'hapusMassal']);
    Route::apiResource('keranjang', KeranjangController::class);

    // Pemesanan
    Route::post('/pemesanan/batal-checkout', [PemesananController::class, 'batalCheckout']);
    Route::get('/pemesanan/{id}/snap-token', [PemesananController::class, 'getSnapToken']);
    Route::get('/pemesanan/riwayat-alamat', [PemesananController::class, 'alamatRiwayat']);
    Route::apiResource('pemesanan', PemesananController::class);

    //Laporan Penjualan
    Route::get('/laporan/laba-rugi/download', [PemesananController::class, 'downloadLaporan']);
    Route::get('/laporan/laba-rugi', [PemesananController::class, 'laporanLabaRugi']);
    Route::get('/laporan/penjualan', [LaporanPenjualanController::class, 'getLaporanHarian']);

    //Laporan Servis
    Route::get('/laporan/servis', [DashboardTeknisiController::class, 'laporanServis']);
    Route::get('/laporan/servis/download', [DashboardTeknisiController::class, 'downloadLaporanServis']);

    //Dashboard Admin
    Route::get('/dashboard/stats', [DashboardController::class, 'stats']);
    Route::get('/dashboard/top-products', [DashboardController::class, 'topProducts']);
    Route::get('/dashboard/recent-orders', [DashboardController::class, 'recentOrders']);
    Route::get('/dashboard/low-stock-products', [DashboardController::class, 'lowStockProducts']);

    // Dashboard Teknisi
    Route::get('/dashboard/teknisi', [DashboardTeknisiController::class, 'stats']);
    Route::get('/dashboard/teknisi/monthly', [DashboardTeknisiController::class, 'monthlyService']);
    Route::get('/dashboard/teknisi/top-payment-methods', [DashboardTeknisiController::class, 'topPaymentMethods']);
    Route::get('/dashboard/servis/daily', [DashboardTeknisiController::class, 'dailyService']);

    // Contact
    Route::post('/kontak/kirim', [ContactController::class, 'submit']);

    // User Info
    Route::get('/user/profile-info', function (Request $request) {
        $user = $request->user();
        return response()->json([
            'nama_penerima' => $user->name,
            'no_hp' => $user->no_hp,
            'alamat' => $user->alamat,
        ]);
    });
});