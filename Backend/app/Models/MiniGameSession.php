<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class MiniGameSession extends Model
{
    protected $table = 'mini_game_sessions';

    protected $fillable = [
        'user_id',
        'game_type',
        'score',
        'reaction_time_ms',
        'accuracy_percentage',
        'difficulty_level',
        'duration_seconds',
        'played_at',
    ];

    protected $casts = [
        'score'               => 'integer',
        'reaction_time_ms'    => 'integer',
        'accuracy_percentage' => 'float',
        'duration_seconds'    => 'integer',
        'played_at'           => 'datetime',
    ];

    /**
     * علاقة جلسة اللعبة بالمستخدم
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
