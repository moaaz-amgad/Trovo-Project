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
     * تسجيل دخول الأدمن
     */
    public function login(Request $request): JsonResponse
    {
        $request->validate([
            'username' => 'required|string',
            'password' => 'required|string',
        ]);

        $admin = Admin::where('username', $request->username)->first();

        if (!$admin || !Hash::check($request->password, $admin->password)) {
            return response()->json([
                'status' => 'error',
                'message' => 'بيانات دخول الإدارة غير صحيحة.'
            ], 401);
        }

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

    /**
     * إنشاء أدمن جديد — أي أدمن مسجل دخول يقدر يعمل أدمن تاني
     */
    public function createAdmin(Request $request): JsonResponse
    {
        $request->validate([
            'name'     => 'nullable|string|max:255',
            'username' => 'required|string|unique:admins,username|min:3',
            'password' => 'required|string|min:6',
        ]);

        $admin = Admin::create([
            'name'     => $request->name ?? $request->username,
            'username' => $request->username,
            'password' => Hash::make($request->password),
            'role'     => 'admin',
        ]);

        return response()->json([
            'status'  => 'success',
            'message' => 'تم إنشاء حساب الأدمن بنجاح.',
            'admin'   => [
                'id'       => $admin->id,
                'name'     => $admin->name,
                'username' => $admin->username,
                'role'     => $admin->role,
            ]
        ], 201);
    }
}
