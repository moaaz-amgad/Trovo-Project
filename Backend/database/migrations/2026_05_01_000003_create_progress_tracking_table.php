<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * جدول تتبع التقدم — يربط بين تشخيصين متتاليين لحساب الاتجاه
     */
    public function up(): void
    {
        Schema::create('progress_tracking', function (Blueprint $table) {
            $table->id();

            $table->foreignId('user_id')
                  ->constrained('users')
                  ->onDelete('cascade');

            $table->foreignId('diagnosis_id')
                  ->constrained('diagnoses', 'diagnosis_id')
                  ->onDelete('cascade');

            $table->unsignedBigInteger('previous_diagnosis_id')->nullable();
            $table->foreign('previous_diagnosis_id')
                  ->references('diagnosis_id')
                  ->on('diagnoses')
                  ->onDelete('set null');

            $table->decimal('addiction_level_change', 5, 2)->default(0);
            $table->enum('trend', ['improving', 'stable', 'worsening'])->default('stable');
            $table->integer('streak_days')->default(0);
            $table->text('notes')->nullable();

            $table->timestamp('tracked_at')->useCurrent();
            $table->timestamps();

            $table->index(['user_id', 'tracked_at'], 'idx_progress_user_tracked');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('progress_tracking');
    }
};
