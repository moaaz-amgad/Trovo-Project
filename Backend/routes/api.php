<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\PhoneUsageController;
use App\Http\Controllers\Api\QuestionnaireController;
use App\Http\Controllers\Api\DiagnosisController;
use App\Http\Controllers\Api\Admin\ExcelController;
use App\Http\Controllers\Api\Admin\AdminDashboardController;
use App\Http\Controllers\Api\Admin\AdminAuthController;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

// --- 1. مسارات الصيانة (تُستخدم وقت التطوير فقط) ---
Route::get('/fix-all', function () {
    try {
        Artisan::call('route:clear');
        Artisan::call('config:clear');
        Artisan::call('cache:clear');
        return response()->json(['status' => 'success', 'message' => 'System Cache Cleared!']);
    } catch (\Exception $e) {
        return response()->json(['status' => 'error', 'message' => $e->getMessage()], 500);
    }
});

// --- 2. المسارات العامة (Public) ---

// دخول الطلاب (جدول users)
Route::post('/login', [AuthController::class, 'login']);

// دخول الإدارة (جدول admins) - تم إضافته ليفصل بين الطالب والأدمن
Route::post('/admin/login', [AdminAuthController::class, 'login']);


// --- 3. مسارات الإدارة (Admin Dashboard) المحمية ---
Route::middleware(['auth:sanctum', 'ability:access-admin'])->prefix('admin')->group(function () {

    Route::post('/import-students', [ExcelController::class, 'import']);
    Route::post('/add-student-manual', [ExcelController::class, 'storeManual']);

    // إحصائيات الداشبورد
    Route::get('/dashboard-stats', [AdminDashboardController::class, 'getStats']);
    Route::get('/all-diagnoses', [AdminDashboardController::class, 'getAllDiagnoses']);

    // بروفايل الطالب
    Route::get('/student/{id}', [AdminDashboardController::class, 'getStudentProfile']);
    Route::delete('/diagnosis/{id}', [AdminDashboardController::class, 'deleteDiagnosis']);
});


// --- 4. مسارات الطلاب (Students) المحمية ---
Route::middleware(['auth:sanctum', 'ability:access-student'])->group(function () {

    Route::get('/user', [AuthController::class, 'getUser']);
    Route::post('/logout', [AuthController::class, 'logout']);

    // تسجيل بيانات الاستخدام (Phone Usage)
    Route::post('/phone-usage', [PhoneUsageController::class, 'store']);
    Route::get('/phone-usage', [PhoneUsageController::class, 'index']);

    // تسجيل بيانات الاستبيان (Questionnaire)
    Route::post('/questionnaire', [QuestionnaireController::class, 'store']);
    Route::get('/questionnaire', [QuestionnaireController::class, 'index']);

    // طلب التحليل من الـ AI
    Route::post('/diagnosis/generate', [DiagnosisController::class, 'generate']);
    Route::get('/diagnosis-history', [DiagnosisController::class, 'index']);
});

// --- 5. تهيئة السوبر أدمن (Initialization) ---
Route::get('/init-super-admin', function () {
    try {
        $adminId = DB::table('admins')->insertGetId([
            'name'      => 'Super Operator',
            'username'  => 'super',
            'password'  => Hash::make('123'),
            'role'      => 'super_admin',
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        return response()->json([
            'status'  => 'success',
            'message' => 'Super Admin Created in [admins] table!',
            'data'    => [
                'username' => 'super',
                'password' => '123',
                'role'     => 'super_admin'
            ]
        ], 200);

    } catch (\Exception $e) {
        return response()->json([
            'status'  => 'error',
            'message' => $e->getMessage()
        ], 500);
    }
});

