<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\PhoneUsageData;

class PhoneUsageController extends Controller
{
    /**
     * تخزين بيانات استخدام الموبايل الجديدة
     */
    public function store(Request $request)
    {
        // 1. التعرف على المستخدم من الـ Token
        $user = $request->user();

        $validatedData = $request->validate([
            'daily_usage_hours'      => 'required|numeric|min:0|max:24',
            'screen_time_before_bed' => 'required|numeric|min:0|max:24',
            'phone_checks_per_day'   => 'required|integer|min:0',
            'apps_used_daily'        => 'required|integer|min:0',
            'time_on_social_media'   => 'required|numeric|min:0|max:24',
            'time_on_gaming'         => 'required|numeric|min:0|max:24',
            'phone_usage_purpose'    => 'required|string|in:Social Media,Gaming,Education,Other',
            'weekend_usage_hours'    => 'required|numeric|min:0|max:24',
        ]);

        // 3. التنفيذ: تخزين البيانات وربطها باليوزر
        $usage = $user->phoneUsages()->create(array_merge($validatedData, [
            'collected_at' => now(),
        ]));

        // 4. الرد النهائي
        return response()->json([
            'status'  => 'success',
            'message' => 'Phone usage data recorded successfully for ' . $user->name,
            'data'    => $usage
        ], 201);
    }

    /**
     * عرض تاريخ الاستخدام الخاص باليوزر الحالي فقط
     */
    public function index(Request $request)
    {
        $user = $request->user();

        // جلب البيانات مرتبة من الأحدث للأقدم
        $history = $user->phoneUsages()->latest('collected_at')->get();

        return response()->json([
            'status' => 'success',
            'user'   => $user->name,
            'count'  => $history->count(),
            'data'   => $history
        ], 200);
    }
}
