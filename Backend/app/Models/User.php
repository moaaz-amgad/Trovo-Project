<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use App\Models\PhoneUsageData;
use App\Models\QuestionnaireResponse;
use App\Models\Diagnosis;

class User extends Authenticatable
{
    use HasApiTokens, Notifiable, HasFactory;

    /**
     * الحقول المسموح بتعبئتها (تتوافق تماماً مع الميجريشن الحالي)
     */
    protected $fillable = [
        'name',
        'student_code', // اليوزر نيم والباسورد الافتراضي
        'phone_number',
        'password',
    ];

    /**
     * الحقول المخفية عند جلب البيانات
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * تحويل أنواع البيانات (Casting)
     */
    protected function casts(): array
    {
        return [
            'password' => 'hashed',
        ];
    }

    /*
    |--------------------------------------------------------------------------
    | العلاقات (Relationships)
    |--------------------------------------------------------------------------
    */

    /**
     * علاقة الطالب ببيانات استخدام الهاتف (تلقائي من التطبيق)
     * مربوطة بـ usage_id في جدول phone_usage_data
     */
    public function phoneUsages()
    {
        return $this->hasMany(PhoneUsageData::class, 'user_id');
    }

    /**
     * علاقة الطالب بإجابات الاستبيان
     * مربوطة بـ questionnaire_id في جدول questionnaire_responses
     */
    public function questionnaireResponses()
    {
        return $this->hasMany(QuestionnaireResponse::class, 'user_id', 'id');
    }

    /**
     * علاقة الطالب بنتائج التشخيص (AI Diagnosis)
     */
    public function diagnosis()
    {
        return $this->hasMany(Diagnosis::class, 'user_id', 'id');
    }
}

