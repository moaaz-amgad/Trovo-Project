<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Str;

class AuthController extends Controller
{
    // 1. تسجيل مستخدم جديد
    public function register(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|unique:users',
            'password' => 'required|string|min:6|confirmed',
        ]);

        $user = User::create([
            'name' => $validated['name'],
            'email' => $validated['email'],
            'password' => Hash::make($validated['password']),
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json(
            [
                'message' => 'User registered successfully',
                'access_token' => $token,
                'user' => $user,
            ],
            201,
        );
    }

    public function getUser(Request $request)
    {
        $user = $request->user();

        return response()->json(
            [
                'data' => $user,
            ],
            200,
        );
    }

    // 2. تسجيل دخول (للمستخدمين الحاليين)
    public function login(Request $request)
    {
        if (!Auth::attempt($request->only('email', 'password'))) {
            return response()->json(['message' => 'Invalid login details'], 401);
        }

        $user = User::where('email', $request['email'])->firstOrFail();

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'access_token' => $token,
            'token_type' => 'Bearer',
            'user' => $user,
        ]);
    }

    // 3. تسجيل الخروج
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json(
            [
                'status' => 'success',
                'message' => 'Logged out successfully. Token revoked.',
            ],
            200,
        );
    }

    // -----------------------------------------------------------
    // الزيادات الجديدة (Forget Password & Google Login)
    // -----------------------------------------------------------

    /**
     * إرسال كود إعادة تعيين كلمة السر
     */
    public function forgotPassword(Request $request)
    {
        $request->validate(['email' => 'required|email|exists:users,email']);

        // توليد كود عشوائي من 6 أرقام
        $code = rand(100000, 999999);

        // تخزينه في جدول password_reset_tokens (جدول افتراضي في لارفيل)
        DB::table('password_reset_tokens')->updateOrInsert(
            ['email' => $request->email],
            [
                'token' => Hash::make($code),
                'created_at' => now()
            ]
        );

        // ملاحظة: هنا يجب إعداد MAIL_SERVER في Railway لإرسال الإيميل حقيقةً
        // سأترك لك الكود يرجع في الاستجابة مؤقتاً للتجربة (Debug)
        return response()->json([
            'status' => 'success',
            'message' => 'Reset code generated successfully',
            'code_debug' => $code // احذف هذا السطر عند الانتقال للإنتاج الفعلي
        ]);
    }

    /**
     * تعيين كلمة سر جديدة باستخدام الكود
     */
    public function resetPassword(Request $request)
    {
        $request->validate([
            'email' => 'required|email|exists:users,email',
            'code' => 'required',
            'password' => 'required|string|min:6|confirmed',
        ]);

        $resetData = DB::table('password_reset_tokens')->where('email', $request->email)->first();

        if (!$resetData || !Hash::check($request->code, $resetData->token)) {
            return response()->json(['message' => 'Invalid or expired reset code'], 400);
        }

        $user = User::where('email', $request->email)->first();
        $user->update(['password' => Hash::make($request->password)]);

        // حذف الكود بعد الاستخدام لزيادة الأمان
        DB::table('password_reset_tokens')->where('email', $request->email)->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Password has been reset successfully'
        ]);
    }

    /**
     * تسجيل الدخول عبر جوجل (للموبايل)
     */
    public function googleLogin(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'google_id' => 'required',
            'name' => 'required'
        ]);

        // البحث عن المستخدم أو إنشاؤه إذا لم يكن موجوداً
        $user = User::updateOrCreate(
            ['email' => $request->email],
            [
                'name' => $request->name,
                'google_id' => $request->google_id,
                'password' => Hash::make(Str::random(24)), // كلمة سر عشوائية للأمان فقط
            ]
        );

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'status' => 'success',
            'access_token' => $token,
            'token_type' => 'Bearer',
            'user' => $user
        ]);
    }
}
