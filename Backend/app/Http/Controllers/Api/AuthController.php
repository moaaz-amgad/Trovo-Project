<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Services\OtpService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;

class AuthController extends Controller
{
    public function __construct(
        private OtpService $otpService
    ) {}

    /**
     * ========================================
     * 1. تسجيل حساب جديد (بالإيميل والباسورد)
     * ========================================
     * يقوم بإنشاء حساب + إرسال OTP لتأكيد الإيميل
     */
    public function register(Request $request): JsonResponse
    {
        $request->validate([
            'name'     => 'required|string|min:2|max:255',
            'email'    => 'required|email|unique:users,email',
            'password' => 'required|string|min:6|confirmed',
        ], [
            'name.required'      => 'الاسم مطلوب.',
            'name.min'           => 'الاسم يجب أن يكون حرفين على الأقل.',
            'email.required'     => 'البريد الإلكتروني مطلوب.',
            'email.email'        => 'صيغة البريد الإلكتروني غير صحيحة.',
            'email.unique'       => 'هذا البريد الإلكتروني مسجل بالفعل.',
            'password.required'  => 'كلمة المرور مطلوبة.',
            'password.min'       => 'كلمة المرور يجب أن تكون 6 أحرف على الأقل.',
            'password.confirmed' => 'تأكيد كلمة المرور غير مطابق.',
        ]);

        $user = User::create([
            'name'     => $request->name,
            'email'    => strtolower(trim($request->email)),
            'password' => Hash::make($request->password),
        ]);

        // إرسال OTP لتأكيد الإيميل
        $otpResult = $this->otpService->generateAndSend($user->email, 'email_verification');

        // إنشاء توكن (يمكنه الوصول لبعض الأشياء لكن بدون تأكيد الإيميل لن يقدر يعمل شغل كامل)
        $token = $user->createToken('auth_token', ['access-student'])->plainTextToken;
        $refreshToken = $user->createToken('refresh_token', ['refresh'])->plainTextToken;

        return response()->json([
            'status'       => 'success',
            'message'      => 'تم إنشاء حسابك بنجاح! تم إرسال كود التحقق إلى بريدك الإلكتروني.',
            'access_token' => $token,
            'refresh_token' => $refreshToken,
            'token_type'   => 'Bearer',
            'email_verified' => false,
            'user'         => [
                'id'     => $user->id,
                'name'   => $user->name,
                'email'  => $user->email,
                'avatar' => $user->avatar,
            ],
        ], 201);
    }

    /**
     * ========================================
     * 2. تسجيل الدخول (بالإيميل والباسورد)
     * ========================================
     */
    public function login(Request $request): JsonResponse
    {
        $request->validate([
            'email'    => 'required|email',
            'password' => 'required|string',
        ], [
            'email.required'    => 'البريد الإلكتروني مطلوب.',
            'email.email'       => 'صيغة البريد الإلكتروني غير صحيحة.',
            'password.required' => 'كلمة المرور مطلوبة.',
        ]);

        $user = User::where('email', strtolower(trim($request->email)))->first();

        // التحقق من وجود المستخدم ومطابقة الباسورد
        if (!$user || !$user->password || !Hash::check($request->password, $user->password)) {
            return response()->json([
                'status'  => 'error',
                'message' => 'بيانات الدخول غير صحيحة.',
            ], 401);
        }

        // التحقق من تأكيد الإيميل
        if (!$user->isVerified()) {
            // إعادة إرسال OTP تلقائياً
            $this->otpService->generateAndSend($user->email, 'email_verification');

            return response()->json([
                'status'         => 'email_not_verified',
                'message'        => 'يرجى تأكيد بريدك الإلكتروني أولاً. تم إرسال كود تحقق جديد.',
                'email'          => $user->email,
                'email_verified' => false,
            ], 403);
        }

        $token = $user->createToken('auth_token', ['access-student'])->plainTextToken;
        $refreshToken = $user->createToken('refresh_token', ['refresh'])->plainTextToken;

        $hasDiagnosis = \App\Models\Diagnosis::where('user_id', $user->id)->exists();

        return response()->json([
            'status'         => 'success',
            'message'        => 'تم تسجيل الدخول بنجاح.',
            'access_token'   => $token,
            'refresh_token'  => $refreshToken,
            'token_type'     => 'Bearer',
            'email_verified' => true,
            'has_diagnosis'  => $hasDiagnosis,
            'user'           => [
                'id'     => $user->id,
                'name'   => $user->name,
                'email'  => $user->email,
                'avatar' => $user->avatar,
            ],
        ]);
    }

