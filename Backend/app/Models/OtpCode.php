<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OtpCode extends Model
{
    protected $fillable = [
        'email',
        'code',
        'type',
        'expires_at',
        'used',
    ];

    protected function casts(): array
    {
        return [
            'expires_at' => 'datetime',
            'used'       => 'boolean',
        ];
    }

    /*
    |--------------------------------------------------------------------------
    | Scopes
    |--------------------------------------------------------------------------
    */

    /**
     * كود صالح (لم يُستخدم + لم ينتهي صلاحيته)
     */
    public function scopeValid($query)
    {
        return $query->where('used', false)
                     ->where('expires_at', '>', now());
    }

    /**
     * فلترة حسب الإيميل والنوع
     */
    public function scopeForEmail($query, string $email, string $type)
    {
        return $query->where('email', $email)
                     ->where('type', $type);
    }

    /*
    |--------------------------------------------------------------------------
    | Methods
    |--------------------------------------------------------------------------
    */

    /**
     * التحقق من صلاحية الكود
     */
    public function isValid(): bool
    {
        return !$this->used && $this->expires_at->isFuture();
    }

    /**
     * تعليم الكود كمستخدم
     */
    public function markAsUsed(): void
    {
        $this->update(['used' => true]);
    }
}
