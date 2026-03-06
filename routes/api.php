<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\PhoneUsageController;
use App\Http\Controllers\Api\QuestionnaireController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

// --- مسارات عامة (لا تتطلب تسجيل دخول) ---

// 1. تسجيل حساب جديد
Route::post('/register', [AuthController::class, 'register']);

// 2. تسجيل الدخول (للحصول على الـ Token)
Route::post('/login', [AuthController::class, 'login']);


// --- مسارات محمية (تتطلب وجود Token في الهيدر) ---

Route::middleware('auth:sanctum')->group(function ()
{

    // إرسال بيانات استخدام الموبايل
    Route::post('/phone-usage', [PhoneUsageController::class, 'store']);

    // عرض بيانات الاستخدام للمستخدم
    Route::get('/phone-usage', [PhoneUsageController::class, 'index']);

    // الحصول على بيانات المستخدم الحالي
    Route::get('/user', function (Request $request) {
        return $request->user();
    });




    // تسجيل الخروج
    Route::post('/logout', [PhoneUsageController::class, 'logout']);




    // Questionnaire
    Route::post('/questionnaire', [QuestionnaireController::class, 'store']);
    Route::get('/questionnaire', [QuestionnaireController::class, 'index']);

});
