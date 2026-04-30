<?php

namespace App\Services;

use App\Models\User;
use App\Models\Diagnosis;
use App\Models\ProgressTracker;

class ProgressService
{
    /**
     * حساب وتسجيل التقدم تلقائياً بعد كل تشخيص جديد
     */
    public function trackAfterDiagnosis(User $user, Diagnosis $newDiagnosis): ?ProgressTracker
    {
        // البحث عن التشخيص السابق
        $previousDiagnosis = Diagnosis::where('user_id', $user->id)
            ->where('diagnosis_id', '!=', $newDiagnosis->diagnosis_id)
            ->latest('diagnosed_at')
            ->first();

        $change = 0;
        $trend = 'stable';
        $previousId = null;

        if ($previousDiagnosis) {
            $previousId = $previousDiagnosis->diagnosis_id;
            $change = round($newDiagnosis->addiction_level - $previousDiagnosis->addiction_level, 2);

            if ($change < -0.5) {
                $trend = 'improving';
            } elseif ($change > 0.5) {
                $trend = 'worsening';
            } else {
                $trend = 'stable';
            }
        }

        // حساب أيام الاستمرارية
        $streakDays = $this->calculateStreak($user);

        return ProgressTracker::create([
            'user_id'               => $user->id,
            'diagnosis_id'          => $newDiagnosis->diagnosis_id,
            'previous_diagnosis_id' => $previousId,
            'addiction_level_change' => $change,
            'trend'                 => $trend,
            'streak_days'           => $streakDays,
            'tracked_at'            => now(),
        ]);
    }

    /**
     * حساب أيام الاستمرارية (عدد الأيام المتتالية بتشخيصات)
     */
    private function calculateStreak(User $user): int
    {
        $diagnoses = Diagnosis::where('user_id', $user->id)
            ->latest('diagnosed_at')
            ->take(30)
            ->pluck('diagnosed_at');

        if ($diagnoses->isEmpty()) {
            return 1;
        }

        $streak = 1;
        $previousDate = now()->startOfDay();

        foreach ($diagnoses as $date) {
            $diagDate = \Carbon\Carbon::parse($date)->startOfDay();

            if ($diagDate->equalTo($previousDate) || $diagDate->equalTo($previousDate->copy()->subDay())) {
                if (!$diagDate->equalTo($previousDate)) {
                    $streak++;
                    $previousDate = $diagDate;
                }
            } else {
                break;
            }
        }

        return $streak;
    }

    /**
     * جلب ملخص التقدم لمستخدم معين
     */
    public function getSummary(User $user): array
    {
        $latestProgress = ProgressTracker::where('user_id', $user->id)
            ->latest('tracked_at')
            ->first();

        $totalDiagnoses = Diagnosis::where('user_id', $user->id)->count();

        $firstDiagnosis = Diagnosis::where('user_id', $user->id)
            ->oldest('diagnosed_at')
            ->first();

        $latestDiagnosis = Diagnosis::where('user_id', $user->id)
            ->latest('diagnosed_at')
            ->first();

        $overallChange = 0;
        if ($firstDiagnosis && $latestDiagnosis && $totalDiagnoses > 1) {
            $overallChange = round($latestDiagnosis->addiction_level - $firstDiagnosis->addiction_level, 2);
        }

        return [
            'total_diagnoses'   => $totalDiagnoses,
            'current_level'     => $latestDiagnosis?->addiction_level,
            'current_stage'     => $latestDiagnosis?->brainrot_stage,
            'overall_change'    => $overallChange,
            'current_trend'     => $latestProgress?->trend ?? 'unknown',
            'streak_days'       => $latestProgress?->streak_days ?? 0,
            'last_diagnosed_at' => $latestDiagnosis?->diagnosed_at,
        ];
    }
}
