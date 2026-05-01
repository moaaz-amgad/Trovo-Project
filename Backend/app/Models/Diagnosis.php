<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Diagnosis extends Model
{
    use HasFactory;

    protected $table = 'diagnoses';
    protected $primaryKey = 'diagnosis_id';

    protected $fillable = [
        'user_id',
        'usage_id',
        'questionnaire_id',
        'addiction_level',    // الـ Score الرقمي
        'brainrot_stage',     // الحالة (Mild, Severe...)
        'analysis_intro',
        'top_factors',        // JSON array
        'recommendations',    // JSON array
        'diagnosed_at'
    ];

    protected $casts = [
        'top_factors' => 'array',
        'recommendations' => 'array',
        'addiction_level' => 'float',
        'diagnosed_at' => 'datetime',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
