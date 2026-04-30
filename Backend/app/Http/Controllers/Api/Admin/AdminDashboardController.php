<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Diagnosis;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;

class AdminDashboardController extends Controller
{
    /**
     * 1. الإحصائيات الشاملة (Dashboard Home)
     * تم تحديث الحسبة لتكون أكثر دقة وإضافة العوامل الأكثر تأثيراً
     */
    public function getStats(): JsonResponse
    {
        // إجمالي الطلاب المسجلين وإجمالي الفحوصات المكتملة
        $totalStudents = User::count();
        $totalDiagnoses = Diagnosis::count();

        // تصنيف الحالات بناءً على مخرجات موديل الـ AI
        $mild = Diagnosis::where('brainrot_stage', 'like', '%Mild%')->count();
        $moderate = Diagnosis::where('brainrot_stage', 'like', '%Moderate%')->count();
        $severe = Diagnosis::where('brainrot_stage', 'like', '%Severe%')->count();

        // حساب نسبة الإدمان الرقمي بناءً على الحالات المتوسطة والحادة مقارنة بمن تم فحصهم
        $addictedCount = $moderate + $severe;
        $addictionRate = $totalDiagnoses > 0
            ? round(($addictedCount / $totalDiagnoses) * 100, 1)
            : 0;

        // --- حساب الـ Top Factors (تحليل العوامل الأكثر تكراراً في التشخيصات) ---
        // بنجيب كل الـ top_factors المسجلة، بنقسم الكلمات، ونعد أكتر حاجات اتكررت
        $allFactors = Diagnosis::pluck('top_factors')->filter()->toArray();
        $factorCounts = [];

        foreach ($allFactors as $row) {
            // تقسيم الكلمات بناءً على الفاصلة أو المسافة
            $tags = preg_split('/[, ]+/', $row);
            foreach ($tags as $tag) {
                $tag = trim($tag);
                if (!empty($tag) && strlen($tag) > 2) {
                    $factorCounts[$tag] = ($factorCounts[$tag] ?? 0) + 1;
                }
            }
        }
        arsort($factorCounts); // ترتيب من الأكثر تكراراً للأقل
        $topFactors = array_slice(array_keys($factorCounts), 0, 3); // أخذ أهم 3 عوامل

        // آخر 5 نشاطات تشخيصية مع جلب كود الطالب للتمييز
        $recentActivity = Diagnosis::with('user:id,name,student_code')
            ->latest('diagnosed_at')
            ->take(5)
            ->get();

        return response()->json([
            'status' => 'success',
            'stats' => [
                'total_students'    => $totalStudents,
                'total_diagnoses'   => $totalDiagnoses,
                'addiction_rate'    => $addictionRate . '%',
                'accuracy_rate'     => '94.8%',
                'top_impact_factors' => $topFactors, // العوامل الأهم المكتشفة
                'case_distribution' => [
                    'mild'     => $mild,
                    'moderate' => $moderate,
                    'severe'   => $severe,
                ],
                'recent_activity'   => $recentActivity
            ]
        ], 200);
    }

    /**
     * 2. جدول كل التشخيصات (Logs)
     */
    public function getAllDiagnoses(): JsonResponse
    {
        $diagnoses = Diagnosis::with('user:id,name,student_code')
                    ->latest('diagnosed_at')
                    ->paginate(15);

        return response()->json([
            'status' => 'success',
            'data'   => $diagnoses
        ], 200);
    }

    /**
     * 3. ملف الطالب التفصيلي (Student Profile)
     */
    public function getStudentProfile($id): JsonResponse
    {
        $student = User::with([
            'phoneUsages' => function($q) {
                $q->latest('collected_at');
            },
            'questionnaireResponses' => function($q) {
                $q->latest('answered_at');
            },
            'diagnosis' => function($q) {
                $q->latest('diagnosed_at');
            }
        ])->find($id);

        if (!$student) {
            return response()->json([
                'status' => 'error',
                'message' => 'عذراً، هذا الطالب غير موجود في النظام.'
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'data'   => $student
        ], 200);
    }

    /**
     * 4. حذف تشخيص معين
     */
    public function deleteDiagnosis($id): JsonResponse
    {
        $diagnosis = Diagnosis::find($id);

        if (!$diagnosis) {
            return response()->json([
                'status' => 'error',
                'message' => 'السجل المطلوب غير موجود.'
            ], 404);
        }

        $diagnosis->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'تم حذف سجل التشخيص بنجاح.'
        ], 200);
    }
}

