<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * نقل phone_usage_purpose من phone_usage_data إلى questionnaire_responses
     */
    public function up(): void
    {
        // 1. إضافة العمود في جدول الاستبيان
        Schema::table('questionnaire_responses', function (Blueprint $table) {
            $table->string('phone_usage_purpose', 50)->default('Other')->after('time_on_education');
        });

        // 2. نقل البيانات من phone_usage_data إلى questionnaire_responses
        // لكل مستخدم: خذ آخر purpose من phone usage وحطه في آخر questionnaire
        $usages = \DB::table('phone_usage_data')
            ->select('user_id', 'phone_usage_purpose')
            ->whereNotNull('phone_usage_purpose')
            ->orderBy('collected_at', 'desc')
            ->get()
            ->unique('user_id');

        foreach ($usages as $usage) {
            \DB::table('questionnaire_responses')
                ->where('user_id', $usage->user_id)
                ->update(['phone_usage_purpose' => $usage->phone_usage_purpose]);
        }

        // 3. حذف العمود من phone_usage_data
        Schema::table('phone_usage_data', function (Blueprint $table) {
            $table->dropColumn('phone_usage_purpose');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // إرجاع العمود لـ phone_usage_data
        Schema::table('phone_usage_data', function (Blueprint $table) {
            $table->string('phone_usage_purpose', 50)->default('Other')->after('time_on_gaming');
        });

        // حذف العمود من questionnaire_responses
        Schema::table('questionnaire_responses', function (Blueprint $table) {
            $table->dropColumn('phone_usage_purpose');
        });
    }
};
