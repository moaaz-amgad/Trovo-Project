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
        'email',
        'password',
        'email_verified_at',
        'google_id',
        'avatar',
    ];

    /**
     * الحقول المخفية عند جلب البيانات
     */
    protected $hidden = [
        'password',
        'remember_token',
        'google_id',
    ];

    /**
     * تحويل أنواع البيانات (Casting)
     */
    protected function casts(): array
    {
        return [
            'password'          => 'hashed',
            'email_verified_at' => 'datetime',
        ];
    }

    /**
     * التحقق من تأكيد الإيميل
     */
    public function isVerified(): bool
    {
        return $this->email_verified_at !== null;
    }

    /**
     * التحقق من أن الحساب مرتبط بجوجل
     */
    public function isGoogleUser(): bool
    {
        return $this->google_id !== null;
    }

    /*
    |--------------------------------------------------------------------------
    | العلاقات (Relationships)
    |--------------------------------------------------------------------------
    */

    /**
     * علاقة المستخدم ببيانات استخدام الهاتف
     */
    public function phoneUsages()
    {
        return $this->hasMany(PhoneUsageData::class, 'user_id');
    }

    /**
     * علاقة المستخدم بإجابات الاستبيان
     */
    public function questionnaireResponses()
    {
        return $this->hasMany(QuestionnaireResponse::class, 'user_id', 'id');
    }

    /**
     * علاقة المستخدم بنتائج التشخيص (AI Diagnosis)
     */
    public function diagnoses()
    {
        return $this->hasMany(Diagnosis::class, 'user_id', 'id');
    }

    /**
     * أحدث تشخيص للمستخدم
     */
    public function latestDiagnosis()
    {
        return $this->hasOne(Diagnosis::class)->latestOfMany('diagnosed_at');
    }

    /**
     * علاقة المستخدم بسجلات التقدم
     */
    public function progressTrackers()
    {
        return $this->hasMany(ProgressTracker::class, 'user_id');
    }

    /**
     * علاقة المستخدم بجلسات الميني جيم
     */
    public function miniGameSessions()
    {
        return $this->hasMany(MiniGameSession::class, 'user_id');
    }
}
