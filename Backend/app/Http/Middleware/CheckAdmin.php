<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class CheckAdmin
{
    public function handle(Request $request, Closure $next): Response
    {
        if (!Auth::check()) {
            return response()->json(['message' => 'Unauthenticated.'], 401);
        }

        /** @var User $user */
        $user = Auth::user();

        if (!$user->isAdmin()) {
            return response()->json([
                'status' => 'error',
                'message' => 'Access denied. Management only area.'
            ], 403);
        }

        return $next($request);
    }
}

