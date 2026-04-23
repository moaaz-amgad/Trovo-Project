<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('phone_usage_data', function (Blueprint $table) {
            $table->id('usage_id');
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            
            $table->float('daily_usage_hours');
            $table->float('screen_time_before_bed');
            $table->integer('phone_checks_per_day');
            $table->integer('apps_used_daily');
            $table->float('time_on_social_media');
            $table->float('time_on_gaming');
            $table->string('phone_usage_purpose', 50); // (Gaming, Social Media, Education, Other)
            $table->float('weekend_usage_hours');
            
            $table->timestamp('collected_at')->useCurrent();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('phone_usage_data');
    }
};