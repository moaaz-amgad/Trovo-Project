<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * إضافة عمود is_approved لجدول المستخدمين
     * للتفريق بين الطلاب المعتمدين وغير المعتمدين في الداشبورد
     */
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->boolean('is_approved')->default(false)->after('password');
            $table->index('is_approved', 'idx_users_approved');
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropIndex('idx_users_approved');
            $table->dropColumn('is_approved');
        });
    }
};
