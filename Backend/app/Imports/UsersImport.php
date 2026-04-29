<?php

namespace App\Imports;

use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\SkipsEmptyRows;

class UsersImport implements ToModel, WithHeadingRow, SkipsEmptyRows
{
    public function model(array $row)
    {
        // التحقق من وجود الكود لمنع التكرار أو الصفوف الفارغة
        if (!isset($row['student_code'])) {
            return null;
        }

        // تحديث أو إنشاء طالب جديد بناءً على الكود
        return User::updateOrCreate(
            ['student_code' => $row['student_code']], // حقل البحث لمنع التكرار
            [
                'name'         => $row['name'],
                'phone_number' => $row['phone_number'] ?? null,
                'password'     => Hash::make($row['student_code']), // الباسورد الافتراضي هو الكود
            ]
        );
    }
}

