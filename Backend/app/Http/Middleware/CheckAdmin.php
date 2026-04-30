<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Auth;
use App\Models\Admin; // استدعاء موديل الأدمن لضمان التعرف على النوع

class CheckAdmin
{
    /**
     * منع أي مستخدم من دخول الداشبورد باستثناء المسجلين في جدول admins
     */
    public function handle(Request $request, Closure $next): Response
    {
        // 1. التأكد أن الشخص مسجل دخول عبر Sanctum
        if (!Auth::check()) {
            return response()->json([
                'status' => 'error',
                'message' => 'Unauthenticated.'
            ], 401);
        }

        /** @var Admin $user */
        $user = Auth::user();

        // 2. فحص الصلاحية بشكل مزدوج لضمان العزل التام:
        // - فحص التوكن: هل هو توكن إدارة (access-admin)؟
        // - فحص الجدول: هل المستخدم لديه Role (admin أو super_admin)؟
        $isAdminToken = method_exists($user, 'tokenCan') && $user->tokenCan('access-admin');
        $hasAdminRole = isset($user->role) && in_array($user->role, ['admin', 'super_admin']);

        if ($isAdminToken || $hasAdminRole) {
            return $next($request);
        }

        // 3. أي محاولة دخول من "طالب" أو يوزر عادي يتم رفضها فوراً
        return response()->json([
            'status' => 'error',
            'message' => 'Access denied. Management only area.'
        ], 403);
    }
}

