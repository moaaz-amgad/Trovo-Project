<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\QuestionnaireResponse;
use Illuminate\Http\JsonResponse;

class QuestionnaireController extends Controller
{
    /**
     * تخزين إجابة استبيان جديدة
     */
    public function store(Request $request): JsonResponse
    {
        $user = $request->user();

        $validatedData = $request->validate([
            'gender'               => 'required|string|in:male,female,other',
            'sleep_hours'          => 'required|numeric|min:0|max:24',
            'academic_performance' => 'required|numeric|min:0|max:100',
            'social_interactions'  => 'required|numeric|min:0|max:10',
            'exercise_hours'       => 'required|numeric|min:0|max:24',
            'anxiety_level'        => 'required|numeric|min:0',
            'depression_level'     => 'required|numeric|min:0',
            'self_esteem'          => 'required|numeric|min:0|max:100',
            'time_on_education'    => 'required|numeric|min:0|max:24',
        ]);

        $response = $user->questionnaireResponses()->create(array_merge($validatedData, [
            'answered_at' => now(),
        ]));

        return response()->json([
            'status'  => 'success',
            'message' => 'Questionnaire recorded successfully for ' . $user->name,
            'data'    => $response
        ], 201);
    }

    /**
     * عرض تاريخ الاستبيانات الخاص باليوزر الحالي فقط — مع Pagination
     */
    public function index(Request $request): JsonResponse
    {
        $user = $request->user();

        $history = $user->questionnaireResponses()
                    ->orderBy('answered_at', 'desc')
                    ->paginate(15);

        return response()->json([
            'status' => 'success',
            'user'   => $user->name,
            'data'   => $history
        ], 200);
    }
}
