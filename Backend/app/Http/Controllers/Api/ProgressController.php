<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\ProgressService;
use App\Models\ProgressTracker;
use Illuminate\Http\JsonResponse;

class ProgressController extends Controller
{
    public function __construct(
        private ProgressService $progressService
    ) {}

    /**
     * ملخص التقدم للطالب الحالي
     */
    public function summary(Request $request): JsonResponse
    {
        $user = $request->user();
        $summary = $this->progressService->getSummary($user);

        return response()->json([
            'status' => 'success',
            'user'   => $user->name,
            'data'   => $summary
        ], 200);
    }

    /**
     * تاريخ التقدم التفصيلي
     */
    public function history(Request $request): JsonResponse
    {
        $user = $request->user();

        $history = ProgressTracker::where('user_id', $user->id)
            ->with(['diagnosis:diagnosis_id,addiction_level,brainrot_stage,diagnosed_at'])
            ->latest('tracked_at')
            ->paginate(15);

        return response()->json([
            'status' => 'success',
            'user'   => $user->name,
            'data'   => $history
        ], 200);
    }
}
