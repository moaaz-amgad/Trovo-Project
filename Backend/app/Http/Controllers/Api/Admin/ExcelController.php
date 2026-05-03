<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;
use App\Imports\UsersImport;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class ExcelController extends Controller
{
    /**
     * رفع ملف الإكسيل واستيراد الطلاب
     */
    public function import(Request $request)
    {
        $request->validate([
            'file' => 'required|mimes:xlsx,xls,csv'
        ]);

        try {
            Excel::import(new UsersImport, $request->file('file'));
            return response()->json(['message' => 'تم استيراد بيانات الطلاب بنجاح وبناء حساباتهم'], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'حدث خطأ، تأكد من مطابقة أعمدة الإكسيل (name, student_code, phone_number)',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * إضافة طالب يدوياً من الداشبورد
     */
    public function storeManual(Request $request)
    {
        $request->validate([
            'name'         => 'required|string|max:255',
            'student_code' => 'required|string|unique:users,student_code',
            'phone_number' => 'nullable|string',
        ]);

        try {
            $user = User::create([
                'name'         => $request->name,
                'student_code' => $request->student_code,
                'phone_number' => $request->phone_number,
                'password'     => Hash::make($request->student_code), // تلقائياً الباسورد هو الكود
                'is_approved'  => true, // الأدمن تأكد من بياناته بالفعل
            ]);

            return response()->json([
                'status'  => 'success',
                'message' => 'تم تسجيل الطالب بنجاح، ويمكنه الدخول الآن باستخدام الكود الخاص به.',
                'data'    => $user
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'status'  => 'error',
                'message' => 'فشل في تسجيل الطالب.',
                'error'   => $e->getMessage()
            ], 500);
        }
    }
}

