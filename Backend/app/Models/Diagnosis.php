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
        'addiction_level',    // Score from 1-10
        'brainrot_stage',     // Mild / Moderate / Severe Brain Rot
        'analysis_intro',
        'top_factors',        // JSON array
        'recommendations',    // JSON array
        'diagnosed_at'
    ];

    protected $casts = [
        'top_factors'     => 'array',
        'recommendations' => 'array',
        'addiction_level'  => 'float',
        'diagnosed_at'     => 'datetime',
    ];

    /**
     * العلاقة مع المستخدم
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    /**
     * العلاقة مع بيانات استخدام الهاتف
     */
    public function phoneUsage()
    {
        return $this->belongsTo(PhoneUsageData::class, 'usage_id', 'usage_id');
    }

    /**
     * العلاقة مع الاستبيان
     */
    public function questionnaire()
    {
        return $this->belongsTo(QuestionnaireResponse::class, 'questionnaire_id', 'questionnaire_id');
    }
}
