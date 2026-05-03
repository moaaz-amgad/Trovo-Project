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
     * تسجيل طالب جديد (Self Registration)
     * الطالب يسجل نفسه من الأبلكيشن — ويبدأ يستخدم فوراً
     * لكن حالته تكون "غير معتمد" حتى يوافق الأدمن من الداشبورد
     */
    public function register(Request $request): JsonResponse
    {
        $request->validate([
            'name'         => 'required|string|max:255',
            'student_code' => 'required|string|unique:users,student_code',
            'phone_number' => 'nullable|string|max:20',
            'password'     => 'required|string|min:6',
        ]);

        $user = User::create([
            'name'         => $request->name,
            'student_code' => $request->student_code,
            'phone_number' => $request->phone_number,
            'password'     => Hash::make($request->password),
            'is_approved'  => false,
        ]);

        $token = $user->createToken('student_auth_token', ['access-student'])->plainTextToken;

        return response()->json([
            'status'       => 'success',
            'message'      => 'تم إنشاء حسابك بنجاح! يمكنك استخدام التطبيق الآن.',
            'access_token' => $token,
            'token_type'   => 'Bearer',
            'user'         => [
                'id'           => $user->id,
                'name'         => $user->name,
                'student_code' => $user->student_code,
                'phone_number' => $user->phone_number,
            ]
        ], 201);
    }

    /**
     * تسجيل دخول الطلاب باستخدام كود الطالب والباسورد
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
                'status'  => 'error',
                'message' => 'بيانات الدخول غير صحيحة.'
            ], 401);
        }

        // توليد التوكن الخاص بالدخول
        $token = $user->createToken('student_auth_token', ['access-student'])->plainTextToken;

        return response()->json([
            'status'       => 'success',
            'access_token' => $token,
            'token_type'   => 'Bearer',
            'user'         => [
                'id'           => $user->id,
                'name'         => $user->name,
                'student_code' => $user->student_code,
                'phone_number' => $user->phone_number,
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
            'data'   => $request->user()
        ], 200);
    }

    /**
     * تسجيل الخروج وحذف التوكن
     */
    public function logout(Request $request): JsonResponse
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'status'  => 'success',
            'message' => 'تم تسجيل الخروج بنجاح'
        ], 200);
    }
}
