<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PhoneUsageData extends Model
{
    protected $table = 'phone_usage_data';
    protected $primaryKey = 'usage_id';

    protected $fillable = [
        'user_id',
        'diagnosis_id',
        'day_usage_hours',
        'screen_time_beforer_bed',
        'phone_chek_per_day',
        'apps_used_daily',
        'time_on_social_media',
        'time_in_gaming',
        'phone_usage_purpose',
        'weekend_usage_hours',
        'breaks_between_sessions',
        'collected_at'
    ];

    protected $casts = [
        'collected_at' => 'datetime',
    ];

    public function user()
    {
    return $this->belongsTo(User::class, 'user_id');
    }
}
