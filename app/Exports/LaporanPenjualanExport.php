<?php

namespace App\Exports;

use Illuminate\Contracts\View\View;
use Maatwebsite\Excel\Concerns\FromView;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithEvents;
use Maatwebsite\Excel\Events\AfterSheet;

class LaporanPenjualanExport implements FromView, ShouldAutoSize, WithEvents
{
    protected $data;
    protected $startColumn = 'B';

    public function __construct(array $data)
    {
        $this->data = $data;
    }

    public function view(): View
    {
        return view('exports.laporan_penjualan_excel', [
            'data' => $this->data
        ]);
    }

    public function registerEvents(): array
    {
        return [
            AfterSheet::class => function (AfterSheet $event) {
                $sheet = $event->sheet;
                $col = $this->startColumn;
                $col2 = chr(ord($col) + 1);
                $row = 1;

                // Judul
                $sheet->mergeCells("{$col}{$row}:{$col2}{$row}");
                $sheet->getStyle("{$col}{$row}:{$col2}{$row}")->applyFromArray($this->titleStyle());
                $row += 2;

                // Ringkasan
                $sheet->mergeCells("{$col}{$row}:{$col2}{$row}");
                $sheet->getStyle("{$col}{$row}:{$col2}{$row}")->applyFromArray($this->headerStyle());
                $row++;

                $ringkasanRows = 4;
                $sheet->getStyle("{$col}{$row}:{$col2}" . ($row + $ringkasanRows - 1))->applyFromArray($this->borderStyle());
                $row += $ringkasanRows + 1;

                // Rincian Harian
                $sheet->mergeCells("{$col}{$row}:{$col2}{$row}");
                $sheet->getStyle("{$col}{$row}:{$col2}{$row}")->applyFromArray($this->headerStyle());
                $row++;

                $sheet->getStyle("{$col}{$row}:{$col2}{$row}")->applyFromArray($this->subHeaderStyle());
                $harianCount = count(array_filter($this->data['harian'] ?? [], fn($d) => $d['total'] > 0));
                if ($harianCount > 0) {
                    $sheet->getStyle("{$col}" . ($row + 1) . ":{$col2}" . ($row + $harianCount))
                        ->applyFromArray($this->borderStyle());
                }
                $row += $harianCount + 2;

                // Produk Terlaris
                $sheet->mergeCells("{$col}{$row}:{$col2}{$row}");
                $sheet->getStyle("{$col}{$row}:{$col2}{$row}")->applyFromArray($this->headerStyle());
                $row++;

                $sheet->getStyle("{$col}{$row}:{$col2}{$row}")->applyFromArray($this->subHeaderStyle());
                $produkCount = count($this->data['top_products'] ?? []);
                if ($produkCount > 0) {
                    $sheet->getStyle("{$col}" . ($row + 1) . ":{$col2}" . ($row + $produkCount))
                        ->applyFromArray($this->borderStyle());
                }
                $row += $produkCount + 2;

                // Metode Pembayaran
                $sheet->mergeCells("{$col}{$row}:{$col2}{$row}");
                $sheet->getStyle("{$col}{$row}:{$col2}{$row}")->applyFromArray($this->headerStyle());
                $row++;

                $sheet->getStyle("{$col}{$row}:{$col2}{$row}")->applyFromArray($this->subHeaderStyle());
                $methodCount = count($this->data['top_methods'] ?? []);
                if ($methodCount > 0) {
                    $sheet->getStyle("{$col}" . ($row + 1) . ":{$col2}" . ($row + $methodCount))
                        ->applyFromArray($this->borderStyle());
                }

                // Sembunyikan kolom di luar B dan C
                foreach (range('A', 'Z') as $column) {
                    if (!in_array($column, [$col, $col2])) {
                        $sheet->getColumnDimension($column)->setVisible(false);
                    }
                }
            }
        ];
    }

    private function titleStyle()
    {
        return [
            'font' => ['bold' => true, 'size' => 16],
            'alignment' => ['horizontal' => 'center']
        ];
    }

    private function headerStyle()
    {
        return [
            'font' => ['bold' => true, 'color' => ['rgb' => 'FFFFFF']],
            'fill' => [
                'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                'startColor' => ['rgb' => '2563EB']
            ],
            'alignment' => ['horizontal' => 'center', 'vertical' => 'center']
        ];
    }

    private function subHeaderStyle()
    {
        return [
            'font' => ['bold' => true],
            'fill' => [
                'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                'startColor' => ['rgb' => 'E0E7FF']
            ],
            'alignment' => ['horizontal' => 'center'],
            'borders' => [
                'allBorders' => ['borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN]
            ]
        ];
    }

    private function borderStyle()
    {
        return [
            'borders' => [
                'allBorders' => ['borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN]
            ]
        ];
    }
}
