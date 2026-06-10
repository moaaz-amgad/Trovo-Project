<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * جدول جلسات الألعاب الإدراكية (Cognitive Games)
     */
    public function up(): void
    {
        Schema::create('mini_game_sessions', function (Blueprint $table) {
            $table->id();

            $table->foreignId('user_id')
                  ->constrained('users')
                  ->onDelete('cascade');

            $table->string('game_type'); // e.g. stroop, number_letter, attention_span, memory_sequence
            $table->integer('score')->default(0);
            $table->integer('reaction_time_ms')->nullable();
            $table->decimal('accuracy_percentage', 5, 2)->nullable();
            $table->string('difficulty_level')->default('medium'); // easy, medium, hard, etc.
            $table->integer('duration_seconds')->default(0);
            
            // NEW: Detailed metrics specific to each game (JSON)
            $table->json('detailed_metrics')->nullable();

            $table->timestamp('played_at')->useCurrent();
            $table->timestamps();

            $table->index(['user_id', 'played_at'], 'idx_minigame_user_played');
            $table->index('game_type', 'idx_minigame_type');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('mini_game_sessions');
    }
};
