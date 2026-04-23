<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class QuestionnaireResponse extends Model
{
    protected $primaryKey = 'questionnaire_id';

    protected $fillable = [
        'user_id',
        'gender',
        'sleep_hours',
        'academic_performance',
        'social_interactions',
        'exercise_hours',
        'anxiety_level',
        'depression_level',
        'self_esteem',
        'time_on_education',
        'answered_at'
    ];

    protected $casts = [
        'sleep_hours'          => 'float',
        'academic_performance' => 'float',
        'social_interactions'  => 'float',
        'exercise_hours'       => 'float',
        'anxiety_level'        => 'float',
        'depression_level'     => 'float',
        'self_esteem'          => 'float',
        'time_on_education'    => 'float',
        'answered_at'          => 'datetime',
    ];

    /**
     * علاقة الاستبيان بالمستخدم
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }
public $timestamps = false;

}
