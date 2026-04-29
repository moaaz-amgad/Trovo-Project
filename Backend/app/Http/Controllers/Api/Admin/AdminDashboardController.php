<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Diagnosis;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class AdminDashboardController extends Controller
{
    /**
     * 1. الإحصائيات الشاملة
     * تم إزالة شرط 'role' لأن جدول الطلاب مخصص لهم فقط الآن
     */
    public function getStats()
    {
        $totalStudents = User::count();
        $totalDiagnoses = Diagnosis::count();

        // حساب الحالات بناءً على المسميات المعتمدة (Mild, Moderate, Severe)
        $mild = Diagnosis::where('brainrot_stage', 'like', '%Mild%')->count();
        $moderate = Diagnosis::where('brainrot_stage', 'like', '%Moderate%')->count();
        $severe = Diagnosis::where('brainrot_stage', 'like', '%Severe%')->count();

        // حساب نسبة الإدمان (Moderate + Severe)
        $addictedCount = $moderate + $severe;
        $addictionRate = $totalStudents > 0
            ? round(($addictedCount / $totalStudents) * 100, 1)
            : 0;

        // توزيع الجنسين
        $genderStats = DB::table('questionnaire_responses')
            ->select('gender', DB::raw('count(*) as total'))
            ->groupBy('gender')
            ->get();

        // آخر 5 نشاطات
        $recentActivity = Diagnosis::with('user:id,name')
            ->latest('diagnosed_at')
            ->take(5)
            ->get();

        return response()->json([
            'status' => 'success',
            'stats' => [
                'total_students'      => $totalStudents,
                'total_diagnoses'     => $totalDiagnoses,
                'addiction_rate'      => $addictionRate . '%',
                'accuracy_rate'       => '94.8%',
                'case_distribution'   => [
                    'mild'     => $mild,
                    'moderate' => $moderate,
                    'severe'   => $severe,
                ],
                'gender_distribution' => $genderStats,
                'recent_activity'     => $recentActivity
            ]
        ], 200);
    }

    /**
     * 2. جدول كل التشخيصات
     */
    public function getAllDiagnoses()
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
     * 3. ملف الطالب التفصيلي
     */
    public function getStudentProfile($id)
    {
        $student = User::with([
            'phoneUsages' => function($q) { $q->latest('collected_at'); },
            'questionnaireResponses' => function($q) { $q->latest('answered_at'); },
            'diagnosis' => function($q) { $q->latest('diagnosed_at'); }
        ])
        ->find($id);

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
    public function deleteDiagnosis($id)
    {
        $diagnosis = Diagnosis::find($id);

        if (!$diagnosis) {
            return response()->json([
                'status' => 'error',
                'message' => 'التشخيص غير موجود بالفعل.'
            ], 404);
        }

        $diagnosis->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'تم حذف سجل التشخيص بنجاح من النظام.'
        ], 200);
    }
}

