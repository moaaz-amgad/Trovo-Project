<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Admin;
use Illuminate\Support\Facades\Hash;

class AdminSeeder extends Seeder
{
    /**
     * إنشاء حسابات الأدمن الثابتة — حسابان فقط
     * يتم تشغيلهم مرة واحدة: php artisan db:seed --class=AdminSeeder
     */
    public function run(): void
    {
        $admin1User = env('ADMIN1_USER', 'admin1');
        $admin1Pass = env('ADMIN1_PASS', 'admin123');

        $admin2User = env('ADMIN2_USER', 'admin2');
        $admin2Pass = env('ADMIN2_PASS', 'admin123');

        // الأدمن الأول
        Admin::updateOrCreate(
            ['username' => $admin1User],
            [
                'name'     => 'Main Admin',
                'password' => Hash::make($admin1Pass),
                'role'     => 'admin',
            ]
        );

        // الأدمن الثاني
        Admin::updateOrCreate(
            ['username' => $admin2User],
            [
                'name'     => 'Secondary Admin',
                'password' => Hash::make($admin2Pass),
                'role'     => 'admin',
            ]
        );

        $this->command->info('✅ 2 Admin accounts created/updated successfully from .env');
    }
}
