<?php

use Illuminate\Foundation\Auth\EmailVerificationRequest;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\MidtransCallbackController;

Route::get('/email/verify/{id}/{hash}', [AuthController::class, 'verify'])
    ->name('verification.verify')
    ->middleware(['signed']);

Route::get('/', [App\Http\Controllers\Api\RajaOngkirController::class, 'index']);
Route::get('/cities/{provinceId}', [App\Http\Controllers\Api\RajaOngkirController::class, 'getCities']);
Route::get('/districts/{cityId}', [App\Http\Controllers\Api\RajaOngkirController::class, 'getDistricts']);
Route::post('/check-ongkir', [App\Http\Controllers\Api\RajaOngkirController::class, 'checkOngkir']);
