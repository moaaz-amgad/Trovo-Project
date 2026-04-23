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
        Schema::create('questionnaire_responses', function (Blueprint $table) {
            $table->id('questionnaire_id'); // غيرتها لـ questionnaire_id لتوحيد العلاقات
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            
            // البيانات الشخصية
            $table->string('gender', 20); // (Male, Female, Other)
            
            $table->float('sleep_hours');
            $table->float('academic_performance'); // من 0 لـ 100
            $table->float('social_interactions');  // من 0 لـ 10
            $table->float('exercise_hours');
            $table->float('anxiety_level');
            $table->float('depression_level');
            $table->float('self_esteem');
            $table->float('time_on_education'); 
            
            $table->timestamp('answered_at')->useCurrent();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('questionnaire_responses');
    }
};