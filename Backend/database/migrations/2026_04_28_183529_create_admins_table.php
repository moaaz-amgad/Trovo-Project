<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     * هذا الجدول منفصل تماماً عن جدول الطلاب لضمان أقصى درجات الأمان والخصوصية
     */
    public function up(): void
    {
        Schema::create('admins', function (Blueprint $table) {
            $table->id();
            $table->string('name')->nullable(); // اسم المدير للعرض في الداشبورد
            $table->string('username')->unique(); // اسم المستخدم للدخول
            $table->string('password'); // كلمة المرور المشفرة

            // تحديد الصلاحيات:
            // super_admin: له كل الصلاحيات (حذف، تعديل، إضافة مديرين)
            // admin: لمتابعة الإحصائيات وتشخيصات الطلاب فقط
            $table->enum('role', ['super_admin', 'admin'])->default('admin');

            $table->rememberToken(); // مهم لو فعلت خاصية "تذكرني" في لوحة التحكم
            $table->timestamps(); // تاريخ الإنشاء والتحديث
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('admins');
    }
};

