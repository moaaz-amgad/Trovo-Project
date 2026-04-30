<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use App\Models\PhoneUsageData;
use App\Models\QuestionnaireResponse;
use App\Models\Diagnosis;
use App\Models\ProgressTracker;
use App\Models\MiniGameSession;

class User extends Authenticatable
{
    use HasApiTokens, Notifiable, HasFactory;

    /**
     * الحقول المسموح بتعبئتها
     */
    protected $fillable = [
        'name',
        'student_code',
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
     * علاقة الطالب ببيانات استخدام الهاتف
     */
    public function phoneUsages()
    {
        return $this->hasMany(PhoneUsageData::class, 'user_id');
    }

    /**
     * علاقة الطالب بإجابات الاستبيان
     */
    public function questionnaireResponses()
    {
        return $this->hasMany(QuestionnaireResponse::class, 'user_id', 'id');
    }

    /**
     * علاقة الطالب بنتائج التشخيص (AI Diagnosis)
     */
    public function diagnoses()
    {
        return $this->hasMany(Diagnosis::class, 'user_id', 'id');
    }

    /**
     * علاقة الطالب بسجلات التقدم
     */
    public function progressTrackers()
    {
        return $this->hasMany(ProgressTracker::class, 'user_id');
    }

    /**
     * علاقة الطالب بجلسات الميني جيم
     */
    public function miniGameSessions()
    {
        return $this->hasMany(MiniGameSession::class, 'user_id');
    }
}
