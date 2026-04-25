<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Diagnosis;
use App\Models\User;
use Illuminate\Support\Facades\Http;

class DiagnosisController extends Controller
{
    public function generate(Request $request)
    {
        $user = $request->user();

        // 1. سحب آخر سجلات لليوزر من جداول المدخلات
        $lastUsage = $user->phoneUsages()->latest('collected_at')->first();
        $lastQuestionnaire = $user->questionnaireResponses()->latest('answered_at')->first();

        if (!$lastUsage || !$lastQuestionnaire) {
            return response()->json([
                'status' => 'error',
                'message' => 'عذراً ' . $user->name . '، يجب إكمال الاستبيان وبيانات الاستخدام أولاً.'
            ], 400);
        }

        // 2. تجهيز الـ 21 حقل المطلوبة لموديل الـ AI (One-Hot Encoding)
        $aiInputs = [
            'Daily_Usage_Hours'      => (float) $lastUsage->daily_usage_hours,
            'Sleep_Hours'            => (float) $lastQuestionnaire->sleep_hours,
            'Academic_Performance'   => (float) $lastQuestionnaire->academic_performance,
            'Social_Interactions'    => (float) $lastQuestionnaire->social_interactions,
            'Exercise_Hours'         => (float) $lastQuestionnaire->exercise_hours,
            'Anxiety_Level'          => (float) $lastQuestionnaire->anxiety_level,
            'Depression_Level'       => (float) $lastQuestionnaire->depression_level,
            'Self_Esteem'            => (float) $lastQuestionnaire->self_esteem,
            'Screen_Time_Before_Bed' => (float) $lastUsage->screen_time_before_bed,
            'Phone_Checks_Per_Day'   => (int)   $lastUsage->phone_checks_per_day,
            'Apps_Used_Daily'        => (int)   $lastUsage->apps_used_daily,
            'Time_on_Social_Media'   => (float) $lastUsage->time_on_social_media,
            'Time_on_Gaming'         => (float) $lastUsage->time_on_gaming,
            'Time_on_Education'      => (float) $lastQuestionnaire->time_on_education,
            'Weekend_Usage_Hours'    => (float) $lastUsage->weekend_usage_hours,

            // معالجة تصنيفات النوع (Gender)
            'Gender_Male'                     => ($lastQuestionnaire->gender == 'male') ? 1 : 0,
            'Gender_Other'                    => ($lastQuestionnaire->gender == 'other') ? 1 : 0,

            // معالجة تصنيفات غرض الاستخدام (Usage Purpose)
            'Phone_Usage_Purpose_Education'   => ($lastUsage->phone_usage_purpose == 'Education') ? 1 : 0,
            'Phone_Usage_Purpose_Gaming'      => ($lastUsage->phone_usage_purpose == 'Gaming') ? 1 : 0,
            'Phone_Usage_Purpose_Other'       => ($lastUsage->phone_usage_purpose == 'Other') ? 1 : 0,
            'Phone_Usage_Purpose_Social Media'=> ($lastUsage->phone_usage_purpose == 'Social Media') ? 1 : 0,
        ];

        try {
            // 3. إرسال الطلب لسيرفر الـ AI (Railway Production URL)
            // سحب اللينك من الـ Environment Variables لضمان المرونة
            $aiUrl = env('AI_SERVER_URL', 'https://brain-rot-prediction-and-classification-production.up.railway.app');

            $response = Http::withHeaders([
                'Accept' => 'application/json'
            ])->timeout(60)->post(
                $aiUrl . '/predict',
                $aiInputs
            );

            $aiResult = $response->json();

            // ضيف دول عشان تشوف الرد الحقيقي في بوستمان
        if (!$response->successful()) {
         return response()->json([
        'debug_sent_data' => $aiInputs,
        'debug_raw_body' => $response->body(), // ده هيوريك السيرفر رد بـ إيه بالظبط (حتى لو Error)
        'debug_status' => $response->status()
    ], 500);
        }

            if ($response->successful() && isset($aiResult['addiction_level'])) {

                // 4. تخزين التشخيص في قاعدة البيانات
                $diagnosis = $user->diagnosis()->create([
                    'usage_id'         => $lastUsage->usage_id,
                    'questionnaire_id' => $lastQuestionnaire->questionnaire_id,
                    'addiction_level'  => $aiResult['addiction_level'], // من 1 لـ 10
                    'brain_rot_stage'  => $aiResult['brain_rot_stage'], // (mild, moderate, severe)
                    'main_issue'       => $aiResult['main_issue'] ?? 'General Usage Pattern',
                    'recommendations'  => $aiResult['recommendations'] ?? [], // مصفوفة النصائح
                    'diagnosed_at'     => now(),
                ]);

                return response()->json([
                    'status'  => 'success',
                    'message' => 'تم تحليل البيانات بنجاح يا ' . $user->name,
                    'data'    => $diagnosis
                ], 201);
            }

            return response()->json([
                'status'  => 'error',
                'message' => 'فشل موديل الذكاء الاصطناعي في تحليل البيانات.',
                'details' => $aiResult
            ], 422);

        } catch (\Exception $e) {
            return response()->json([
                'status'  => 'error',
                'message' => 'حدث خطأ في الاتصال بسيرفر التحليل: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * عرض تاريخ التشخيصات لليوزر
     */
    public function index(Request $request)
    {
        $user = $request->user();

        $history = $user->diagnosis()
                        ->with(['phoneUsage', 'questionnaire'])
                        ->latest('diagnosed_at')
                        ->get();

        return response()->json([
            'status' => 'success',
            'user'   => $user->name,
            'count'  => $history->count(),
            'data'   => $history
        ], 200);
    }

    /**
     * جلب كافة التشخيصات لكل المستخدمين (الجدول الرئيسي للدكتور)
     */
    public function getAllForAdmin(Request $request)
    {
        $allDiagnoses = Diagnosis::with('user')
                        ->latest('diagnosed_at')
                        ->get();

        // حساب الإحصائيات المطلوبة للكروت في الداشبورد (تطابق التصميم)
        $totalUsers = User::count();
        $mild = Diagnosis::where('brain_rot_stage', 'mild')->count();
        $moderate = Diagnosis::where('brain_rot_stage', 'moderate')->count();
        $severe = Diagnosis::where('brain_rot_stage', 'severe')->count();

        // حساب نسبة الإدمان (Moderate + Severe)
        $addictionRate = $totalUsers > 0
            ? round((($moderate + $severe) / $totalUsers) * 100, 1)
            : 0;

        return response()->json([
            'status' => 'success',
            'stats'  => [
                'total_users'    => $totalUsers,
                'mild_cases'     => $mild,
                'moderate_cases' => $moderate,
                'severe_cases'   => $severe,
                'addiction_rate' => $addictionRate . '%',
                'efficiency'     => '94.8%' // نسبة افتراضية لدقة الموديل
            ],
            'data'   => $allDiagnoses
        ], 200);
    }

    /**
     * ميثود إضافية للبحث عن مستخدم محدد بالـ ID (لزر الـ Begin Diagnostic)
     */
    public function getStudentDetail($id)
    {
        $user = User::with(['phoneUsages', 'questionnaireResponses', 'diagnosis'])->find($id);

        if (!$user) {
            return response()->json(['message' => 'Student not found'], 404);
        }

        return response()->json([
            'status' => 'success',
            'data'   => $user
        ], 200);
    }
}

