<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    /**
     * تسجيل دخول الطلاب باستخدام الـ Username والـ Password
     * (كلاهما يستقبل student_code داخلياً)
     */
    public function login(Request $request)
    {
        // التحقق من المدخلات باسم username و password كما طلبت
        $request->validate([
            'username' => 'required|string',
            'password' => 'required|string',
        ]);

        // البحث عن الطالب باستخدام كود الطالب (المرسل في حقل username)
        $user = User::where('student_code', $request->username)->first();

        // محاولة التحقق من البيانات:
        // 1. وجود المستخدم
        // 2. مطابقة الباسورد لكود الطالب (بدون Hash لأن الكود هو كلمة السر)
        if (!$user || $request->password !== $user->student_code) {
            return response()->json([
                'status' => 'error',
                'message' => 'بيانات الدخول غير صحيحة. يرجى مراجعة الدكتور للتأكد من تسجيل بياناتك وتفعيل حسابك.'
            ], 401);
        }

        // توليد التوكن الخاص بالدخول مع إضافة الصلاحيات اللازمة (access-student)
        // تم الحفاظ على اسم التوكن كما في كودك الأصلي
        $token = $user->createToken('student_auth_token', ['access-student'])->plainTextToken;

        // إرجاع الرد بنفس التنسيق والتفاصيل الأصلية تماماً
        return response()->json([
            'status' => 'success',
            'access_token' => $token,
            'token_type' => 'Bearer',
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'student_code' => $user->student_code,
                'phone_number' => $user->phone_number
            ]
        ]);
    }

    /**
     * جلب بيانات الطالب المسجل حالياً
     */
    public function getUser(Request $request)
    {
        return response()->json([
            'status' => 'success',
            'data' => $request->user()
        ], 200);
    }

    /**
     * تسجيل الخروج وحذف التوكن
     */
    public function logout(Request $request)
    {
        // حذف التوكن الحالي للحفاظ على الأمان
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'تم تسجيل الخروج بنجاح'
        ], 200);
    }
}

