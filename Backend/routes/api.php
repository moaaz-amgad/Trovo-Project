<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\PhoneUsageController;
use App\Http\Controllers\Api\QuestionnaireController;
use App\Http\Controllers\Api\DiagnosisController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

// --- مسارات عامة (Public Routes) ---

// 1. الحسابات
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);


// --- مسارات محمية (Protected Routes) ---
Route::middleware('auth:sanctum')->group(function () {

    // 1. بيانات المستخدم الأساسية والمصادقة
    Route::get('/user', [AuthController::class, 'getUser']);
    Route::post('/logout', [AuthController::class, 'logout']);

    // 2. استخدام الموبايل (Phone Usage)
    Route::post('/phone-usage', [PhoneUsageController::class, 'store']);
    Route::get('/phone-usage', [PhoneUsageController::class, 'index']);

    // 3. الاستبيان (Questionnaire)
    Route::post('/questionnaire', [QuestionnaireController::class, 'store']);
    Route::get('/questionnaire', [QuestionnaireController::class, 'index']);

    // 4. التشخيص الذكي (Diagnosis)
    // إنشاء تشخيص جديد بناءً على آخر بيانات مسجلة
    Route::post('/diagnosis/generate', [DiagnosisController::class, 'generate']);
    // عرض سجل التشخيصات السابق (للمستخدم الحالي فقط)
    Route::get('/diagnosis', [DiagnosisController::class, 'index']);

    // ---------------------------------------------------------
    // 5. مسارات الداشبورد (Admin Dashboard)
    // ده الـ Route اللي الداشبورد المنفصلة هتكلمه عشان تعرض داتا "كل" الطلبة
    // ---------------------------------------------------------
    Route::get('/admin/all-diagnoses', [DiagnosisController::class, 'getAllForAdmin']);

});

