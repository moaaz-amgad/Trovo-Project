<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\PhoneUsageData;
use Carbon\Carbon;

class PhoneUsageController extends Controller
{
    public function store(Request $request)
    {
        // 1. دي أهم حتة: لارفيل بيعرف اليوزر من الـ Token اللي مبعوث في الـ Postman
        $user = $request->user();

        // --- التعديل الجديد: الـ Validation ---
        // السطر ده بيتأكد إن كل البيانات موجودة وبالنوع الصح قبل ما يكمل
        $validatedData = $request->validate([
            'day_usage_hours'          => 'required|numeric',
            'screen_time_beforer_bed'  => 'required|numeric',
            'phone_chek_per_day'       => 'required|integer',
            'apps_used_daily'          => 'required|integer',
            'time_on_social_media'     => 'required|numeric',
            'time_in_gaming'           => 'required|numeric',
            'phone_usage_purpose'      => 'required|string|max:255',
            'weekend_usage_hours'      => 'required|numeric',
            'breaks_between_sessions'  => 'required|numeric',
        ]);

        // 2. بنستخدم الـ $validatedData المفلترة عشان نخزنها
        // وبنضيف عليها الـ collected_at يدوي
        $usage = $user->phoneUsages()->create(array_merge($validatedData, [
            'collected_at' => now(),
        ]));

        // 3. رد السيرفر على الموبايل إن العملية تمت بنجاح
        return response()->json([
            'status'  => 'success',
            'message' => 'Data recorded for ' . $user->name,
            'data'    => $usage
        ], 201);
    }

    public function index(Request $request)
    {
        // هنجيب اليوزر من التوكن
        $user = $request->user();

        // هنجيب كل بيانات الموبايل الخاصة باليوزر ده فقط
        // مرتبة من الأحدث للأقدم
        $history = $user->phoneUsages()->latest()->get();

        return response()->json([
            'status' => 'success',
            'user'   => $user->name,
            'count'  => $history->count(),
            'data'   => $history
        ], 200);
    }

    public function logout(Request $request)
{
    // حذف التوكن الحالي اللي اليوزر مستخدمه دلوقتي عشان ميعرفش يدخل بيه تاني
    $request->user()->currentAccessToken()->delete();

    return response()->json([
        'status' => 'success',
        'message' => 'Logged out successfully. Token revoked.'
    ], 200);
}

}
