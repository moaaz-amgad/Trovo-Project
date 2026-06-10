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
            'game_type'           => 'required|string|in:stroop,number_letter,attention_span,memory_sequence',
            'score'               => 'required|integer|min:0',
            'reaction_time_ms'    => 'nullable|integer|min:0',
            'accuracy_percentage' => 'nullable|numeric|min:0|max:100',
            'difficulty_level'    => 'nullable|string',
            'duration_seconds'    => 'nullable|integer|min:0',
            'detailed_metrics'    => 'nullable|array',
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

    /**
     * إحصائيات لوحة التحكم الرئيسية (Dashboard) للألعاب الإدراكية
     */
    public function dashboard(Request $request): JsonResponse
    {
        $user = $request->user();

        // Fetch all recent games to calculate metrics
        $sessions = MiniGameSession::where('user_id', $user->id)
            ->orderBy('played_at', 'desc')
            ->get();

        if ($sessions->isEmpty()) {
            return response()->json([
                'status' => 'success',
                'data' => [
                    'focusScore' => 0,
                    'peakScore' => 0,
                    'avgScore' => 0,
                    'reactionTimeMs' => 0,
                    'masteryLevel' => 1,
                    'consistencyPercentage' => 0,
                    'focusDepthPercentage' => 0,
                ]
            ], 200);
        }

        // Aggregate statistics
        $totalScore = $sessions->sum('score');
        $peakScore = $sessions->max('score');
        $avgScore = round($totalScore / $sessions->count());
        
        $validReactionTimes = $sessions->whereNotNull('reaction_time_ms');
        $reactionTimeMs = $validReactionTimes->isEmpty() 
            ? 0 
            : round($validReactionTimes->avg('reaction_time_ms'));

        $validAccuracies = $sessions->whereNotNull('accuracy_percentage');
        $consistencyPercentage = $validAccuracies->isEmpty() 
            ? 0 
            : round($validAccuracies->avg('accuracy_percentage'));

        // Basic Focus Score logic (combining accuracy and a normalized reaction time)
        // Assume < 300ms is good, > 1000ms is bad
        $reactionScore = 100 - min(100, max(0, ($reactionTimeMs - 200) / 8)); 
        $focusScore = round(($consistencyPercentage * 0.7) + ($reactionScore * 0.3));

        // Mastery level based on total sessions and average scores
        $masteryLevel = min(100, max(1, floor($sessions->count() / 5) + floor($avgScore / 100)));

        // Focus depth can represent the user's ability to resist distractors (e.g., from attention_span or stroop)
        // For simplicity, we derive it from consistency and peak performance
        $focusDepthPercentage = round(($consistencyPercentage + min(100, ($peakScore / 50))) / 2);

        return response()->json([
            'status' => 'success',
            'data' => [
                'focusScore' => $focusScore,
                'peakScore' => $peakScore,
                'avgScore' => $avgScore,
                'reactionTimeMs' => $reactionTimeMs,
                'masteryLevel' => $masteryLevel,
                'consistencyPercentage' => $consistencyPercentage,
                'focusDepthPercentage' => $focusDepthPercentage,
            ]
        ], 200);
    }
}
