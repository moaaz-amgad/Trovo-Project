<?php

namespace App\Services;

use App\Models\Diagnosis;
use App\Models\User;
use App\Models\PhoneUsageData;
use App\Models\QuestionnaireResponse;
use Illuminate\Support\Facades\Cache;

class DashboardService
{
    /**
     * الإحصائيات الشاملة للداشبورد
     * يدعم فلتر verified فقط أو الكل
     */
    public function getStats(string $filter = 'all'): array
    {
        $cacheKey = "dashboard_stats_{$filter}";

        return Cache::remember($cacheKey, 300, function () use ($filter) {
            $totalStudents  = $this->getUserQuery($filter)->count();
            $diagnosisQuery = $this->getDiagnosisQuery($filter);
            $totalDiagnoses = $diagnosisQuery->count();

            // تصنيف الحالات — مقياس تعفن الدماغ (Brain Rot Stage)
            $mild     = (clone $diagnosisQuery)->whereRaw('LOWER(brainrot_stage) LIKE ?', ['%mild%'])->count();
            $moderate = (clone $diagnosisQuery)->whereRaw('LOWER(brainrot_stage) LIKE ?', ['%moderate%'])->count();
            $severe   = (clone $diagnosisQuery)->whereRaw('LOWER(brainrot_stage) LIKE ?', ['%severe%'])->count();

            // متوسط مستوى الإدمان
            $avgAddiction = $totalDiagnoses > 0
                ? round((clone $diagnosisQuery)->avg('addiction_level'), 1)
                : 0;

            // توزيع مستويات الإدمان من 1 لـ 10 (للرسم البياني)
            $levelDistribution = [];
            for ($i = 1; $i <= 10; $i++) {
                $levelDistribution[$i] = (clone $diagnosisQuery)
                    ->whereRaw('CAST(addiction_level AS INTEGER) = ?', [$i])
                    ->count();
            }

            // حساب نسبة الإدمان
            $addictedCount = $moderate + $severe;
            $addictionRate = $totalDiagnoses > 0
                ? round(($addictedCount / $totalDiagnoses) * 100, 1)
                : 0;

            // Top Factors مع النسب
            $topFactors = $this->calculateTopFactors($filter);

            return [
                'total_students'       => $totalStudents,
                'total_diagnoses'      => $totalDiagnoses,
                'avg_addiction_level'   => $avgAddiction,
                'addiction_rate'        => $addictionRate . '%',
                'top_impact_factors'    => $topFactors,
                'level_distribution'    => $levelDistribution,
                'case_distribution'     => [
                    'mild'     => $mild,
                    'moderate' => $moderate,
                    'severe'   => $severe,
                ],
            ];
        });
    }

