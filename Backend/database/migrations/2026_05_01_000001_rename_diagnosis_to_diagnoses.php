<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * إعادة تسمية جدول diagnosis إلى diagnoses لمطابقة اصطلاحات Laravel
     */
    public function up(): void
    {
        Schema::rename('diagnosis', 'diagnoses');
    }

    public function down(): void
    {
        Schema::rename('diagnoses', 'diagnosis');
    }
};
