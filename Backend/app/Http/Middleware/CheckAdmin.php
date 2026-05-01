<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Auth;
use App\Models\Admin;

class CheckAdmin
{
    /**
     * منع أي مستخدم من دخول الداشبورد باستثناء المسجلين في جدول admins
     * يتطلب توكن إدارة + وجود role فعلي (فحص مزدوج بـ AND وليس OR)
     */
    public function handle(Request $request, Closure $next): Response
    {
        if (!Auth::check()) {
            return response()->json([
                'status' => 'error',
                'message' => '.'
            ], 401);
        }

        /** @var Admin $user */
        $user = Auth::user();

        // فحص مزدوج بـ AND: يجب أن يكون التوكن من نوع admin + المستخدم لديه role فعلي
        $isAdminToken = method_exists($user, 'tokenCan') && $user->tokenCan('access-admin');
        $hasAdminRole = isset($user->role) && in_array($user->role, ['admin', 'super_admin']);

        if ($isAdminToken && $hasAdminRole) {
            return $next($request);
        }

        return response()->json([
            'status' => 'error',
            'message' => 'Access denied. Management only area.'
        ], 403);
    }
}
