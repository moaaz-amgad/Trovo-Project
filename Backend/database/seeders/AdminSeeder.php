<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class AdminSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('admins')->insert([
            'name' => 'Super Admin User', // الاسم المعروض
            'username' => 'super_admin',  // اسم المستخدم للدخول
            'password' => Hash::make('admin123'),
            'role' => 'super_admin',
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }
}