    /**
     * حساب متوسطات الـ 17 فيتشر
     */
    public function getFeatureAverages(string $filter = 'all'): array
    {
        $userIds = $this->getUserQuery($filter)->pluck('id');

        // Phone Usage Features
        $phoneAvg = PhoneUsageData::whereIn('user_id', $userIds)
            ->selectRaw("
                ROUND(AVG(daily_usage_hours), 2) as avg_daily_usage_hours,
                ROUND(AVG(screen_time_before_bed), 2) as avg_screen_time_before_bed,
                ROUND(AVG(phone_checks_per_day), 0) as avg_phone_checks_per_day,
                ROUND(AVG(apps_used_daily), 0) as avg_apps_used_daily,
                ROUND(AVG(time_on_social_media), 2) as avg_time_on_social_media,
                ROUND(AVG(time_on_gaming), 2) as avg_time_on_gaming,
                ROUND(AVG(weekend_usage_hours), 2) as avg_weekend_usage_hours,
                COUNT(*) as total_records
            ")
            ->first();

        // Questionnaire Features
        $questAvg = QuestionnaireResponse::whereIn('user_id', $userIds)
            ->selectRaw("
                ROUND(AVG(sleep_hours), 2) as avg_sleep_hours,
                ROUND(AVG(academic_performance), 2) as avg_academic_performance,
                ROUND(AVG(social_interactions), 2) as avg_social_interactions,
                ROUND(AVG(exercise_hours), 2) as avg_exercise_hours,
                ROUND(AVG(anxiety_level), 2) as avg_anxiety_level,
                ROUND(AVG(depression_level), 2) as avg_depression_level,
                ROUND(AVG(self_esteem), 2) as avg_self_esteem,
                ROUND(AVG(time_on_education), 2) as avg_time_on_education,
                COUNT(*) as total_records
            ")
            ->first();

        // Gender distribution
        $genderDist = QuestionnaireResponse::whereIn('user_id', $userIds)
            ->selectRaw("gender, COUNT(*) as count")
            ->groupBy('gender')
            ->pluck('count', 'gender');

        // Phone usage purpose distribution
        $purposeDist = PhoneUsageData::whereIn('user_id', $userIds)
            ->selectRaw("phone_usage_purpose, COUNT(*) as count")
            ->groupBy('phone_usage_purpose')
            ->pluck('count', 'phone_usage_purpose');

        return [
            'phone_usage' => [
                ['name' => 'Daily Usage Hours',       'value' => $phoneAvg->avg_daily_usage_hours ?? 0,       'unit' => 'hours'],
                ['name' => 'Screen Time Before Bed',  'value' => $phoneAvg->avg_screen_time_before_bed ?? 0,  'unit' => 'hours'],
                ['name' => 'Phone Checks Per Day',    'value' => $phoneAvg->avg_phone_checks_per_day ?? 0,    'unit' => 'times'],
                ['name' => 'Apps Used Daily',          'value' => $phoneAvg->avg_apps_used_daily ?? 0,          'unit' => 'apps'],
                ['name' => 'Time on Social Media',    'value' => $phoneAvg->avg_time_on_social_media ?? 0,    'unit' => 'hours'],
                ['name' => 'Time on Gaming',           'value' => $phoneAvg->avg_time_on_gaming ?? 0,           'unit' => 'hours'],
                ['name' => 'Weekend Usage Hours',      'value' => $phoneAvg->avg_weekend_usage_hours ?? 0,      'unit' => 'hours'],
            ],
            'questionnaire' => [
                ['name' => 'Sleep Hours',              'value' => $questAvg->avg_sleep_hours ?? 0,              'unit' => 'hours'],
                ['name' => 'Academic Performance',     'value' => $questAvg->avg_academic_performance ?? 0,     'unit' => '/100'],
                ['name' => 'Social Interactions',      'value' => $questAvg->avg_social_interactions ?? 0,      'unit' => '/10'],
                ['name' => 'Exercise Hours',           'value' => $questAvg->avg_exercise_hours ?? 0,           'unit' => 'hours'],
                ['name' => 'Anxiety Level',            'value' => $questAvg->avg_anxiety_level ?? 0,            'unit' => 'level'],
                ['name' => 'Depression Level',         'value' => $questAvg->avg_depression_level ?? 0,         'unit' => 'level'],
                ['name' => 'Self Esteem',              'value' => $questAvg->avg_self_esteem ?? 0,              'unit' => '/100'],
                ['name' => 'Time on Education',        'value' => $questAvg->avg_time_on_education ?? 0,        'unit' => 'hours'],
            ],
            'distributions' => [
                'gender'  => $genderDist,
                'purpose' => $purposeDist,
            ],
            'total_phone_records'         => $phoneAvg->total_records ?? 0,
            'total_questionnaire_records' => $questAvg->total_records ?? 0,
        ];
    }

    /**
     * حساب العوامل الأكثر تكراراً مع النسب
     */
    private function calculateTopFactors(string $filter = 'all'): array
    {
        $factorCounts  = [];
        $totalDiagnoses = 0;

        $query = $this->getDiagnosisQuery($filter)->whereNotNull('top_factors');

        $query->pluck('top_factors')
            ->each(function ($factors) use (&$factorCounts, &$totalDiagnoses) {
                $totalDiagnoses++;
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

        // إرجاع كل الفاكتورز مع النسب
        $result = [];
        foreach ($factorCounts as $factor => $count) {
            $percentage = $totalDiagnoses > 0
                ? round(($count / $totalDiagnoses) * 100, 1)
                : 0;
            $result[] = [
                'factor'     => $factor,
                'count'      => $count,
                'percentage' => $percentage,
            ];
        }

        return $result;
    }

    /**
     * استعلام المستخدمين حسب الفلتر
     */
    private function getUserQuery(string $filter)
    {
        $query = User::query();
        if ($filter === 'approved') {
            $query->where('is_approved', true);
        }
        return $query;
    }

    /**
     * استعلام التشخيصات حسب الفلتر
     */
    private function getDiagnosisQuery(string $filter)
    {
        $query = Diagnosis::query();
        if ($filter === 'approved') {
            $userIds = User::where('is_approved', true)->pluck('id');
            $query->whereIn('user_id', $userIds);
        }
        return $query;
    }

    /**
     * مسح كاش الداشبورد
     */
    public function clearCache(): void
    {
        Cache::forget('dashboard_stats_all');
        Cache::forget('dashboard_stats_approved');
        Cache::forget('dashboard_minigame_stats_all');
        Cache::forget('dashboard_minigame_stats_approved');
    }

    /**
     * احصائيات الالعاب (Mini Games)
     */
    public function getMiniGameStats(string $filter = 'all'): array
    {
        $cacheKey = "dashboard_minigame_stats_{$filter}";

        return Cache::remember($cacheKey, 300, function () use ($filter) {
            $query = MiniGameSession::with('user:id,name,email');
            
            if ($filter === 'approved') {
                $userIds = User::where('is_approved', true)->pluck('id');
                $query->whereIn('user_id', $userIds);
            }

            // Total sessions
            $totalSessions = (clone $query)->count();

            // Stats per game type
            $gameTypes = ['memory_sequence', 'attention_span', 'number_letter', 'stroop', 'time_focus'];
            $gameStats = [];
            $overallAvgScore = 0;
            $overallAvgReaction = 0;
            $overallAvgAccuracy = 0;

            if ($totalSessions > 0) {
                $overallAvgScore = round((clone $query)->avg('score'), 2);
                $overallAvgReaction = round((clone $query)->avg('reaction_time_ms'), 2);
                $overallAvgAccuracy = round((clone $query)->avg('accuracy_percentage'), 2);
            }

            foreach ($gameTypes as $type) {
                $typeQuery = (clone $query)->where('game_type', $type);
                $count = $typeQuery->count();
                $gameStats[] = [
                    'game_type' => $type,
                    'total_played' => $count,
                    'avg_score' => $count > 0 ? round($typeQuery->avg('score'), 2) : 0,
                    'avg_reaction_ms' => $count > 0 ? round($typeQuery->avg('reaction_time_ms'), 2) : 0,
                    'avg_accuracy' => $count > 0 ? round($typeQuery->avg('accuracy_percentage'), 2) : 0,
                ];
            }

            // Recent sessions
            $recentSessions = (clone $query)->latest('played_at')->take(10)->get();

            return [
                'total_sessions' => $totalSessions,
                'overall_avg_score' => $overallAvgScore,
                'overall_avg_reaction_ms' => $overallAvgReaction,
                'overall_avg_accuracy' => $overallAvgAccuracy,
                'game_stats' => $gameStats,
                'recent_sessions' => $recentSessions,
            ];
        });
    }
}
