<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\QuestionnaireResponse;

class QuestionnaireController extends Controller
{
    /**
     * تخزين إجابة استبيان جديدة
     */
    public function store(Request $request)
    {
        // 1. سحب اليوزر من الـ Token
        $user = $request->user();

        // 2. الفلتر (Validation): تعديل المسميات والأنواع لتناسب الـ AI والميجريشن
        $validatedData = $request->validate([
            'gender'               => 'required|string|in:male,female,other',
            'sleep_hours'          => 'required|numeric|min:0|max:24', // تغيير لـ numeric عشان الساعات الكسرية
            'academic_performance' => 'required|numeric|min:0|max:100',
            'social_interactions'  => 'required|numeric|min:0|max:10', // إضافة حرف الـ s وتغيير لـ numeric
            'exercise_hours'       => 'required|numeric|min:0|max:24',
            'anxiety_level'        => 'required|numeric|min:0',
            'depression_level'     => 'required|numeric|min:0',
            'self_esteem'          => 'required|numeric|min:0|max:100',
            'time_on_education'    => 'required|numeric|min:0|max:24',
        ]);

        // 3. التنفيذ: استخدام العلاقة لتخزين البيانات
        // يتم وضع الـ user_id والـ answered_at أوتوماتيكياً
        $response = $user->questionnaireResponses()->create(array_merge($validatedData, [
            'answered_at' => now(),
        ]));

        // 4. الرد النهائي الموحد
        return response()->json([
            'status'  => 'success',
            'message' => 'Questionnaire recorded successfully for ' . $user->name,
            'data'    => $response
        ], 201);
    }

    /**
     * عرض تاريخ الاستبيانات الخاص باليوزر الحالي فقط
     */
    public function index(Request $request)
    {
        $user = $request->user();

        // جلب البيانات مرتبة من الأحدث للأقدم
        $history = $user->questionnaireResponses()
                    ->orderBy('answered_at', 'desc')
                    ->get();

        return response()->json([
            'status' => 'success',
            'user'   => $user->name,
            'count'  => $history->count(),
            'data'   => $history
        ], 200);
    }
}
