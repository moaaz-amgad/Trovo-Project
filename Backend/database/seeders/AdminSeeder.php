<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Admin;
use Illuminate\Support\Facades\Hash;

class AdminSeeder extends Seeder
{
    public function run(): void
    {
        // 1. Super Admin
        Admin::updateOrCreate(
            ['username' => 'super_admin'],
            [
                'name' => 'Super Admin',
                'password' => Hash::make('admin123'),
                'role' => 'super_admin',
            ]
        );

        // 2. Regular Admin
        Admin::updateOrCreate(
            ['username' => 'operator_1'],
            [
                'name' => 'Operator One',
                'password' => Hash::make('admin123'),
                'role' => 'admin',
            ]
        );
    }
}
