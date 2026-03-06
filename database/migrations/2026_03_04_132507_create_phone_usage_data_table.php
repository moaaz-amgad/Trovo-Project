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
            $table->double('day_usage_hours');
            $table->double('screen_time_beforer_bed');
            $table->integer('phone_chek_per_day');
            $table->integer('apps_used_daily');
            $table->double('time_on_social_media');
            $table->double('time_in_gaming');
            $table->string('phone_usage_purpose', 50);
            $table->double('weekend_usage_hours');
            $table->double('breaks_between_sessions');
            $table->dateTime('collected_at');
            $table->timestamps();
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
