<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PhoneUsageData extends Model
{
    protected $table = 'phone_usage_data';
    protected $primaryKey = 'usage_id';
    public $timestamps = false; // لأننا نستخدم collected_at يدوياً

    protected $fillable = [
        'user_id',
        'daily_usage_hours',
        'screen_time_before_bed',
        'phone_checks_per_day',
        'apps_used_daily',
        'time_on_social_media',
        'time_on_gaming',
        'phone_usage_purpose',
        'weekend_usage_hours',
        'collected_at'
    ];

    protected $casts = [
        'daily_usage_hours'      => 'float',
        'screen_time_before_bed' => 'float',
        'time_on_social_media'   => 'float',
        'time_on_gaming'         => 'float',
        'weekend_usage_hours'    => 'float',
        'collected_at'           => 'datetime',
    ];

    /**
     * العلاقة مع الطالب
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}

