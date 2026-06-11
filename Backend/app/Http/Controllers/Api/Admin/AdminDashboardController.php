<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Diagnosis;
use App\Models\User;
use App\Services\DashboardService;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Artisan;
use Symfony\Component\HttpFoundation\StreamedResponse;

class AdminDashboardController extends Controller
{
    public function __construct(
        private DashboardService $dashboardService
    ) {}

    /**
     * 1. الإحصائيات الشاملة (Dashboard Overview)
     * يدعم ?filter=verified لعرض المؤكدين فقط
     */
    public function getStats(Request $request): JsonResponse
    {
        $filter = $request->query('filter', 'all');
        $stats  = $this->dashboardService->getStats($filter);

        // أحدث 5 نشاطات
        $recentQuery = Diagnosis::with('user:id,name,email');
        if ($filter === 'verified') {
            $verifiedIds = User::whereNotNull('email_verified_at')->pluck('id');
            $recentQuery->whereIn('user_id', $verifiedIds);
        }
        $recentActivity = $recentQuery->latest('diagnosed_at')->take(5)->get();

        return response()->json([
            'status' => 'success',
            'stats'  => array_merge($stats, [
                'recent_activity' => $recentActivity
            ])
        ], 200);
    }

    /**
     * 2. جدول المستخدمين — كل المستخدمين مع حالة التأكيد وأحدث تشخيص
     * يدعم ?filter=verified|unverified|all و ?search=...
     */
    public function getAllStudents(Request $request): JsonResponse
    {
        $filter = $request->query('filter', 'all');
        $search = $request->query('search', '');

        $query = User::with('latestDiagnosis')
                     ->withCount('diagnoses');

        if ($filter === 'approved') {
            $query->where('is_approved', true);
        } elseif ($filter === 'pending') {
            $query->where('is_approved', false);
        }

        if (!empty($search)) {
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhere('email', 'like', "%{$search}%");
            });
        }

        $users = $query->latest()->paginate(20);

        return response()->json([
            'status' => 'success',
            'data'   => $users,
        ], 200);
    }

    /**
     * 3. حذف مستخدم نهائياً مع كل بياناته
     * cascade في المايجريشنز بيحذف phone_usage, questionnaire, diagnoses تلقائياً
     */
    public function deleteStudent($id): JsonResponse
    {
        $student = User::find($id);
        if (!$student) {
            return response()->json(['status' => 'error', 'message' => 'المستخدم غير موجود.'], 404);
        }

        $name = $student->name;

        // حذف التوكنات أولاً ثم المستخدم (cascade يحذف الباقي)
        $student->tokens()->delete();
        $student->progressTrackers()->delete();
        $student->miniGameSessions()->delete();
        $student->delete();
        $this->dashboardService->clearCache();

        return response()->json([
            'status'  => 'success',
            'message' => 'تم حذف المستخدم ' . $name . ' وجميع بياناته نهائياً.',
        ], 200);
    }

    /**
     * 4. كل التشخيصات (Diagnoses List)
     * يدعم search و filter
     */
    public function getAllDiagnoses(Request $request): JsonResponse
    {
        $filter = $request->query('filter', 'all');
        $search = $request->query('search', '');

        $query = Diagnosis::with('user:id,name,email')
                          ->latest('diagnosed_at');

        if ($filter === 'approved') {
            $verifiedIds = User::where('is_approved', true)->pluck('id');
            $query->whereIn('user_id', $verifiedIds);
        }

        if (!empty($search)) {
            $query->whereHas('user', function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhere('email', 'like', "%{$search}%");
            });
        }

        $diagnoses = $query->paginate(20);

        return response()->json([
            'status' => 'success',
            'data'   => $diagnoses,
        ], 200);
    }

    /**
     * 5. ملف المستخدم التفصيلي (Student Profile)
     */
    public function getStudentProfile($id): JsonResponse
    {
        $student = User::with([
            'phoneUsages' => function ($q) {
                $q->latest('collected_at');
            },
            'questionnaireResponses' => function ($q) {
                $q->latest('answered_at');
            },
            'diagnoses' => function ($q) {
                $q->latest('diagnosed_at');
            },
        ])->withCount('diagnoses')->find($id);

        if (!$student) {
            return response()->json([
                'status'  => 'error',
                'message' => 'المستخدم غير موجود في النظام.'
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'data'   => $student,
        ], 200);
    }

    /**
     * 6. حذف تشخيص معين — يستخدم diagnosis_id كمفتاح أساسي
     */
    public function deleteDiagnosis($id): JsonResponse
    {
        $diagnosis = Diagnosis::where('diagnosis_id', $id)->first();

        if (!$diagnosis) {
            return response()->json(['status' => 'error', 'message' => 'السجل غير موجود.'], 404);
        }

        $diagnosis->delete();
        $this->dashboardService->clearCache();

        return response()->json([
            'status'  => 'success',
            'message' => 'تم حذف سجل التشخيص بنجاح.',
        ], 200);
    }

    /**
     * 7. متوسطات الفيتشرز (Feature Averages)
     */
    public function getFeatureAverages(Request $request): JsonResponse
    {
        $filter   = $request->query('filter', 'all');
        $averages = $this->dashboardService->getFeatureAverages($filter);

        return response()->json([
            'status' => 'success',
            'data'   => $averages,
        ], 200);
    }

    /**
     * 8. تفعيل / إلغاء وضع الصيانة (Maintenance Mode)
     */
    public function toggleMaintenance(Request $request): JsonResponse
    {
        $action = $request->input('action', 'down');

        try {
            if ($action === 'down') {
                Artisan::call('down', ['--secret' => 'trovo-admin-bypass']);
                return response()->json([
                    'status'  => 'success',
                    'message' => 'تم تفعيل وضع الصيانة. التطبيق متوقف الآن.',
                    'maintenance' => true,
                ], 200);
            } else {
                Artisan::call('up');
                return response()->json([
                    'status'  => 'success',
                    'message' => 'تم إلغاء وضع الصيانة. التطبيق يعمل الآن.',
                    'maintenance' => false,
                ], 200);
            }
        } catch (\Exception $e) {
            return response()->json([
                'status'  => 'error',
                'message' => 'فشل تبديل وضع الصيانة: ' . $e->getMessage(),
            ], 500);
        }
    }

    /**
     * 9. تصدير بيانات المستخدمين CSV
     */
    public function exportStudents(Request $request): StreamedResponse
    {
        $filter = $request->query('filter', 'all');

        $query = User::withCount('diagnoses');
        if ($filter === 'verified') {
            $query->whereNotNull('email_verified_at');
        }
        $students = $query->latest()->get();

        return response()->streamDownload(function () use ($students) {
            $handle = fopen('php://output', 'w');
            fprintf($handle, chr(0xEF) . chr(0xBB) . chr(0xBF));
            fputcsv($handle, ['ID', 'Name', 'Email', 'Email Verified', 'Google Account', 'Diagnoses Count', 'Registered At']);

            foreach ($students as $s) {
                fputcsv($handle, [
                    $s->id,
                    $s->name,
                    $s->email,
                    $s->email_verified_at ? 'Yes' : 'No',
                    $s->google_id ? 'Yes' : 'No',
                    $s->diagnoses_count,
                    $s->created_at?->format('Y-m-d H:i'),
                ]);
            }
            fclose($handle);
        }, 'trovo_students_' . date('Y-m-d') . '.csv', [
            'Content-Type' => 'text/csv; charset=UTF-8',
        ]);
    }

    /**
     * 10. تصدير بيانات التشخيصات CSV
     */
    public function exportDiagnoses(Request $request): StreamedResponse
    {
        $filter = $request->query('filter', 'all');

        $query = Diagnosis::with('user:id,name,email')->latest('diagnosed_at');
        if ($filter === 'verified') {
            $verifiedIds = User::whereNotNull('email_verified_at')->pluck('id');
            $query->whereIn('user_id', $verifiedIds);
        }
        $diagnoses = $query->get();

        return response()->streamDownload(function () use ($diagnoses) {
            $handle = fopen('php://output', 'w');
            fprintf($handle, chr(0xEF) . chr(0xBB) . chr(0xBF));
            fputcsv($handle, ['Diagnosis ID', 'User Name', 'Email', 'Addiction Level', 'Brain Rot Stage', 'Analysis Intro', 'Top Factors', 'Recommendations', 'Diagnosed At']);

            foreach ($diagnoses as $d) {
                fputcsv($handle, [
                    $d->diagnosis_id,
                    $d->user?->name ?? 'Unknown',
                    $d->user?->email ?? '',
                    $d->addiction_level,
                    $d->brainrot_stage,
                    $d->analysis_intro ?? '',
                    is_array($d->top_factors) ? implode(' | ', $d->top_factors) : '',
                    is_array($d->recommendations) ? implode(' | ', $d->recommendations) : '',
                    $d->diagnosed_at?->format('Y-m-d H:i'),
                ]);
            }
            fclose($handle);
        }, 'trovo_diagnoses_' . date('Y-m-d') . '.csv', [
            'Content-Type' => 'text/csv; charset=UTF-8',
        ]);
    }

    /**
     * 11. جلب بيانات الأدمن الحالي
     */
    public function me(Request $request): JsonResponse
    {
        $admin = $request->user();

        return response()->json([
            'status'   => 'success',
            'id'       => $admin->id,
            'name'     => $admin->name,
            'username' => $admin->username,
            'role'     => $admin->role,
        ], 200);
    }

    /**
     * 12. تسجيل خروج الأدمن
     */
    public function logout(Request $request): JsonResponse
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'status'  => 'success',
            'message' => 'تم تسجيل الخروج بنجاح.',
        ], 200);
    }

    /**
     * 13. توثيق الحساب يدوياً من الداشبورد (Approve)
     */
    public function approveStudent($id): JsonResponse
    {
        $student = User::find($id);
        if (!$student) {
            return response()->json(['status' => 'error', 'message' => 'المستخدم غير موجود.'], 404);
        }

        $student->update(['is_approved' => true]);
        $this->dashboardService->clearCache();

        return response()->json([
            'status'  => 'success',
            'message' => 'تم توثيق حساب المستخدم بنجاح.',
        ], 200);
    }

    /**
     * 14. إلغاء توثيق الحساب (Reject)
     */
    public function rejectStudent($id): JsonResponse
    {
        $student = User::find($id);
        if (!$student) {
            return response()->json(['status' => 'error', 'message' => 'المستخدم غير موجود.'], 404);
        }

        $student->update(['is_approved' => false]);
        $this->dashboardService->clearCache();

        return response()->json([
            'status'  => 'success',
            'message' => 'تم إلغاء توثيق الحساب.',
        ], 200);
    }

    /**
     * 15. إحصائيات الألعاب (Mini Games Stats)
     */
    public function getMiniGameStats(Request $request): JsonResponse
    {
        $filter = $request->query('filter', 'all');
        $stats  = $this->dashboardService->getMiniGameStats($filter);

        return response()->json([
            'status' => 'success',
            'data'   => $stats,
        ], 200);
    }
}
