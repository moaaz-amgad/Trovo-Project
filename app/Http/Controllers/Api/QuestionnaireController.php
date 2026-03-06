<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\QuestionnaireResponse;

class QuestionnaireController extends Controller
{
    public function store(Request $request)
    {
        // 1. الفلتر (Validation): لو أي شرط نقص، لارفيل بيرجع ايرور محدد أوتوماتيك
        $validatedData = $request->validate([
            'gender'               => 'required|string|in:male,female,other', // بيجبره يختار من قيم معينة
            'sleep_hours'          => 'required|integer|min:0|max:24',        // من 0 لـ 24 ساعة
            'academic_performance' => 'required|integer|min:0|max:100',      // من 0 لـ 100%
            'social_interaction'   => 'required|integer|min:0|max:10',       // من 0 لـ 10
            'exercise_hours'       => 'required|numeric|min:0|max:24',
            'anxiety_level'        => 'required|numeric|min:0',              // مستويات دقيقة (double)
            'depression_level'     => 'required|numeric|min:0',
            'self_esteem'          => 'required|integer|min:0|max:100',
            'time_on_education'    => 'required|numeric|min:0|max:24',
            'family_communication' => 'required|integer|min:1|max:10',       // مقياس من 1 لـ 10
        ]);

        // 2. التنفيذ: سحب الـ User من الـ Token وربط الداتا بيه
        $response = $request->user()->questionnaireResponses()->create(array_merge($validatedData, [
            'answered_at' => now(), // بنسجل وقت الإجابة أوتوماتيك من السيرفر
        ]));

        // 3. الرد الناجح
        return response()->json([
            'status'  => 'success',
            'message' => 'Questionnaire recorded successfully for ' . $request->user()->name,
            'data'    => $response
        ], 201);
    }

    public function index(Request $request)
    {
        // عرض تاريخ الإجابات الخاص باليوزر ده بس
        $history = $request->user()->questionnaireResponses()->latest()->get();

        return response()->json([
            'status' => 'success',
            'count'  => $history->count(),
            'data'   => $history
        ], 200);
    }
}
