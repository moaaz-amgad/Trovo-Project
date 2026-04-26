<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // مسح الجداول القديمة لتجنب أي تعارض في الأسماء أثناء الـ Migration
        Schema::dropIfExists('diagnoses');
        Schema::dropIfExists('diagnosis');

        Schema::create('diagnosis', function (Blueprint $table) {
            $table->id('diagnosis_id');

            // ربط التشخيص بالمستخدم
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');

            // ربط بمصدر البيانات (الاستخدام) - استخدام usage_id كمفتاح
            $table->foreignId('usage_id')
                  ->nullable()
                  ->constrained('phone_usage_data', 'usage_id')
                  ->onDelete('set null');

            // ربط بمصدر البيانات (الاستبيان) - استخدام questionnaire_id كمفتاح
            $table->foreignId('questionnaire_id')
                  ->nullable()
                  ->constrained('questionnaire_responses', 'questionnaire_id')
                  ->onDelete('set null');

            // مخرجات الـ AI المحدثة بناءً على ملف الـ JSON الجديد
            $table->float('addiction_level');           // مستوى الإدمان (addiction_level)
            $table->string('brainrot_stage');          // الحالة (brainrot_stage)
            $table->text('analysis_intro');            // المقدمة التحليلية (analysis_intro)
            $table->json('top_factors');               // العوامل الأساسية (top_factors)
            $table->json('recommendations');           // قائمة النصائح (recommendations)

            // توثيق وقت التشخيص
            $table->timestamp('diagnosed_at')->useCurrent();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('diagnosis');
    }
};

