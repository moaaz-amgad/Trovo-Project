<?php

namespace App\Services;

use App\Models\Diagnosis;
use App\Models\User;
use Illuminate\Support\Facades\Cache;

class DashboardService
{
    /**
     * الإحصائيات الشاملة للداشبورد مع كاش 5 دقائق
     */
    public function getStats(): array
    {
        return Cache::remember('dashboard_stats', 300, function () {
            $totalStudents = User::count();
            $totalDiagnoses = Diagnosis::count();

            // تصنيف الحالات بناءً على الـ addiction_level (الرقمي)
            $mild = Diagnosis::where('addiction_level', '<', 40)->count();
            $moderate = Diagnosis::whereBetween('addiction_level', [40, 70])->count();
            $severe = Diagnosis::where('addiction_level', '>', 70)->count();

            // حساب نسبة الإدمان
            $addictedCount = $moderate + $severe;
            $addictionRate = $totalDiagnoses > 0
                ? round(($addictedCount / $totalDiagnoses) * 100, 1)
                : 0;

            // حساب الـ Top Factors بشكل صحيح — top_factors هو JSON array وليس string
            $topFactors = $this->calculateTopFactors();

            return [
                'total_students'     => $totalStudents,
                'total_diagnoses'    => $totalDiagnoses,
                'addiction_rate'     => $addictionRate . '%',
                'top_impact_factors' => $topFactors,
                'case_distribution'  => [
                    'mild'     => $mild,
                    'moderate' => $moderate,
                    'severe'   => $severe,
                ],
            ];
        });
    }

    /**
     * حساب العوامل الأكثر تكراراً بشكل صحيح
     * top_factors مخزنة كـ JSON array في الداتابيز
     */
    private function calculateTopFactors(): array
    {
        $factorCounts = [];

        // جلب كل الـ top_factors بدون تحميل كل الموديل
        Diagnosis::whereNotNull('top_factors')
            ->pluck('top_factors')
            ->each(function ($factors) use (&$factorCounts) {
                // $factors قد يكون مصفوفة (بفضل الـ cast) أو string
                $items = is_array($factors) ? $factors : json_decode($factors, true);

                if (!is_array($items)) {
                    return;
                }

                foreach ($items as $factor) {
                    $factor = is_string($factor) ? trim($factor) : '';
                    if (!empty($factor) && strlen($factor) > 2) {
                        $factorCounts[$factor] = ($factorCounts[$factor] ?? 0) + 1;
                    }
                }
            });

        arsort($factorCounts);

        return array_slice(array_keys($factorCounts), 0, 5);
    }

    /**
     * مسح كاش الداشبورد (يُستدعى عند إنشاء تشخيص جديد)
     */
    public function clearCache(): void
    {
        Cache::forget('dashboard_stats');
    }
}
