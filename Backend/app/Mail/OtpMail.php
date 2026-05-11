<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class OtpMail extends Mailable
{
    use Queueable, SerializesModels;

    public string $otpCode;
    public string $type;
    public int $expiryMinutes;

    /**
     * Create a new message instance.
     */
    public function __construct(string $otpCode, string $type)
    {
        $this->otpCode = $otpCode;
        $this->type = $type;
        $this->expiryMinutes = 10;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        $subject = $this->type === 'email_verification'
            ? 'Trovo - Verify Your Email Address'
            : 'Trovo - Reset Your Password';

        return new Envelope(
            subject: $subject,
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            view: 'emails.otp',
            with: [
                'otpCode'       => $this->otpCode,
                'type'          => $this->type,
                'expiryMinutes' => $this->expiryMinutes,
            ],
        );
    }
}
