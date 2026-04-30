<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * إضافة فهارس على الأعمدة المستخدمة في الاستعلامات لتحسين الأداء
     */
    public function up(): void
    {
        Schema::table('phone_usage_data', function (Blueprint $table) {
            $table->index(['user_id', 'collected_at'], 'idx_usage_user_collected');
        });

        Schema::table('questionnaire_responses', function (Blueprint $table) {
            $table->index(['user_id', 'answered_at'], 'idx_questionnaire_user_answered');
        });

        Schema::table('diagnoses', function (Blueprint $table) {
            $table->index(['user_id', 'diagnosed_at'], 'idx_diagnosis_user_diagnosed');
            $table->index('brainrot_stage', 'idx_diagnosis_stage');
        });
    }

    public function down(): void
    {
        Schema::table('phone_usage_data', function (Blueprint $table) {
            $table->dropIndex('idx_usage_user_collected');
        });

        Schema::table('questionnaire_responses', function (Blueprint $table) {
            $table->dropIndex('idx_questionnaire_user_answered');
        });

        Schema::table('diagnoses', function (Blueprint $table) {
            $table->dropIndex('idx_diagnosis_user_diagnosed');
            $table->dropIndex('idx_diagnosis_stage');
        });
    }
};
