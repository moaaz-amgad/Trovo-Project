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

// --- 1. مسارات الصيانة ---
Route::get('/fix-db', function () {
    try {
        Artisan::call('migrate:fresh', ['--force' => true]);
        return response()->json(['message' => 'Database Updated Successfully!']);
    } catch (\Exception $e) {
        return response()->json(['error' => $e->getMessage()], 500);
    }
});

Route::get('/fix-all', function () {
    try {
        Artisan::call('route:clear');
        Artisan::call('config:clear');
        Artisan::call('cache:clear');
        return response()->json(['message' => 'Railway Cache Cleared Successfully!']);
    } catch (\Exception $e) {
        return response()->json(['error' => $e->getMessage()], 500);
    }
});

// --- 2. مسارات عامة (Public) ---
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
Route::post('/reset-password', [AuthController::class, 'resetPassword']);
Route::post('/google-login', [AuthController::class, 'googleLogin']);

/**
 * مسارات الداشبورد (Admin Dashboard)
 */
Route::prefix('admin')->group(function () {
    // جلب كافة التشخيصات والإحصائيات مع السماح للـ CORS
    Route::get('/all-diagnoses', function(Request $request) {
        $response = (new DiagnosisController())->getAllForAdmin($request);
        // بنضيف الـ Headers هنا جوه الـ Route عشان متبوظش السيرفر
        return $response->header('Access-Control-Allow-Origin', '*')
                        ->header('Access-Control-Allow-Methods', 'GET, OPTIONS');
    })->name('admin.diagnoses.all');

    Route::get('/student/{id}', [DiagnosisController::class, 'getStudentDetail'])->name('admin.student.detail');
    Route::delete('/diagnosis/{id}', [DiagnosisController::class, 'destroy'])->name('admin.diagnosis.delete');
});

// --- 3. مسارات محمية (Protected) ---
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', [AuthController::class, 'getUser']);
    Route::post('/logout', [AuthController::class, 'logout']);

    // استخدام الموبايل
    Route::post('/phone-usage', [PhoneUsageController::class, 'store']);
    Route::get('/phone-usage', [PhoneUsageController::class, 'index']);

    // الاستبيان
    Route::post('/questionnaire', [QuestionnaireController::class, 'store']);
    Route::get('/questionnaire', [QuestionnaireController::class, 'index']);

    // التشخيص الذكي
    Route::post('/diagnosis/generate', [DiagnosisController::class, 'generate'])->name('diagnosis.generate');
    Route::get('/diagnosis', [DiagnosisController::class, 'index']);
});