    /**
     * ========================================
     * 3. تأكيد الإيميل بكود OTP
     * ========================================
     */
    public function verifyEmail(Request $request): JsonResponse
    {
        $request->validate([
            'email' => 'required|email',
            'code'  => 'required|string|size:6',
        ], [
            'email.required' => 'البريد الإلكتروني مطلوب.',
            'code.required'  => 'كود التحقق مطلوب.',
            'code.size'      => 'كود التحقق يجب أن يكون 6 أرقام.',
        ]);

        $email = strtolower(trim($request->email));

        // التحقق من الكود
        $result = $this->otpService->verify($email, $request->code, 'email_verification');

        if (!$result['valid']) {
            return response()->json([
                'status'  => 'error',
                'message' => $result['message'],
            ], 422);
        }

        // تأكيد الإيميل
        $user = User::where('email', $email)->first();

        if (!$user) {
            return response()->json([
                'status'  => 'error',
                'message' => 'المستخدم غير موجود.',
            ], 404);
        }

        $user->update(['email_verified_at' => now()]);

        // إنشاء توكن جديد
        $user->tokens()->delete();
        $token = $user->createToken('auth_token', ['access-student'])->plainTextToken;
        $refreshToken = $user->createToken('refresh_token', ['refresh'])->plainTextToken;

        return response()->json([
            'status'         => 'success',
            'message'        => 'تم تأكيد بريدك الإلكتروني بنجاح! يمكنك الآن استخدام التطبيق.',
            'access_token'   => $token,
            'refresh_token'  => $refreshToken,
            'token_type'     => 'Bearer',
            'email_verified' => true,
            'user'           => [
                'id'     => $user->id,
                'name'   => $user->name,
                'email'  => $user->email,
                'avatar' => $user->avatar,
            ],
        ]);
    }

    /**
     * ========================================
     * 4. إعادة إرسال كود التحقق
     * ========================================
     */
    public function resendOtp(Request $request): JsonResponse
    {
        $request->validate([
            'email' => 'required|email',
            'type'  => 'required|in:email_verification,password_reset',
        ]);

        $email = strtolower(trim($request->email));
        $user  = User::where('email', $email)->first();

        if (!$user) {
            // لأسباب أمنية نرجع رسالة نجاح حتى لو الإيميل مش موجود
            return response()->json([
                'status'  => 'success',
                'message' => 'إذا كان البريد الإلكتروني مسجلاً، سيتم إرسال كود التحقق.',
            ]);
        }

        // لو نوع التحقق email_verification والإيميل متأكد بالفعل
        if ($request->type === 'email_verification' && $user->isVerified()) {
            return response()->json([
                'status'  => 'success',
                'message' => 'بريدك الإلكتروني مؤكد بالفعل.',
            ]);
        }

        $result = $this->otpService->generateAndSend($email, $request->type);

        return response()->json([
            'status'  => $result['success'] ? 'success' : 'error',
            'message' => $result['message'],
        ], $result['success'] ? 200 : 429);
    }

    /**
     * ========================================
     * 5. طلب إعادة تعيين كلمة المرور (Forgot Password)
     * ========================================
     */
    public function forgotPassword(Request $request): JsonResponse
    {
        $request->validate([
            'email' => 'required|email',
        ], [
            'email.required' => 'البريد الإلكتروني مطلوب.',
            'email.email'    => 'صيغة البريد الإلكتروني غير صحيحة.',
        ]);

        $email = strtolower(trim($request->email));
        $user  = User::where('email', $email)->first();

        // رسالة موحدة سواء الإيميل موجود أو لا (لأسباب أمنية)
        if (!$user) {
            return response()->json([
                'status'  => 'success',
                'message' => 'إذا كان البريد الإلكتروني مسجلاً، سيتم إرسال كود إعادة تعيين كلمة المرور.',
            ]);
        }

        // لو المستخدم مسجل بجوجل فقط وما عندوش باسورد
        if ($user->isGoogleUser() && !$user->password) {
            return response()->json([
                'status'  => 'error',
                'message' => 'هذا الحساب مرتبط بـ Google. يرجى تسجيل الدخول عبر Google.',
            ], 400);
        }

        $result = $this->otpService->generateAndSend($email, 'password_reset');

        return response()->json([
            'status'  => $result['success'] ? 'success' : 'error',
            'message' => $result['success']
                ? 'تم إرسال كود إعادة تعيين كلمة المرور إلى بريدك الإلكتروني.'
                : $result['message'],
        ], $result['success'] ? 200 : 429);
    }

