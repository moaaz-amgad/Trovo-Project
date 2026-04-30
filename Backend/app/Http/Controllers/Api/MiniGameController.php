<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\MiniGameSession;
use Illuminate\Http\JsonResponse;

class MiniGameController extends Controller
{
    /**
     * تخزين نتيجة جلسة ميني جيم جديدة
     */
    public function store(Request $request): JsonResponse
    {
        $user = $request->user();

        $validated = $request->validate([
            'game_type'           => 'required|string|in:memory,reaction,focus,pattern',
            'score'               => 'required|integer|min:0',
            'reaction_time_ms'    => 'nullable|integer|min:0',
            'accuracy_percentage' => 'nullable|numeric|min:0|max:100',
            'difficulty_level'    => 'required|string|in:easy,medium,hard',
            'duration_seconds'    => 'required|integer|min:1|max:3600',
        ]);

        $session = $user->miniGameSessions()->create(array_merge($validated, [
            'played_at' => now(),
        ]));

        return response()->json([
            'status'  => 'success',
            'message' => 'تم تسجيل نتيجة اللعبة بنجاح.',
            'data'    => $session
        ], 201);
    }

    /**
     * تاريخ جلسات الميني جيم للطالب الحالي
     */
    public function index(Request $request): JsonResponse
    {
        $user = $request->user();

        $history = $user->miniGameSessions()
            ->latest('played_at')
            ->paginate(15);

        return response()->json([
            'status' => 'success',
            'user'   => $user->name,
            'data'   => $history
        ], 200);
    }

    /**
     * إحصائيات الأداء في الألعاب
     */
    public function stats(Request $request): JsonResponse
    {
        $user = $request->user();

        $stats = MiniGameSession::where('user_id', $user->id)
            ->selectRaw("
                game_type,
                COUNT(*) as total_sessions,
                AVG(score) as avg_score,
                MAX(score) as best_score,
                AVG(reaction_time_ms) as avg_reaction_time,
                AVG(accuracy_percentage) as avg_accuracy
            ")
            ->groupBy('game_type')
            ->get();

        return response()->json([
            'status' => 'success',
            'user'   => $user->name,
            'data'   => $stats
        ], 200);
    }
}
