<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) {
        // 1. استثناء مسارات الـ API من فحص الـ CSRF لضمان عمل الـ Login بدون تعارض
        $middleware->validateCsrfTokens(except: [
            'api/*',
        ]);

        // 2. تفعيل الـ Stateful API لدعم المصادقة عبر الـ Cookies والـ Tokens بشكل صحيح
        $middleware->statefulApi();
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })->create();

