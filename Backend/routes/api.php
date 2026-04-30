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

// --- 1. المسارات العامة (Public) مع حماية Rate Limiting ---

// دخول الطلاب (جدول users)
Route::post('/login', [AuthController::class, 'login'])
    ->middleware('throttle:5,1');

// دخول الإدارة (جدول admins)
Route::post('/admin/login', [AdminAuthController::class, 'login'])
    ->middleware('throttle:5,1');


// --- 2. مسارات الإدارة (Admin Dashboard) المحمية ---
Route::middleware(['auth:sanctum', 'ability:access-admin'])->prefix('admin')->group(function () {

    // بيانات الأدمن الحالي وتسجيل الخروج
    Route::get('/me', [AdminDashboardController::class, 'me']);
    Route::post('/logout', [AdminDashboardController::class, 'logout']);

    // إدارة الطلاب
    Route::post('/import-students', [ExcelController::class, 'import']);
    Route::post('/add-student-manual', [ExcelController::class, 'storeManual']);

    // إحصائيات الداشبورد
    Route::get('/dashboard-stats', [AdminDashboardController::class, 'getStats']);
    Route::get('/all-diagnoses', [AdminDashboardController::class, 'getAllDiagnoses']);

    // بروفايل الطالب
    Route::get('/student/{id}', [AdminDashboardController::class, 'getStudentProfile']);
    Route::delete('/diagnosis/{id}', [AdminDashboardController::class, 'deleteDiagnosis']);

    // إنشاء أدمن جديد (Super Admin فقط)
    Route::post('/create-admin', [AdminAuthController::class, 'createAdmin']);
});


// --- 3. مسارات الطلاب (Students) المحمية ---
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
