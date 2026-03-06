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
            $table->id('response_id');
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->string('gender', 20);
            $table->smallInteger('sleep_hours');
            $table->integer('academic_performance'); // من 0 لـ 100
            $table->smallInteger('social_interaction'); // من 0 لـ 10
            $table->double('exercise_hours');
            $table->double('anxiety_level');
            $table->double('depression_level');
            $table->integer('self_esteem');
            $table->double('time_on_education');
            $table->integer('family_communication');
            $table->dateTime('answered_at');
            $table->timestamps();
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
