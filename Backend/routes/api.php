<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\PhoneUsageController;
use App\Http\Controllers\Api\QuestionnaireController;
use App\Http\Controllers\Api\DiagnosisController;
use Illuminate\Support\Facades\Artisan;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

// --- 1. مسارات الصيانة (Maintenance) ---
Route::get('/fix-db', function () {
    try {
        Artisan::call('migrate:fresh', ['--force' => true]);
        return response()->json([
            'message' => 'Database Updated Successfully!',
            'output' => Artisan::output()
        ]);
    } catch (\Exception $e) {
        return response()->json(['error' => $e->getMessage()], 500);
    }
});

// --- 2. مسارات عامة (Public Routes) ---
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

/**
 * مسارات الداشبورد (Admin Dashboard)
 * خليناها بره الـ Middleware مؤقتاً عشان الدكتور يقدر يشوف الداتا فوراً من مشروع الفرونت إند
 */
Route::prefix('admin')->group(function () {
    // لجلب كل الإحصائيات والجدول
    Route::get('/all-diagnoses', [DiagnosisController::class, 'getAllForAdmin']);
    // للبحث عن طالب معين بالـ ID
    Route::get('/student/{id}', [DiagnosisController::class, 'getStudentDetail']);
});


// --- 3. مسارات محمية (Protected Routes) ---
Route::middleware('auth:sanctum')->group(function () {

    // بيانات المستخدم والمصادقة
    Route::get('/user', [AuthController::class, 'getUser']);
    Route::post('/logout', [AuthController::class, 'logout']);

    // استخدام الموبايل (Phone Usage)
    Route::post('/phone-usage', [PhoneUsageController::class, 'store']);
    Route::get('/phone-usage', [PhoneUsageController::class, 'index']);

    // الاستبيان (Questionnaire)
    Route::post('/questionnaire', [QuestionnaireController::class, 'store']);
    Route::get('/questionnaire', [QuestionnaireController::class, 'index']);

    // التشخيص الذكي (Diagnosis)
    Route::post('/diagnosis/generate', [DiagnosisController::class, 'generate']);
    Route::get('/diagnosis', [DiagnosisController::class, 'index']);

});

