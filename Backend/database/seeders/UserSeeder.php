<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        $users = [
            ['name' => 'Ahmed Ali',         'email' => 'ahmed@trovo.test'],
            ['name' => 'Sara Hassan',        'email' => 'sara@trovo.test'],
            ['name' => 'Mohamed Ibrahim',    'email' => 'mohamed@trovo.test'],
            ['name' => 'Mona Zaki',          'email' => 'mona@trovo.test'],
            ['name' => 'Youssef Mansour',    'email' => 'youssef@trovo.test'],
        ];

        foreach ($users as $userData) {
            User::updateOrCreate(
                ['email' => $userData['email']],
                [
                    'name'              => $userData['name'],
                    'password'          => Hash::make('password'),
                    'email_verified_at' => now(),
                ]
            );
        }
    }
}
