<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Pemesanan;
use App\Models\Servis;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;

class MidtransCallbackController extends Controller
{
    public function handle(Request $request)
    {
        $payload = $request->all();
        Log::info('Midtrans Callback Payload:', $payload);

        $serverKey = config('services.midtrans.server_key');
        $orderId = $payload['order_id'];
        $statusCode = $payload['status_code'];
        $grossAmount = (string) $payload['gross_amount'];

        $expectedSignature = hash('sha512', $orderId . $statusCode . $grossAmount . $serverKey);

        if ($expectedSignature !== $payload['signature_key']) {
            Log::warning('Signature tidak valid!');
            return response()->json(['message' => 'Invalid signature'], 403);
        }

        $transactionStatus = $payload['transaction_status'];
        $paymentType = $payload['payment_type'] ?? null;

        $paymentStatus = match ($transactionStatus) {
            'capture', 'settlement' => 'paid',
            'pending' => 'unpaid',
            'deny', 'expire', 'cancel' => 'failed',
            default => 'unpaid'
        };

        // CALLBACK UNTUK SERVIS
        if (str_starts_with($orderId, 'SERVIS-')) {
            $id_servis = (int) str_replace('SERVIS-', '', $orderId);
            $servis = Servis::find($id_servis);

            if (!$servis) {
                Log::error("Servis dengan order_id $orderId tidak ditemukan");
                return response()->json(['message' => 'Servis not found'], 404);
            }

            $servis->update([
                'payment_status' => $paymentStatus,
                'payment_method' => $paymentType,
            ]);

            Log::info("Servis #{$servis->id_servis} diperbarui menjadi $paymentStatus");

            return response()->json(['message' => 'Servis callback processed'], 200);
        }

        // CALLBACK UNTUK PEMESANAN
        $pemesanan = Pemesanan::with('details.produk')->where('midtrans_order_id', $orderId)->first();

        if (!$pemesanan) {
            Log::error("Pemesanan dengan order_id $orderId tidak ditemukan");
            return response()->json(['message' => 'Order not found'], 404);
        }

        $previousPaymentStatus = $pemesanan->payment_status;

        $pemesanan->update([
            'payment_status' => $paymentStatus,
            'payment_method' => $paymentType,
            'status_pesanan' => $paymentStatus === 'paid' ? 'Pesanan Diproses' : 'Pesanan Dibuat',
        ]);

        Log::info("Status pemesanan $orderId diperbarui menjadi $paymentStatus dengan metode $paymentType");

        if ($paymentStatus === 'paid' && $previousPaymentStatus !== 'paid') {
            DB::beginTransaction();
            try {
                foreach ($pemesanan->details as $detail) {
                    $produk = $detail->produk;
                    if ($produk && $produk->stok >= $detail->quantity) {
                        $produk->stok -= $detail->quantity;
                        $produk->save();

                        Log::info("Stok produk '{$produk->nama_produk}' dikurangi sebanyak {$detail->quantity}");
                    } else {
                        Log::warning("Stok tidak mencukupi untuk produk ID {$produk->id_produk}");
                    }
                }
                DB::commit();
            } catch (\Throwable $e) {
                DB::rollBack();
                Log::error("Gagal mengurangi stok produk: " . $e->getMessage());
            }
        }

        return response()->json(['message' => 'Callback processed'], 200);
    }

    private function mapMidtransStatus($status, $paymentType = null, $fraudStatus = null)
    {
        if ($status === 'capture' && $paymentType === 'credit_card') {
            return $fraudStatus === 'challenge' ? 'challenge' : 'paid';
        }

        return match ($status) {
            'settlement' => 'paid',
            'pending' => 'pending',
            'deny', 'expire', 'cancel' => 'failed',
            default => 'unknown',
        };
    }

    private function mapToOrderStatus($paymentStatus)
    {
        return match ($paymentStatus) {
            'paid' => 'Pesanan Diproses',
            'pending' => 'Pesanan Dibuat',
            'failed' => 'Dibatalkan',
            'challenge' => 'Pesanan Dibuat',
            default => 'Pesanan Dibuat',
        };
    }
}
