<?php

namespace App\Imports;

use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class UsersImport implements ToModel, WithHeadingRow
{
    public function model(array $row)
    {
        // خد كل صف من الإكسيل واعمل بيه يوزر جديد
        return new User([
            'name'         => $row['name'],
            'student_code' => $row['student_code'],
            'phone_number' => $row['phone_number'] ?? null,
            'email'        => $row['email'] ?? null,
            'password'     => Hash::make($row['student_code']), // الباسورد الافتراضي هو كود الطالب
            'role'         => 'student', // أي حد بيترفع من هنا هو طالب
        ]);
    }
}
