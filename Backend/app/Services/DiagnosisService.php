<?php

namespace App\Services;

use App\Models\User;
use App\Models\Diagnosis;
use App\Models\PhoneUsageData;
use App\Models\QuestionnaireResponse;
use Illuminate\Support\Facades\Http;
use Carbon\Carbon;

class DiagnosisService
{
    /**
     * توليد تشخيص جديد لمستخدم معين
     * يتحقق من وجود البيانات، تطابقها الزمني، وعدم التكرار
     *
     * @return array ['status' => string, 'data' => mixed, 'code' => int]
     */
    public function generateForUser(User $user): array
    {
        // 1. سحب آخر سجلات لليوزر من جداول المدخلات
        $lastUsage = $user->phoneUsages()->latest('collected_at')->first();
        $lastQuestionnaire = $user->questionnaireResponses()->latest('answered_at')->first();

        if (!$lastUsage || !$lastQuestionnaire) {
            return [
                'status' => 'error',
                'message' => 'عذراً ' . $user->name . '، يجب إكمال الاستبيان وبيانات الاستخدام أولاً.',
                'code' => 400
            ];
        }

        // 2. التحقق من التطابق الزمني — يجب أن تكون البيانات من نفس الفترة (24 ساعة)
        $usageTime = Carbon::parse($lastUsage->collected_at);
        $questionnaireTime = Carbon::parse($lastQuestionnaire->answered_at);

        if ($usageTime->diffInHours($questionnaireTime) > 24) {
            return [
                'status' => 'error',
                'message' => 'بيانات الاستخدام والاستبيان غير متطابقة زمنياً. يرجى تحديث كلتا البيانتين أولاً.',
                'code' => 400
            ];
        }

        // 3. منع التكرار — التحقق من عدم وجود تشخيص سابق لنفس البيانات
        $existingDiagnosis = Diagnosis::where('user_id', $user->id)
            ->where('usage_id', $lastUsage->usage_id)
            ->where('questionnaire_id', $lastQuestionnaire->questionnaire_id)
            ->first();

        if ($existingDiagnosis) {
            return [
                'status' => 'success',
                'message' => 'تم تحليل هذه البيانات مسبقاً.',
                'data' => $existingDiagnosis,
                'code' => 200
            ];
        }

        // 4. تجهيز الـ 21 حقل المطلوبة لموديل الـ AI
        $aiInputs = $this->buildAiPayload($lastUsage, $lastQuestionnaire);

        // 5. إرسال الطلب لسيرفر الـ AI
        try {
            $aiUrl = config('services.ai.url');
            $timeout = config('services.ai.timeout', 60);

            $response = Http::withHeaders([
                'Accept' => 'application/json'
            ])->timeout($timeout)->post($aiUrl . '/predict', $aiInputs);

            if (!$response->successful()) {
                return [
                    'status' => 'error',
                    'message' => 'فشل الاتصال بسيرفر التحليل. يرجى المحاولة لاحقاً.',
                    'code' => 502
                ];
            }

            $aiResult = $response->json();

            if (!isset($aiResult['addiction_level'])) {
                return [
                    'status' => 'error',
                    'message' => 'رد غير صالح من موديل الذكاء الاصطناعي.',
                    'code' => 422
                ];
            }

            // 6. تخزين التشخيص في قاعدة البيانات
            $diagnosis = $user->diagnoses()->create([
                'usage_id'         => $lastUsage->usage_id,
                'questionnaire_id' => $lastQuestionnaire->questionnaire_id,
                'addiction_level'  => $aiResult['addiction_level'],
                'brainrot_stage'   => $aiResult['brainrot_stage'],
                'analysis_intro'   => $aiResult['analysis_intro'] ?? 'General Pattern',
                'top_factors'      => $aiResult['top_factors'] ?? [],
                'recommendations'  => $aiResult['recommendations'] ?? [],
                'diagnosed_at'     => now(),
            ]);

            return [
                'status' => 'success',
                'message' => 'تم تحليل البيانات بنجاح يا ' . $user->name,
                'data' => $diagnosis,
                'code' => 201
            ];

        } catch (\Exception $e) {
            return [
                'status' => 'error',
                'message' => 'حدث خطأ أثناء الاتصال بسيرفر التحليل. يرجى المحاولة لاحقاً.',
                'code' => 500
            ];
        }
    }

    /**
     * بناء بيانات الإدخال لموديل الـ AI (21 حقل)
     */
    private function buildAiPayload(PhoneUsageData $usage, QuestionnaireResponse $questionnaire): array
    {
        return [
            'Daily_Usage_Hours'      => (float) $usage->daily_usage_hours,
            'Sleep_Hours'            => (float) $questionnaire->sleep_hours,
            'Academic_Performance'   => (float) $questionnaire->academic_performance,
            'Social_Interactions'    => (float) $questionnaire->social_interactions,
            'Exercise_Hours'         => (float) $questionnaire->exercise_hours,
            'Anxiety_Level'          => (float) $questionnaire->anxiety_level,
            'Depression_Level'       => (float) $questionnaire->depression_level,
            'Self_Esteem'            => (float) $questionnaire->self_esteem,
            'Screen_Time_Before_Bed' => (float) $usage->screen_time_before_bed,
            'Phone_Checks_Per_Day'   => (int)   $usage->phone_checks_per_day,
            'Apps_Used_Daily'        => (int)   $usage->apps_used_daily,
            'Time_on_Social_Media'   => (float) $usage->time_on_social_media,
            'Time_on_Gaming'         => (float) $usage->time_on_gaming,
            'Time_on_Education'      => (float) $questionnaire->time_on_education,
            'Weekend_Usage_Hours'    => (float) $usage->weekend_usage_hours,

            'Gender_Male'                      => ($questionnaire->gender == 'male') ? 1 : 0,
            'Gender_Other'                     => ($questionnaire->gender == 'other') ? 1 : 0,

            'Phone_Usage_Purpose_Education'    => ($usage->phone_usage_purpose == 'Education') ? 1 : 0,
            'Phone_Usage_Purpose_Gaming'       => ($usage->phone_usage_purpose == 'Gaming') ? 1 : 0,
            'Phone_Usage_Purpose_Other'        => ($usage->phone_usage_purpose == 'Other') ? 1 : 0,
            'Phone_Usage_Purpose_Social Media' => ($usage->phone_usage_purpose == 'Social Media') ? 1 : 0,
        ];
    }
}
