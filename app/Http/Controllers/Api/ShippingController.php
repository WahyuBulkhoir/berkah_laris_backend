<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class ShippingController extends Controller
{
    private string $apiKey;
    private string $baseUrl;

    public function __construct()
    {
        $this->apiKey = env('RAJAONGKIR_API_KEY');
        $this->baseUrl = env('RAJAONGKIR_BASE_URL', 'https://api.rajaongkir.com/starter');
    }

    public function provinces()
    {
        try {
            $res = Http::withHeaders(['key' => $this->apiKey])->timeout(10)->get($this->baseUrl . '/province');

            if (!$res->successful()) {
                Log::error('RajaOngkir provinces failed', ['status' => $res->status(), 'body' => $res->body()]);
                return response()->json(['message' => 'Gagal memuat provinsi dari RajaOngkir'], 502);
            }

            $results = $res->json('rajaongkir.results', []);
            return response()->json($results);
        } catch (\Throwable $e) {
            Log::error('RajaOngkir provinces exception', ['message' => $e->getMessage()]);
            return response()->json(['message' => 'Exception saat memuat provinsi'], 500);
        }
    }

    public function cities(Request $request)
    {
        $request->validate(['province_id' => 'required']);
        try {
            $res = Http::withHeaders(['key' => $this->apiKey])->timeout(10)
                ->get($this->baseUrl . '/city', ['province' => $request->province_id]);

            if (!$res->successful()) {
                Log::error('RajaOngkir cities failed', ['status' => $res->status(), 'body' => $res->body(), 'province_id' => $request->province_id]);
                return response()->json(['message' => 'Gagal memuat kota dari RajaOngkir'], 502);
            }

            $results = $res->json('rajaongkir.results', []);
            return response()->json($results);
        } catch (\Throwable $e) {
            Log::error('RajaOngkir cities exception', ['message' => $e->getMessage(), 'province_id' => $request->province_id]);
            return response()->json(['message' => 'Exception saat memuat kota'], 500);
        }
    }

    public function costs(Request $request)
    {
        $request->validate([
            'destination_city_id' => 'required|integer',
            'weight' => 'required|integer|min:1',
            'couriers' => 'required|string'
        ]);

        $origin = (int) env('STORE_ORIGIN_CITY_ID', 0);
        if ($origin <= 0) {
            Log::warning('STORE_ORIGIN_CITY_ID belum diset atau nol.');
            return response()->json(['message' => 'Origin city belum dikonfigurasi'], 500);
        }

        $couriers = explode(':', $request->couriers);
        $results = [];

        try {
            foreach ($couriers as $courier) {
                $res = Http::withHeaders([
                    'key' => $this->apiKey,
                    'Content-Type' => 'application/x-www-form-urlencoded'
                ])->timeout(10)
                    ->asForm()
                    ->post($this->baseUrl . '/cost', [
                        'origin' => $origin,
                        'destination' => $request->destination_city_id,
                        'weight' => $request->weight,
                        'courier' => $courier
                    ]);

                if (!$res->successful()) {
                    Log::error('RajaOngkir cost failed', ['courier' => $courier, 'status' => $res->status(), 'body' => $res->body()]);
                    continue; // coba courier berikutnya
                }

                $rajaRes = $res->json('rajaongkir.results', []);
                $first = $rajaRes[0] ?? null;
                if ($first && isset($first['costs'])) {
                    foreach ($first['costs'] as $c) {
                        $results[] = [
                            'courier' => strtoupper($first['code'] ?? $courier),
                            'service' => $c['service'] ?? '',
                            'description' => $c['description'] ?? '',
                            'etd' => $c['cost'][0]['etd'] ?? '',
                            'value' => $c['cost'][0]['value'] ?? 0
                        ];
                    }
                }
            }

            return response()->json($results);
        } catch (\Throwable $e) {
            Log::error('RajaOngkir cost exception', ['message' => $e->getMessage()]);
            return response()->json(['message' => 'Exception saat mengecek ongkir'], 500);
        }
    }
}
