<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PhoneUsageData extends Model
{
    protected $table = 'phone_usage_data';
    protected $primaryKey = 'usage_id';

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

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
public $timestamps = false;
}
