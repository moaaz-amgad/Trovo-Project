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

    protected $fillable = [
        'name',
        'student_code',
        'phone_number',
        'email',
        'password',
        'role',
        'google_id',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    public function isSuperAdmin(): bool
    {
        return $this->role === 'super_admin';
    }

    public function isAdmin(): bool
    {
        return in_array($this->role, ['admin', 'super_admin']);
    }

    public function isStudent(): bool
    {
        return $this->role === 'student';
    }

    public function phoneUsages()
    {
        return $this->hasMany(PhoneUsageData::class, 'user_id');
    }

    public function questionnaireResponses()
    {
        return $this->hasMany(QuestionnaireResponse::class, 'user_id', 'id');
    }

    public function diagnosis()
    {
        return $this->hasMany(Diagnosis::class, 'user_id', 'id');
    }
}

