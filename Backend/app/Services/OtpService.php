<?php

namespace App\Services;

use App\Models\OtpCode;
use App\Mail\OtpMail;
use Illuminate\Support\Facades\Mail;

class OtpService
{
    /**
     * مدة صلاحية الـ OTP بالدقائق
     */
    private const OTP_EXPIRY_MINUTES = 10;

    /**
     * الحد الأقصى لعدد محاولات إرسال OTP في الساعة الواحدة
     */
    private const MAX_ATTEMPTS_PER_HOUR = 5;

    /**
     * إنشاء وإرسال OTP جديد
     *
     * @param string $email
     * @param string $type email_verification | password_reset
     * @return array ['success' => bool, 'message' => string]
     */
    public function generateAndSend(string $email, string $type): array
    {
        // التحقق من عدم تجاوز الحد الأقصى
        $recentCount = OtpCode::where('email', $email)
            ->where('type', $type)
            ->where('created_at', '>=', now()->subHour())
            ->count();

        if ($recentCount >= self::MAX_ATTEMPTS_PER_HOUR) {
            return [
                'success' => false,
                'message' => 'لقد تجاوزت الحد الأقصى لمحاولات الإرسال. حاول مرة أخرى بعد ساعة.',
            ];
        }

        // إلغاء أي أكواد سابقة غير مستخدمة لنفس الإيميل والنوع
        OtpCode::forEmail($email, $type)->valid()->update(['used' => true]);

        // توليد كود عشوائي من 6 أرقام
        $code = str_pad(random_int(0, 999999), 6, '0', STR_PAD_LEFT);

        // حفظ الكود في قاعدة البيانات
        OtpCode::create([
            'email'      => $email,
            'code'       => $code,
            'type'       => $type,
            'expires_at' => now()->addMinutes(self::OTP_EXPIRY_MINUTES),
            'used'       => false,
        ]);

        // إرسال الإيميل
        try {
            Mail::to($email)->send(new OtpMail($code, $type));
        } catch (\Exception $e) {
            \Log::error('Failed to send OTP email', [
                'email' => $email,
                'type'  => $type,
                'error' => $e->getMessage(),
            ]);
            return [
                'success' => false,
                'message' => 'حدث خطأ أثناء إرسال الإيميل. حاول مرة أخرى.',
            ];
        }

        return [
            'success' => true,
            'message' => 'تم إرسال كود التحقق إلى بريدك الإلكتروني.',
        ];
    }

    /**
     * التحقق من صلاحية كود OTP
     *
     * @param string $email
     * @param string $code
     * @param string $type
     * @return array ['valid' => bool, 'message' => string, 'otp' => ?OtpCode]
     */
    public function verify(string $email, string $code, string $type): array
    {
        $otp = OtpCode::forEmail($email, $type)
            ->valid()
            ->where('code', $code)
            ->latest()
            ->first();

        if (!$otp) {
            return [
                'valid'   => false,
                'message' => 'كود التحقق غير صحيح أو منتهي الصلاحية.',
                'otp'     => null,
            ];
        }

        // تعليم الكود كمستخدم
        $otp->markAsUsed();

        return [
            'valid'   => true,
            'message' => 'تم التحقق بنجاح.',
            'otp'     => $otp,
        ];
    }

    /**
     * تنظيف الأكواد المنتهية الصلاحية (يمكن تشغيله كـ scheduled command)
     */
    public function cleanupExpired(): int
    {
        return OtpCode::where('expires_at', '<', now())
            ->orWhere('used', true)
            ->where('created_at', '<', now()->subDay())
            ->delete();
    }
}
