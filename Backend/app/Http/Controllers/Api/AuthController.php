<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'student_code' => 'required|string',
            'password' => 'required|string',
        ]);

        $credentials = [
            'student_code' => $request->student_code,
            'password' => $request->password
        ];

        if (!Auth::attempt($credentials)) {
            return response()->json([
                'status' => 'error',
                'message' => 'بيانات الدخول غير صحيحة. يرجى مراجعة الدكتور للتأكد من تسجيل بياناتك وتفعيل حسابك.'
            ], 401);
        }

        $user = User::where('student_code', $request->student_code)->firstOrFail();

        if ($user->role !== 'student') {
            Auth::logout();
            return response()->json([
                'status' => 'error',
                'message' => 'عذراً، هذا الحساب غير مصرح له بالدخول عبر التطبيق.'
            ], 403);
        }

        $token = $user->createToken('student_auth_token')->plainTextToken;

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

    public function getUser(Request $request)
    {
        return response()->json([
            'status' => 'success',
            'data' => $request->user()
        ], 200);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'تم تسجيل الخروج بنجاح'
        ], 200);
    }

    public function googleLogin(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'google_id' => 'required',
            'name' => 'required'
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user || $user->role !== 'student') {
            return response()->json([
                'status' => 'error',
                'message' => 'عذراً، هذا الحساب غير مسجل ضمن كشوفات الطلاب المعتمدة.'
            ], 403);
        }

        $user->update(['google_id' => $request->google_id]);
        $token = $user->createToken('student_auth_token')->plainTextToken;

        return response()->json([
            'status' => 'success',
            'access_token' => $token,
            'user' => $user
        ]);
    }
}

