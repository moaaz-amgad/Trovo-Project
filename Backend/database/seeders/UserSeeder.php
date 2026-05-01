<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        $students = [
            ['name' => 'Ahmed Ali', 'student_code' => 'ST001', 'phone' => '01011111111'],
            ['name' => 'Sara Hassan', 'student_code' => 'ST002', 'phone' => '01222222222'],
            ['name' => 'Mohamed Ibrahim', 'student_code' => 'ST003', 'phone' => '01555555555'],
            ['name' => 'Mona Zaki', 'student_code' => 'ST004', 'phone' => '01111111111'],
            ['name' => 'Youssef Mansour', 'student_code' => 'ST005', 'phone' => '01000000000'],
        ];

        foreach ($students as $student) {
            User::updateOrCreate(
                ['student_code' => $student['student_code']],
                [
                    'name' => $student['name'],
                    'phone_number' => $student['phone'],
                    'password' => Hash::make($student['student_code']),
                ]
            );
        }
    }
}
