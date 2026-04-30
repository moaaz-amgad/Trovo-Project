<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\JsonResponse;

class AuthController extends Controller
{
    /**
     * تسجيل دخول الطلاب باستخدام الـ Username والـ Password
     */
    public function login(Request $request): JsonResponse
    {
        $request->validate([
            'username' => 'required|string',
            'password' => 'required|string',
        ]);

        // البحث عن الطالب باستخدام كود الطالب
        $user = User::where('student_code', $request->username)->first();

        // التحقق من وجود المستخدم ومطابقة الباسورد المشفر
        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                'status' => 'error',
                'message' => 'بيانات الدخول غير صحيحة. يرجى مراجعة الدكتور للتأكد من تسجيل بياناتك وتفعيل حسابك.'
            ], 401);
        }

        // توليد التوكن الخاص بالدخول
        $token = $user->createToken('student_auth_token', ['access-student'])->plainTextToken;

        return response()->json([
            'status' => 'success',
            'access_token' => $token,
            'token_type' => 'Bearer',
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'phone_number' => $user->phone_number
            ]
        ]);
    }

    /**
     * جلب بيانات الطالب المسجل حالياً
     */
    public function getUser(Request $request): JsonResponse
    {
        return response()->json([
            'status' => 'success',
            'data' => $request->user()
        ], 200);
    }

    /**
     * تسجيل الخروج وحذف التوكن
     */
    public function logout(Request $request): JsonResponse
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'تم تسجيل الخروج بنجاح'
        ], 200);
    }
}
