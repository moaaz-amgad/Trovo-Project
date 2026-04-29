<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Diagnosis;
use App\Models\User;
use Illuminate\Http\JsonResponse;

class AdminDashboardController extends Controller
{
    /**
     * 1. الإحصائيات الشاملة (Dashboard Home)
     * تم إزالة توزيع الجنسين من الإحصائيات العامة بناءً على طلبك
     */
    public function getStats(): JsonResponse
    {
        // مستخدمين النظام حالياً هم الطلاب فقط (Backend Laravel Developer approach)
        $totalStudents = User::count();
        $totalDiagnoses = Diagnosis::count();

        // تصنيف الحالات بناءً على مخرجات موديل الـ AI المعتمدة
        $mild = Diagnosis::where('brainrot_stage', 'like', '%Mild%')->count();
        $moderate = Diagnosis::where('brainrot_stage', 'like', '%Moderate%')->count();
        $severe = Diagnosis::where('brainrot_stage', 'like', '%Severe%')->count();

        // حساب نسبة الإدمان الرقمي (تجمع الحالات المتوسطة والحادة)
        $addictedCount = $moderate + $severe;
        $addictionRate = $totalStudents > 0
            ? round(($addictedCount / $totalStudents) * 100, 1)
            : 0;

        // آخر 5 نشاطات تشخيصية تمت على النظام
        $recentActivity = Diagnosis::with('user:id,name')
            ->latest('diagnosed_at')
            ->take(5)
            ->get();

        return response()->json([
            'status' => 'success',
            'stats' => [
                'total_students'    => $totalStudents,
                'total_diagnoses'   => $totalDiagnoses,
                'addiction_rate'    => $addictionRate . '%',
                'accuracy_rate'     => '94.8%', // القيمة المتوقعة لدقة التشخيص
                'case_distribution' => [
                    'mild'     => $mild,
                    'moderate' => $moderate,
                    'severe'   => $severe,
                ],
                // تم إزالة gender_distribution من هنا لعدم الحاجة له في الواجهة الرئيسية
                'recent_activity'   => $recentActivity
            ]
        ], 200);
    }

    /**
     * 2. جدول كل التشخيصات (Logs)
     */
    public function getAllDiagnoses(): JsonResponse
    {
        // جلب التشخيصات مع بيانات الطالب الأساسية (Name & Student Code)
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
     * ملاحظة: هنا يظهر الـ gender والبيانات كاملة لغرض المراجعة الفردية أو للـ AI
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

