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
        // تنظيف البيانات من المسافات الزائدة
        $studentCode = trim($row['student_code']);
        $name = trim($row['name']);
        $phoneNumber = isset($row['phone_number']) ? trim($row['phone_number']) : null;

        // تحديث أو إنشاء طالب جديد بناءً على الكود
        return User::updateOrCreate(
            ['student_code' => $studentCode],
            [
                'name'         => $name,
                'phone_number' => $phoneNumber,
                'password'     => Hash::make($studentCode),
                'is_approved'  => true, // الأدمن تأكد من بياناتهم بالفعل
            ]
        );
    }
}

