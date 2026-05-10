<?php

namespace App\Imports;

use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\SkipsEmptyRows;

class UsersImport implements ToModel, WithHeadingRow, SkipsEmptyRows
{
    public function model(array $row)
    {
        // تنظيف البيانات من المسافات الزائدة
        $email = strtolower(trim($row['email']));
        $name  = trim($row['name']);

        // توليد باسورد عشوائي للمستخدمين المستوردين
        $password = $row['password'] ?? Str::random(10);

        // تحديث أو إنشاء مستخدم جديد بناءً على الإيميل
        return User::updateOrCreate(
            ['email' => $email],
            [
                'name'              => $name,
                'password'          => Hash::make($password),
                'email_verified_at' => now(), // الأدمن تأكد من بياناتهم بالفعل
            ]
        );
    }
}
