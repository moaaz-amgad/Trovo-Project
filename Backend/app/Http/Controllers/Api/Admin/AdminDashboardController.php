<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Diagnosis;
use App\Models\User;
use App\Services\DashboardService;
use Illuminate\Http\JsonResponse;

class AdminDashboardController extends Controller
{
    public function __construct(
        private DashboardService $dashboardService
    ) {}

    /**
     * 1. الإحصائيات الشاملة (Dashboard Home)
     */
    public function getStats(): JsonResponse
    {
        $stats = $this->dashboardService->getStats();

        // آخر 5 نشاطات تشخيصية
        $recentActivity = Diagnosis::with('user:id,name,student_code')
            ->latest('diagnosed_at')
            ->take(5)
            ->get();

        return response()->json([
            'status' => 'success',
            'stats' => array_merge($stats, [
                'recent_activity' => $recentActivity
            ])
        ], 200);
    }

    /**
     * 2. جدول كل التشخيصات (Logs) — مع Pagination
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
            'diagnoses' => function($q) {
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

        // مسح كاش الداشبورد بعد الحذف
        $this->dashboardService->clearCache();

        return response()->json([
            'status' => 'success',
            'message' => 'تم حذف سجل التشخيص بنجاح.'
        ], 200);
    }

    /**
     * 5. جلب بيانات الأدمن الحالي
     */
    public function me(Request $request): JsonResponse
    {
        $admin = $request->user();

        return response()->json([
            'status' => 'success',
            'id'       => $admin->id,
            'name'     => $admin->name,
            'username' => $admin->username,
            'role'     => $admin->role,
        ], 200);
    }

    /**
     * 6. تسجيل خروج الأدمن
     */
    public function logout(Request $request): JsonResponse
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'status'  => 'success',
            'message' => 'تم تسجيل الخروج بنجاح.'
        ], 200);
    }
}
