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
Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
Route::post('/reset-password', [AuthController::class, 'resetPassword']);
Route::post('/google-login', [AuthController::class, 'googleLogin']);

/**
 * مسارات الداشبورد (Admin Dashboard)
 * خليناها بره الـ Sanctum عشان الداشبورد الخارجية تقدر توصل للداتا
 */
Route::prefix('admin')->group(function () {
    // جلب كافة التشخيصات والإحصائيات
    Route::get('/all-diagnoses', [DiagnosisController::class, 'getAllForAdmin'])->name('admin.diagnoses.all');

    // جلب تفاصيل طالب محدد بتاريخه الطبي
    Route::get('/student/{id}', [DiagnosisController::class, 'getStudentDetail'])->name('admin.student.detail');

    // مسار حذف تشخيص معين
    Route::delete('/diagnosis/{id}', [DiagnosisController::class, 'destroy'])->name('admin.diagnosis.delete');
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
    Route::post('/diagnosis/generate', [DiagnosisController::class, 'generate'])->name('diagnosis.generate');
    Route::get('/diagnosis', [DiagnosisController::class, 'index']);

});

