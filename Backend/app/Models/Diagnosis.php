<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Diagnosis extends Model
{
    use HasFactory;

    // إجبار لارفيل على استخدام اسم الجدول المفرد كما في الميجريشن
    protected $table = 'diagnosis';
    protected $primaryKey = 'diagnosis_id';

    protected $fillable = [
        'user_id',
        'usage_id',
        'questionnaire_id',
        'addiction_level',
        'brain_rot_stage',
        'main_issue',
        'recommendations',
        'diagnosed_at'
    ];

    protected $casts = [
        'addiction_level' => 'float',
        'recommendations' => 'array',
        'diagnosed_at'    => 'datetime',
    ];

    /**
     * علاقة التشخيص بالمستخدم
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    /**
     * علاقة التشخيص ببيانات استخدام الهاتف
     */
    public function phoneUsage(): BelongsTo
    {
        return $this->belongsTo(PhoneUsageData::class, 'usage_id', 'usage_id');
    }

    /**
     * علاقة التشخيص باستجابات الاستبيان
     */
    public function questionnaire(): BelongsTo
    {
        return $this->belongsTo(QuestionnaireResponse::class, 'questionnaire_id', 'questionnaire_id');
    }
}
