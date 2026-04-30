<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\Admin;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\JsonResponse;

class AdminAuthController extends Controller
{
    /**
     * تسجيل دخول الأدمن/السوبر أدمن فقط
     */
    public function login(Request $request): JsonResponse
    {
        $request->validate([
            'username' => 'required|string',
            'password' => 'required|string',
        ]);

        // البحث في جدول admins وليس users
        $admin = Admin::where('username', $request->username)->first();

        // التحقق من وجوده ومطابقة الباسورد المشفر
        if (!$admin || !Hash::check($request->password, $admin->password)) {
            return response()->json([
                'status' => 'error',
                'message' => 'عذراً، بيانات دخول الإدارة غير صحيحة.'
            ], 401);
        }

        // توليد توكن بصلاحية access-admin (مهمة جداً للميدل وير)
        $token = $admin->createToken('admin_auth_token', ['access-admin'])->plainTextToken;

        return response()->json([
            'status' => 'success',
            'access_token' => $token,
            'token_type' => 'Bearer',
            'admin' => [
                'id' => $admin->id,
                'name' => $admin->name,
                'username' => $admin->username,
                'role' => $admin->role
            ]
        ], 200);
    }
}
