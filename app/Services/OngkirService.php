<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class OngkirService
{
    private string $baseUrl;
    private string $apiKey;
    private int $originCityId;

    public function __construct()
    {
        $this->baseUrl = config('services.rajaongkir.base_url', env('RAJAONGKIR_BASE_URL'));
        $this->apiKey = env('RAJAONGKIR_API_KEY');
        $this->originCityId = (int) env('STORE_ORIGIN_CITY_ID', 0);
    }

    public function provinces(): array
    {
        $res = Http::withHeaders(['key' => $this->apiKey])
            ->get($this->baseUrl . '/province')
            ->json();
        return $res['rajaongkir']['results'] ?? [];
    }

    public function cities($provinceId): array
    {
        $res = Http::withHeaders(['key' => $this->apiKey])
            ->get($this->baseUrl . '/city', ['province' => $provinceId])
            ->json();
        return $res['rajaongkir']['results'] ?? [];
    }

    // Jika pakai PRO dan ingin kecamatan:
    public function subdistricts($cityId): array
    {
        $res = Http::withHeaders(['key' => $this->apiKey])
            ->get($this->baseUrl . '/subdistrict', ['city' => $cityId])
            ->json();
        return $res['rajaongkir']['results'] ?? [];
    }

    public function costs(array $couriers, int $destinationCityId, int $weightGram): array
    {
        $results = [];
        foreach ($couriers as $courier) {
            $res = Http::withHeaders(['key' => $this->apiKey])
                ->asForm()
                ->post($this->baseUrl . '/cost', [
                    'origin' => $this->originCityId,
                    'originType' => 'city',
                    'destination' => $destinationCityId,
                    'destinationType' => 'city',
                    'weight' => max(1, $weightGram),
                    'courier' => $courier
                ])->json();

            $costs = $res['rajaongkir']['results'][0]['costs'] ?? [];
            $results[] = [
                'courier' => $courier,
                'services' => array_map(function ($c) {
                    return [
                        'service' => $c['service'],
                        'description' => $c['description'] ?? '',
                        'etd' => $c['cost'][0]['etd'] ?? null,
                        'value' => $c['cost'][0]['value'] ?? 0,
                    ];
                }, $costs)
            ];
        }
        return $results;
    }
}
