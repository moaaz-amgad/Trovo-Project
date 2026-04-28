<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;
use App\Imports\UsersImport;

class ExcelController extends Controller
{
    public function import(Request $request)
    {
        // التحقق إن فيه ملف مرفوع وإنه إكسيل
        $request->validate([
            'file' => 'required|mimes:xlsx,xls,csv'
        ]);

        try {
            Excel::import(new UsersImport, $request->file('file'));
            return response()->json(['message' => 'تم استيراد بيانات الطلاب بنجاح وبناء حساباتهم'], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'حدث خطأ أثناء الرفع، تأكد من مطابقة أعمدة الإكسيل للكود',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}

