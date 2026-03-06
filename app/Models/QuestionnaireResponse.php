<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class QuestionnaireResponse extends Model
{
    protected $fillable = [
    'user_id',
    'gender',
    'sleep_hours',
    'academic_performance',
    'social_interaction',
    'exercise_hours',
    'anxiety_level',
    'depression_level',
    'self_esteem',
    'time_on_education',
    'family_communication',
    'answered_at'
];
}