    /**
     * ========================================
     * 6. إعادة تعيين كلمة المرور (Reset Password)
     * ========================================
     */
    public function resetPassword(Request $request): JsonResponse
    {
        $request->validate([
            'email'    => 'required|email',
            'code'     => 'required|string|size:6',
            'password' => 'required|string|min:6|confirmed',
        ], [
            'email.required'     => 'البريد الإلكتروني مطلوب.',
            'code.required'      => 'كود التحقق مطلوب.',
            'code.size'          => 'كود التحقق يجب أن يكون 6 أرقام.',
            'password.required'  => 'كلمة المرور الجديدة مطلوبة.',
            'password.min'       => 'كلمة المرور يجب أن تكون 6 أحرف على الأقل.',
            'password.confirmed' => 'تأكيد كلمة المرور غير مطابق.',
        ]);

        $email = strtolower(trim($request->email));

        // التحقق من الكود
        $result = $this->otpService->verify($email, $request->code, 'password_reset');

        if (!$result['valid']) {
            return response()->json([
                'status'  => 'error',
                'message' => $result['message'],
            ], 422);
        }

        $user = User::where('email', $email)->first();

        if (!$user) {
            return response()->json([
                'status'  => 'error',
                'message' => 'المستخدم غير موجود.',
            ], 404);
        }

        // تحديث كلمة المرور
        $user->update([
            'password' => Hash::make($request->password),
        ]);

        // حذف كل التوكنات القديمة (إجبار تسجيل دخول جديد)
        $user->tokens()->delete();

        return response()->json([
            'status'  => 'success',
            'message' => 'تم تغيير كلمة المرور بنجاح. يمكنك تسجيل الدخول الآن بكلمة المرور الجديدة.',
        ]);
    }

    /**
     * ========================================
     * 7. تسجيل الدخول / التسجيل عبر Google
     * ========================================
     * يستقبل id_token من الموبايل ويتحقق من صحته مع Google
     */
    public function googleAuth(Request $request): JsonResponse
    {
        $request->validate([
            'id_token' => 'required|string',
        ], [
            'id_token.required' => 'Google token مطلوب.',
        ]);

        // التحقق من التوكن مع Google
        try {
            $response = Http::timeout(10)->get('https://oauth2.googleapis.com/tokeninfo', [
                'id_token' => $request->id_token,
            ]);

            if ($response->failed()) {
                Log::warning('Google token validation failed', [
                    'status' => $response->status(),
                    'body'   => $response->body(),
                ]);
                return response()->json([
                    'status'  => 'error',
                    'message' => 'Google token غير صالح أو منتهي الصلاحية.',
                ], 401);
            }

            $googleUser = $response->json();

            // التحقق من audience (client_id)
            $expectedClientId = config('services.google.client_id');
            if ($expectedClientId && isset($googleUser['aud']) && $googleUser['aud'] !== $expectedClientId) {
                Log::warning('Google token audience mismatch', [
                    'expected' => $expectedClientId,
                    'got'      => $googleUser['aud'] ?? 'missing',
                ]);
                return response()->json([
                    'status'  => 'error',
                    'message' => 'Google token غير صالح.',
                ], 401);
            }

        } catch (\Exception $e) {
            Log::error('Google auth error', ['error' => $e->getMessage()]);
            return response()->json([
                'status'  => 'error',
                'message' => 'حدث خطأ أثناء التحقق من حساب Google. حاول مرة أخرى.',
            ], 500);
        }

        $googleId    = $googleUser['sub'] ?? null;
        $googleEmail = $googleUser['email'] ?? null;
        $googleName  = $googleUser['name'] ?? ($googleUser['given_name'] ?? 'User');
        $googleAvatar = $googleUser['picture'] ?? null;

        if (!$googleId || !$googleEmail) {
            return response()->json([
                'status'  => 'error',
                'message' => 'بيانات حساب Google غير كاملة.',
            ], 400);
        }

        $googleEmail = strtolower(trim($googleEmail));

        // البحث عن مستخدم بنفس google_id أو بنفس الإيميل
        $user = User::where('google_id', $googleId)
                     ->orWhere('email', $googleEmail)
                     ->first();

        $isNewUser = false;

        if ($user) {
            // تحديث بيانات Google لو مش متربط
            $user->update([
                'google_id'         => $googleId,
                'avatar'            => $googleAvatar ?? $user->avatar,
                'email_verified_at' => $user->email_verified_at ?? now(), // تأكيد الإيميل تلقائياً
            ]);
        } else {
            // إنشاء حساب جديد
            $user = User::create([
                'name'              => $googleName,
                'email'             => $googleEmail,
                'google_id'         => $googleId,
                'avatar'            => $googleAvatar,
                'email_verified_at' => now(), // Google users are auto-verified
            ]);
            $isNewUser = true;
        }

        $token = $user->createToken('auth_token', ['access-student'])->plainTextToken;
        $refreshToken = $user->createToken('refresh_token', ['refresh'])->plainTextToken;

        return response()->json([
            'status'         => 'success',
            'message'        => $isNewUser
                ? 'تم إنشاء حسابك وتسجيل الدخول بنجاح عبر Google!'
                : 'تم تسجيل الدخول بنجاح عبر Google!',
            'access_token'   => $token,
            'refresh_token'  => $refreshToken,
            'token_type'     => 'Bearer',
            'email_verified' => true,
            'is_new_user'    => $isNewUser,
            'user'           => [
                'id'     => $user->id,
                'name'   => $user->name,
                'email'  => $user->email,
                'avatar' => $user->avatar,
            ],
        ], $isNewUser ? 201 : 200);
    }

