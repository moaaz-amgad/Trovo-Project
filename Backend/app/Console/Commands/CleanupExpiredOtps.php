<?php

namespace App\Console\Commands;

use App\Services\OtpService;
use Illuminate\Console\Command;

class CleanupExpiredOtps extends Command
{
    /**
     * اسم الأمر والوصف
     */
    protected $signature = 'otp:cleanup';
    protected $description = 'تنظيف أكواد OTP المنتهية الصلاحية والمستخدمة من قاعدة البيانات';

    /**
     * تنفيذ الأمر
     */
    public function handle(OtpService $otpService): int
    {
        $deleted = $otpService->cleanupExpired();

        $this->info("✅ تم حذف {$deleted} كود OTP منتهي الصلاحية.");

        return Command::SUCCESS;
    }
}
