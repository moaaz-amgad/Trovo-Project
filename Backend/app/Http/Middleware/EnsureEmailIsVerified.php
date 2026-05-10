<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class EnsureEmailIsVerified
{
    /**
     * التحقق من أن إيميل المستخدم مؤكد قبل السماح بالوصول
     * يمنع المستخدمين غير المؤكدين من الوصول للمسارات المحمية
     */
    public function handle(Request $request, Closure $next): Response
    {
        $user = $request->user();

        if (!$user) {
            return response()->json([
                'status'  => 'error',
                'message' => 'غير مصرح. يرجى تسجيل الدخول.',
            ], 401);
        }

        if (!$user->email_verified_at) {
            return response()->json([
                'status'  => 'email_not_verified',
                'message' => 'يرجى تأكيد بريدك الإلكتروني أولاً قبل استخدام التطبيق.',
                'email'   => $user->email,
            ], 403);
        }

        return $next($request);
    }
}