    /**
     * ========================================
     * 8. جلب بيانات المستخدم الحالي
     * ========================================
     */
    public function getUser(Request $request): JsonResponse
    {
        $user = $request->user();

        return response()->json([
            'status' => 'success',
            'data'   => [
                'id'             => $user->id,
                'name'           => $user->name,
                'email'          => $user->email,
                'avatar'         => $user->avatar,
                'email_verified' => $user->isVerified(),
                'is_google_user' => $user->isGoogleUser(),
                'created_at'     => $user->created_at,
            ],
        ]);
    }

    /**
     * ========================================
     * 9. تسجيل الخروج وحذف التوكن
     * ========================================
     */
    public function logout(Request $request): JsonResponse
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'status'  => 'success',
            'message' => 'تم تسجيل الخروج بنجاح.',
        ]);
    }

    /**
     * ========================================
     * 10. تعديل بيانات الحساب (Update Profile)
     * ========================================
     */
    public function updateProfile(Request $request): JsonResponse
    {
        $user = $request->user();

        $request->validate([
            'name'   => 'sometimes|string|min:2|max:255',
            'avatar' => 'sometimes|nullable|url|max:500',
        ], [
            'name.min'    => 'الاسم يجب أن يكون حرفين على الأقل.',
            'name.max'    => 'الاسم طويل جداً.',
            'avatar.url'  => 'رابط الصورة غير صحيح.',
        ]);

        $updated = [];

        if ($request->has('name')) {
            $user->name = $request->name;
            $updated[] = 'الاسم';
        }

        if ($request->has('avatar')) {
            $user->avatar = $request->avatar;
            $updated[] = 'الصورة';
        }

        if (empty($updated)) {
            return response()->json([
                'status'  => 'error',
                'message' => 'لم يتم إرسال أي بيانات للتحديث.',
            ], 422);
        }

        $user->save();

        return response()->json([
            'status'  => 'success',
            'message' => 'تم تحديث ' . implode(' و', $updated) . ' بنجاح.',
            'user'    => [
                'id'     => $user->id,
                'name'   => $user->name,
                'email'  => $user->email,
                'avatar' => $user->avatar,
            ],
        ]);
    }

    /**
     * ========================================
     * 11. تغيير كلمة المرور (Change Password)
     * ========================================
     * للمستخدم المسجل دخول — يحتاج كلمة المرور القديمة
     */
    public function changePassword(Request $request): JsonResponse
    {
        $user = $request->user();

        // لو المستخدم مسجل بجوجل فقط وما عندوش باسورد
        if ($user->isGoogleUser() && !$user->password) {
            // السماح بإنشاء باسورد جديد بدون القديم
            $request->validate([
                'password' => 'required|string|min:6|confirmed',
            ], [
                'password.required'  => 'كلمة المرور الجديدة مطلوبة.',
                'password.min'       => 'كلمة المرور يجب أن تكون 6 أحرف على الأقل.',
                'password.confirmed' => 'تأكيد كلمة المرور غير مطابق.',
            ]);

            $user->update([
                'password' => Hash::make($request->password),
            ]);

            return response()->json([
                'status'  => 'success',
                'message' => 'تم إنشاء كلمة المرور بنجاح. يمكنك الآن تسجيل الدخول بالإيميل والباسورد أيضاً.',
            ]);
        }

        // المستخدم العادي — يحتاج الباسورد القديم
        $request->validate([
            'current_password' => 'required|string',
            'password'         => 'required|string|min:6|confirmed',
        ], [
            'current_password.required' => 'كلمة المرور الحالية مطلوبة.',
            'password.required'         => 'كلمة المرور الجديدة مطلوبة.',
            'password.min'              => 'كلمة المرور يجب أن تكون 6 أحرف على الأقل.',
            'password.confirmed'        => 'تأكيد كلمة المرور غير مطابق.',
        ]);

        // التحقق من كلمة المرور الحالية
        if (!Hash::check($request->current_password, $user->password)) {
            return response()->json([
                'status'  => 'error',
                'message' => 'كلمة المرور الحالية غير صحيحة.',
            ], 401);
        }

        // التحقق من أن الباسورد الجديد مختلف عن القديم
        if (Hash::check($request->password, $user->password)) {
            return response()->json([
                'status'  => 'error',
                'message' => 'كلمة المرور الجديدة يجب أن تكون مختلفة عن الحالية.',
            ], 422);
        }

        $user->update([
            'password' => Hash::make($request->password),
        ]);

        // حذف كل التوكنات ما عدا الحالي
        $user->tokens()->where('id', '!=', $user->currentAccessToken()->id)->delete();

        return response()->json([
            'status'  => 'success',
            'message' => 'تم تغيير كلمة المرور بنجاح.',
        ]);
    }

    /**
     * ========================================
     * 12. حذف الحساب نهائياً (Delete Account)
     * ========================================
     */
    public function deleteAccount(Request $request): JsonResponse
    {
        $user = $request->user();

        // لو عندو باسورد، يحتاج يأكد
        if ($user->password) {
            $request->validate([
                'password' => 'required|string',
            ], [
                'password.required' => 'كلمة المرور مطلوبة لتأكيد حذف الحساب.',
            ]);

            if (!Hash::check($request->password, $user->password)) {
                return response()->json([
                    'status'  => 'error',
                    'message' => 'كلمة المرور غير صحيحة.',
                ], 401);
            }
        }

        // حذف كل البيانات المرتبطة
        $user->tokens()->delete();
        $user->progressTrackers()->delete();
        $user->miniGameSessions()->delete();

        $userName = $user->name;
        $user->delete();

        return response()->json([
            'status'  => 'success',
            'message' => 'تم حذف حساب ' . $userName . ' وجميع البيانات المرتبطة نهائياً.',
        ]);
    }

    /**
     * ========================================
     * 13. تجديد التوكن (Refresh Token)
     * ========================================
     */
    public function refreshToken(Request $request): JsonResponse
    {
        $refreshTokenPlain = $request->header('refreshtoken');

        if (!$refreshTokenPlain) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Refresh token missing',
            ], 401);
        }

        $token = \Laravel\Sanctum\PersonalAccessToken::findToken($refreshTokenPlain);

        if (!$token || !$token->can('refresh')) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Invalid or expired refresh token',
            ], 401);
        }

        $user = $token->tokenable;

        // حذف التوكن القديم لتجنب تراكم التوكنات
        $token->delete();

        // إنشاء توكنات جديدة
        $newAccessToken = $user->createToken('auth_token', ['access-student'])->plainTextToken;
        $newRefreshToken = $user->createToken('refresh_token', ['refresh'])->plainTextToken;

        return response()->json([
            'status'         => 'success',
            'access_token'   => $newAccessToken,
            'refresh_token'  => $newRefreshToken,
            'token_type'     => 'Bearer',
        ]);
    }
}
