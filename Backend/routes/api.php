<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\PhoneUsageController;
use App\Http\Controllers\Api\QuestionnaireController;
use App\Http\Controllers\Api\DiagnosisController;
use App\Http\Controllers\Api\ProgressController;
use App\Http\Controllers\Api\MiniGameController;
use App\Http\Controllers\Api\Admin\ExcelController;
use App\Http\Controllers\Api\Admin\AdminDashboardController;
use App\Http\Controllers\Api\Admin\AdminAuthController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

// --- 1. المسارات العامة (Public) ---

// تسجيل طالب جديد (Self Registration)
Route::post('/register', [AuthController::class, 'register'])
    ->middleware('throttle:10,1');

// دخول الطلاب
Route::post('/login', [AuthController::class, 'login'])
    ->middleware('throttle:5,1');

// دخول الإدارة (الداشبورد)
Route::post('/admin/login', [AdminAuthController::class, 'login'])
    ->middleware('throttle:5,1');


// --- 2. مسارات الإدارة (Admin Dashboard) المحمية ---
Route::middleware(['auth:sanctum', 'check.admin'])->prefix('admin')->group(function () {

    // بيانات الأدمن الحالي وتسجيل الخروج
    Route::get('/me', [AdminDashboardController::class, 'me']);
    Route::post('/logout', [AdminDashboardController::class, 'logout']);

    // إحصائيات الداشبورد
    Route::get('/dashboard-stats', [AdminDashboardController::class, 'getStats']);

    // إدارة الطلاب
    Route::get('/all-students', [AdminDashboardController::class, 'getAllStudents']);
    Route::post('/student/{id}/approve', [AdminDashboardController::class, 'approveStudent']);
    Route::post('/student/{id}/reject', [AdminDashboardController::class, 'rejectStudent']);
    Route::delete('/student/{id}', [AdminDashboardController::class, 'deleteStudent']);

    // ملف الطالب التفصيلي
    Route::get('/student/{id}', [AdminDashboardController::class, 'getStudentProfile']);

    // التشخيصات
    Route::get('/all-diagnoses', [AdminDashboardController::class, 'getAllDiagnoses']);
    Route::delete('/diagnosis/{id}', [AdminDashboardController::class, 'deleteDiagnosis']);

    // متوسطات الفيتشرز
    Route::get('/feature-averages', [AdminDashboardController::class, 'getFeatureAverages']);

    // وضع الصيانة
    Route::post('/toggle-maintenance', [AdminDashboardController::class, 'toggleMaintenance']);

    // التصدير
    Route::get('/export/students', [AdminDashboardController::class, 'exportStudents']);
    Route::get('/export/diagnoses', [AdminDashboardController::class, 'exportDiagnoses']);

    // إضافة طلاب يدوياً أو من إكسيل
    Route::post('/add-student-manual', [ExcelController::class, 'storeManual']);
    Route::post('/import-students', [ExcelController::class, 'import']);
});


// --- 3. مسارات الطلاب (Students) المحمية ---
Route::middleware(['auth:sanctum', 'ability:access-student'])->group(function () {

    Route::get('/user', [AuthController::class, 'getUser']);
    Route::post('/logout', [AuthController::class, 'logout']);

    // بيانات الاستخدام (Phone Usage)
    Route::post('/phone-usage', [PhoneUsageController::class, 'store']);
    Route::get('/phone-usage', [PhoneUsageController::class, 'index']);

    // الاستبيان (Questionnaire)
    Route::post('/questionnaire', [QuestionnaireController::class, 'store']);
    Route::get('/questionnaire', [QuestionnaireController::class, 'index']);

    // التشخيص بالذكاء الاصطناعي
    Route::post('/diagnosis/generate', [DiagnosisController::class, 'generate'])
        ->middleware('throttle:10,1');
    Route::get('/diagnosis-history', [DiagnosisController::class, 'index']);

    // تتبع التقدم
    Route::get('/progress', [ProgressController::class, 'summary']);
    Route::get('/progress/history', [ProgressController::class, 'history']);

    // الميني جيم
    Route::post('/mini-game', [MiniGameController::class, 'store']);
    Route::get('/mini-game/history', [MiniGameController::class, 'index']);
    Route::get('/mini-game/stats', [MiniGameController::class, 'stats']);
});
