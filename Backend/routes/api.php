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

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

// --- 1. مسارات الصيانة والنظام ---
Route::get('/fix-all', function () {
    try {
        Artisan::call('route:clear');
        Artisan::call('config:clear');
        Artisan::call('cache:clear');
        return response()->json(['message' => 'System Cache Cleared!']);
    } catch (\Exception $e) {
        return response()->json(['error' => $e->getMessage()], 500);
    }
});

// --- 2. مسارات عامة (Public) للطلاب ---
Route::post('/login', [AuthController::class, 'login']); // دخول الطلاب بكود الطالب

// --- 3. مسارات الإدارة المحمية (Admin Dashboard) ---
// لاحظ استخدام guard:admin لضمان أن التوكن يخص مدير
Route::middleware(['auth:sanctum', 'ability:access-admin', 'admin'])->prefix('admin')->group(function () {

    Route::post('/import-students', [ExcelController::class, 'import']);
    Route::post('/add-student-manual', [ExcelController::class, 'storeManual']);
    Route::get('/dashboard-stats', [AdminDashboardController::class, 'getStats']);
    Route::get('/all-diagnoses', [AdminDashboardController::class, 'getAllDiagnoses']);
    Route::get('/student/{id}', [AdminDashboardController::class, 'getStudentProfile'])->name('admin.student.detail');
    Route::delete('/diagnosis/{id}', [AdminDashboardController::class, 'deleteDiagnosis'])->name('admin.diagnosis.delete');
});

// --- 4. مسارات المستخدمين (الطلاب) المحمية ---
Route::middleware(['auth:sanctum', 'ability:access-student'])->group(function () {
    Route::get('/user', [AuthController::class, 'getUser']);
    Route::post('/logout', [AuthController::class, 'logout']);

    // بيانات السلوك والتشخيص
    Route::post('/phone-usage', [PhoneUsageController::class, 'store']);
    Route::get('/phone-usage', [PhoneUsageController::class, 'index']);
    Route::post('/questionnaire', [QuestionnaireController::class, 'store']);
    Route::get('/questionnaire', [QuestionnaireController::class, 'index']);

    // توليد التشخيص (AI)
    Route::post('/diagnosis/generate', [DiagnosisController::class, 'generate'])->name('diagnosis.generate');
    Route::get('/diagnosis', [DiagnosisController::class, 'index']);
});

