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

// =============================================
// 1. المسارات العامة (Public Auth — No Token)
// =============================================

// تسجيل حساب جديد
Route::post('/register', [AuthController::class, 'register'])
    ->middleware('throttle:10,1');

// تسجيل الدخول بالإيميل والباسورد
Route::post('/login', [AuthController::class, 'login'])
    ->middleware('throttle:10,1');

// تسجيل الدخول / التسجيل عبر Google
Route::post('/auth/google', [AuthController::class, 'googleAuth'])
    ->middleware('throttle:10,1');

// تأكيد الإيميل بكود OTP
Route::post('/verify-email', [AuthController::class, 'verifyEmail'])
    ->middleware('throttle:10,1');

// إعادة إرسال كود التحقق
Route::post('/resend-otp', [AuthController::class, 'resendOtp'])
    ->middleware('throttle:5,1');

// طلب إعادة تعيين كلمة المرور (Forgot Password)
Route::post('/forgot-password', [AuthController::class, 'forgotPassword'])
    ->middleware('throttle:5,1');

// إعادة تعيين كلمة المرور بالكود (Reset Password)
Route::post('/reset-password', [AuthController::class, 'resetPassword'])
    ->middleware('throttle:5,1');

// دخول الإدارة (الداشبورد)
Route::post('/admin/login', [AdminAuthController::class, 'login'])
    ->middleware('throttle:5,1');

// تجديد التوكن
Route::post('/refresh-token', [AuthController::class, 'refreshToken'])
    ->middleware('throttle:10,1');


// =============================================
// 2. مسارات الإدارة (Admin Dashboard) المحمية
// =============================================
Route::middleware(['auth:sanctum', 'check.admin'])->prefix('admin')->group(function () {

    // بيانات الأدمن الحالي وتسجيل الخروج
    Route::get('/me', [AdminDashboardController::class, 'me']);
    Route::post('/logout', [AdminDashboardController::class, 'logout']);

    // إحصائيات الداشبورد
    Route::get('/dashboard-stats', [AdminDashboardController::class, 'getStats']);

    // إدارة المستخدمين
    Route::get('/all-students', [AdminDashboardController::class, 'getAllStudents']);
    Route::delete('/student/{id}', [AdminDashboardController::class, 'deleteStudent']);

    // ملف المستخدم التفصيلي
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

    // إضافة مستخدمين يدوياً أو من إكسيل
    Route::post('/add-student-manual', [ExcelController::class, 'storeManual']);
    Route::post('/import-students', [ExcelController::class, 'import']);

    // توثيق وإلغاء توثيق المستخدمين
    Route::post('/student/{id}/approve', [AdminDashboardController::class, 'approveStudent']);
    Route::post('/student/{id}/reject', [AdminDashboardController::class, 'rejectStudent']);

    // إحصائيات الألعاب
    Route::get('/mini-game-stats', [AdminDashboardController::class, 'getMiniGameStats']);
});


// =============================================
// 3. مسارات تتطلب تسجيل دخول فقط (بدون تأكيد الإيميل)
// =============================================
Route::middleware(['auth:sanctum', 'ability:access-student'])->group(function () {

    // جلب بيانات المستخدم (يشتغل حتى لو الإيميل مش مأكد)
    Route::get('/user', [AuthController::class, 'getUser']);
    Route::post('/logout', [AuthController::class, 'logout']);
});


// =============================================
// 4. مسارات المستخدمين الكاملة (تتطلب تأكيد الإيميل)
// =============================================
Route::middleware(['auth:sanctum', 'ability:access-student', 'verified'])->group(function () {

    // إدارة الحساب
    Route::put('/user/update-profile', [AuthController::class, 'updateProfile']);
    Route::post('/user/change-password', [AuthController::class, 'changePassword']);
    Route::delete('/user/delete-account', [AuthController::class, 'deleteAccount']);

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
    Route::get('/mini-game/dashboard', [MiniGameController::class, 'dashboard']);
});
