<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ $type === 'email_verification' ? 'Verify Your Email' : 'Reset Your Password' }}</title>
</head>
<body style="margin: 0; padding: 0; background-color: #f0f4f8; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">
    <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: #f0f4f8; padding: 40px 0;">
        <tr>
            <td align="center">
                <table role="presentation" width="480" cellspacing="0" cellpadding="0" style="background-color: #ffffff; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 24px rgba(0,0,0,0.08);">

                    {{-- Header with gradient --}}
                    <tr>
                        <td style="background: linear-gradient(135deg, #0d9488 0%, #14b8a6 50%, #2dd4bf 100%); padding: 40px 32px; text-align: center;">
                            <h1 style="margin: 0; color: #ffffff; font-size: 28px; font-weight: 700; letter-spacing: 2px;">
                                TROVO
                            </h1>
                            <p style="margin: 8px 0 0 0; color: rgba(255,255,255,0.85); font-size: 14px; font-weight: 400;">
                                Digital Wellness Diagnostic Platform
                            </p>
                        </td>
                    </tr>

                    {{-- Body --}}
                    <tr>
                        <td style="padding: 40px 32px;">
                            {{-- Icon --}}
                            <div style="text-align: center; margin-bottom: 24px;">
                                @if($type === 'email_verification')
                                    <div style="display: inline-block; width: 64px; height: 64px; background: linear-gradient(135deg, #e0f2f1, #b2dfdb); border-radius: 50%; line-height: 64px; font-size: 28px;">
                                        ✉️
                                    </div>
                                @else
                                    <div style="display: inline-block; width: 64px; height: 64px; background: linear-gradient(135deg, #fff3e0, #ffe0b2); border-radius: 50%; line-height: 64px; font-size: 28px;">
                                        🔐
                                    </div>
                                @endif
                            </div>

                            <h2 style="margin: 0 0 12px 0; color: #1a1a2e; font-size: 22px; font-weight: 600; text-align: center;">
                                @if($type === 'email_verification')
                                    Verify Your Email Address
                                @else
                                    Reset Your Password
                                @endif
                            </h2>

                            <p style="margin: 0 0 28px 0; color: #64748b; font-size: 15px; line-height: 1.6; text-align: center;">
                                @if($type === 'email_verification')
                                    Welcome to Trovo! Please use the verification code below to confirm your email address and activate your account.
                                @else
                                    We received a request to reset your password. Use the code below to set a new password for your account.
                                @endif
                            </p>

                            {{-- OTP Code Box --}}
                            <div style="background: linear-gradient(135deg, #f8fffe, #e0f7f5); border: 2px dashed #0d9488; border-radius: 12px; padding: 24px; text-align: center; margin: 0 0 24px 0;">
                                <p style="margin: 0 0 8px 0; color: #64748b; font-size: 13px; font-weight: 500; text-transform: uppercase; letter-spacing: 1px;">
                                    Your Verification Code
                                </p>
                                <p style="margin: 0; color: #0d9488; font-size: 40px; font-weight: 700; letter-spacing: 12px; font-family: 'Courier New', monospace;">
                                    {{ $otpCode }}
                                </p>
                            </div>

                            {{-- Expiry Warning --}}
                            <div style="background-color: #fffbeb; border-left: 4px solid #f59e0b; border-radius: 0 8px 8px 0; padding: 12px 16px; margin: 0 0 24px 0;">
                                <p style="margin: 0; color: #92400e; font-size: 13px; line-height: 1.5;">
                                    ⏱ This code will expire in <strong>{{ $expiryMinutes }} minutes</strong>. If you didn't request this, please ignore this email.
                                </p>
                            </div>

                            {{-- Security Note --}}
                            <p style="margin: 0; color: #94a3b8; font-size: 12px; line-height: 1.5; text-align: center;">
                                🔒 Never share this code with anyone. Trovo team will never ask for your verification code.
                            </p>
                        </td>
                    </tr>

                    {{-- Footer --}}
                    <tr>
                        <td style="background-color: #f8fafc; padding: 20px 32px; border-top: 1px solid #e2e8f0; text-align: center;">
                            <p style="margin: 0 0 4px 0; color: #94a3b8; font-size: 12px;">
                                &copy; {{ date('Y') }} Trovo. All rights reserved.
                            </p>
                            <p style="margin: 0; color: #cbd5e1; font-size: 11px;">
                                This is an automated message. Please do not reply.
                            </p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
