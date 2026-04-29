<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\PhoneUsageController;
use App\Http\Controllers\Api\QuestionnaireController;
use App\Http\Controllers\Api\DiagnosisController;
use App\Http\Controllers\Api\Admin\ExcelController;
use App\Http\Controllers\Api\Admin\AdminDashboardController;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

// --- حل مشكلة الـ Build والـ CORS للأبد ---
if (php_sapi_name() !== 'cli' && isset($_SERVER['REQUEST_METHOD'])) {
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
    header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');

    if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
        exit;
    }
}

// --- 1. مسارات الصيانة والنظام ---
Route::get('/fix-all', function () {
    try {
        Artisan::call('route:clear');
        Artisan::call('config:clear');
        Artisan::call('cache:clear');
        return response()->json(['message' => 'Railway Cache Cleared!']);
    } catch (\Exception $e) {
        return response()->json(['error' => $e->getMessage()], 500);
    }
});

// مسار سريع لإنشاء السوبر أدمن باستخدام DB مباشرة لتجنب الـ Timeout
Route::get('/init-admin-99', function () {
    try {
        $exists = DB::table('admins')->where('username', 'super_admin')->first();

        if (!$exists) {
            DB::table('admins')->insert([
                'username' => 'super_admin',
                'password' => Hash::make('admin123'), // كلمة المرور الافتراضية
                'role' => 'super_admin',
                'created_at' => now(),
                'updated_at' => now(),
            ]);
            return response()->json(['message' => 'SUCCESS: Super Admin Created!']);
        }

        return response()->json(['message' => 'INFO: Admin already exists!']);
    } catch (\Exception $e) {
        return response()->json(['error' => 'DATABASE ERROR: ' . $e->getMessage()], 500);
    }
});

// --- 2. مسارات عامة (Public) ---
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
Route::post('/reset-password', [AuthController::class, 'resetPassword']);
Route::post('/google-login', [AuthController::class, 'googleLogin']);

/**
 * 3. مسارات الإدارة المحمية (Admin Dashboard)
 * محمية بـ Sanctum للتحقق من التوكن، وبـ Admin Middleware للتحقق من الرتبة
 */
Route::middleware(['auth:sanctum', 'admin'])->prefix('admin')->group(function () {

    // مسار استيراد الطلاب من الإكسيل
    Route::post('/import-students', [ExcelController::class, 'import']);

    // مسار إحصائيات لوحة التحكم (Stats)
    Route::get('/dashboard-stats', [AdminDashboardController::class, 'getStats']);

    // مسار عرض كل التشخيصات
    Route::get('/all-diagnoses', [AdminDashboardController::class, 'getAllDiagnoses']);

    // مسار تفاصيل الطالب
    Route::get('/student/{id}', [AdminDashboardController::class, 'getStudentProfile'])->name('admin.student.detail');

    // مسار حذف التشخيص
    Route::delete('/diagnosis/{id}', [AdminDashboardController::class, 'deleteDiagnosis'])->name('admin.diagnosis.delete');
});

// --- 4. مسارات المستخدمين المحمية (Protected) ---
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', [AuthController::class, 'getUser']);
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::post('/phone-usage', [PhoneUsageController::class, 'store']);
    Route::get('/phone-usage', [PhoneUsageController::class, 'index']);
    Route::post('/questionnaire', [QuestionnaireController::class, 'store']);
    Route::get('/questionnaire', [QuestionnaireController::class, 'index']);
    Route::post('/diagnosis/generate', [DiagnosisController::class, 'generate'])->name('diagnosis.generate');
    Route::get('/diagnosis', [DiagnosisController::class, 'index']);
});

