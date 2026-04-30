<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * جدول جلسات الميني جيم للتقييم الإدراكي
     */
    public function up(): void
    {
        Schema::create('mini_game_sessions', function (Blueprint $table) {
            $table->id();

            $table->foreignId('user_id')
                  ->constrained('users')
                  ->onDelete('cascade');

            $table->enum('game_type', ['memory', 'reaction', 'focus', 'pattern']);
            $table->integer('score')->default(0);
            $table->integer('reaction_time_ms')->nullable();
            $table->decimal('accuracy_percentage', 5, 2)->nullable();
            $table->enum('difficulty_level', ['easy', 'medium', 'hard'])->default('medium');
            $table->integer('duration_seconds');

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
