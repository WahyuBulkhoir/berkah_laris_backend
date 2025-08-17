<?php

namespace App\Exports;

use Illuminate\Contracts\View\View;
use Maatwebsite\Excel\Concerns\FromView;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithEvents;
use Maatwebsite\Excel\Events\AfterSheet;

class LaporanServisExport implements FromView, ShouldAutoSize, WithEvents
{
    protected $data;

    public function __construct(array $data)
    {
        $this->data = $data;
    }

    public function view(): View
    {
        return view('exports.laporan_servis_excel', [
            'data' => $this->data
        ]);
    }

    public function registerEvents(): array
    {
        return [
            AfterSheet::class => function (AfterSheet $event) {
                $sheet = $event->sheet;
                $col = 'B';
                $row = 1;

                // JUDUL UTAMA
                $sheet->mergeCells("{$col}{$row}:C{$row}");
                $sheet->getStyle("{$col}{$row}:C{$row}")->applyFromArray($this->titleStyle());
                $row += 2;

                // RINGKASAN
                $sheet->mergeCells("{$col}{$row}:C{$row}");
                $sheet->getStyle("{$col}{$row}:C{$row}")->applyFromArray($this->headerStyle());
                $row++;

                $sheet->getStyle("{$col}{$row}:C" . ($row + 2))->applyFromArray($this->borderStyle());
                $row += 4;

                // DATA HARIAN
                $sheet->mergeCells("{$col}{$row}:C{$row}");
                $sheet->getStyle("{$col}{$row}:C{$row}")->applyFromArray($this->headerStyle());
                $row++;

                $sheet->getStyle("{$col}{$row}:C{$row}")->applyFromArray($this->subHeaderStyle());

                $harianCount = count($this->data['harian']);
                if ($harianCount > 0) {
                    $sheet->getStyle("{$col}" . ($row + 1) . ":C" . ($row + $harianCount))
                        ->applyFromArray($this->borderStyle());
                }
                $row += $harianCount + 2;

                // SERVIS TERBANYAK
                $sheet->mergeCells("{$col}{$row}:C{$row}");
                $sheet->getStyle("{$col}{$row}:C{$row}")->applyFromArray($this->headerStyle());
                $row++;

                $sheet->getStyle("{$col}{$row}:C{$row}")->applyFromArray($this->subHeaderStyle());

                $produkCount = count($this->data['top_products']);
                if ($produkCount > 0) {
                    $sheet->getStyle("{$col}" . ($row + 1) . ":C" . ($row + $produkCount))
                        ->applyFromArray($this->borderStyle());
                }
                $row += $produkCount + 2;

                // METODE PEMBAYARAN
                $sheet->mergeCells("{$col}{$row}:C{$row}");
                $sheet->getStyle("{$col}{$row}:C{$row}")->applyFromArray($this->headerStyle());
                $row++;

                $sheet->getStyle("{$col}{$row}:C{$row}")->applyFromArray($this->subHeaderStyle());

                $metodeCount = count($this->data['top_methods']);
                if ($metodeCount > 0) {
                    $sheet->getStyle("{$col}" . ($row + 1) . ":C" . ($row + $metodeCount))
                        ->applyFromArray($this->borderStyle());
                }

                // Sembunyikan kolom A
                $sheet->getColumnDimension('A')->setVisible(false);
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
            'alignment' => ['horizontal' => 'center', 'vertical' => 'center'],
            'borders' => [
                'allBorders' => ['borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN]
            ]
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
            'alignment' => ['horizontal' => 'center', 'vertical' => 'center'],
            'borders' => [
                'allBorders' => ['borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN]
            ]
        ];
    }

    private function borderStyle()
    {
        return [
            'borders' => [
                'allBorders' => [
                    'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN
                ]
            ]
        ];
    }
}
