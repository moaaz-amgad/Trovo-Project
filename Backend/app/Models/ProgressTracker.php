<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ProgressTracker extends Model
{
    protected $table = 'progress_tracking';

    protected $fillable = [
        'user_id',
        'diagnosis_id',
        'previous_diagnosis_id',
        'addiction_level_change',
        'trend',
        'streak_days',
        'notes',
        'tracked_at',
    ];

    protected $casts = [
        'addiction_level_change' => 'float',
        'streak_days'            => 'integer',
        'tracked_at'             => 'datetime',
    ];

    /**
     * علاقة التقدم بالمستخدم
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    /**
     * علاقة التقدم بالتشخيص الحالي
     */
    public function diagnosis(): BelongsTo
    {
        return $this->belongsTo(Diagnosis::class, 'diagnosis_id', 'diagnosis_id');
    }

    /**
     * علاقة التقدم بالتشخيص السابق
     */
    public function previousDiagnosis(): BelongsTo
    {
        return $this->belongsTo(Diagnosis::class, 'previous_diagnosis_id', 'diagnosis_id');
    }
}
