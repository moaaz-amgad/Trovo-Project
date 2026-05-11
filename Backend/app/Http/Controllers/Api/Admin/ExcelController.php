<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;
use App\Imports\UsersImport;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class ExcelController extends Controller
{
    /**
     * رفع ملف الإكسيل واستيراد المستخدمين
     */
    public function import(Request $request)
    {
        $request->validate([
            'file' => 'required|mimes:xlsx,xls,csv'
        ]);

        try {
            Excel::import(new UsersImport, $request->file('file'));
            return response()->json(['message' => 'تم استيراد بيانات المستخدمين بنجاح وبناء حساباتهم'], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'حدث خطأ، تأكد من مطابقة أعمدة الإكسيل (name, email)',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * إضافة مستخدم يدوياً من الداشبورد
     */
    public function storeManual(Request $request)
    {
        $request->validate([
            'name'     => 'required|string|max:255',
            'email'    => 'required|email|unique:users,email',
            'password' => 'nullable|string|min:6',
        ]);

        try {
            $password = $request->password ?? Str::random(10);

            $user = User::create([
                'name'              => $request->name,
                'email'             => strtolower(trim($request->email)),
                'password'          => Hash::make($password),
                'email_verified_at' => now(), // الأدمن تأكد من بياناته بالفعل
            ]);

            return response()->json([
                'status'  => 'success',
                'message' => 'تم تسجيل المستخدم بنجاح. يمكنه الدخول الآن.',
                'data'    => $user,
                'temp_password' => $request->password ? null : $password, // عرض الباسورد المؤقت لو ما اتحددش
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'status'  => 'error',
                'message' => 'فشل في تسجيل المستخدم.',
                'error'   => $e->getMessage()
            ], 500);
        }
    }
}
