<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\DiagnosisService;
use App\Services\ProgressService;
use Illuminate\Http\JsonResponse;

class DiagnosisController extends Controller
{
    public function __construct(
        private DiagnosisService $diagnosisService,
        private ProgressService $progressService
    ) {}

    /**
     * إنشاء تشخيص جديد باستخدام الذكاء الاصطناعي
     */
    public function generate(Request $request): JsonResponse
    {
        $user = $request->user();

        $result = $this->diagnosisService->generateForUser($user);

        // تتبع التقدم إذا تم إنشاء تشخيص جديد بنجاح
        if ($result['status'] === 'success' && $result['code'] === 201 && isset($result['data'])) {
            $this->progressService->trackAfterDiagnosis($user, $result['data']);
        }

        return response()->json([
            'status'  => $result['status'],
            'message' => $result['message'],
            'data'    => $result['data'] ?? null
        ], $result['code']);
    }

    /**
     * عرض تاريخ التشخيصات للطالب الحالي فقط
     */
    public function index(Request $request): JsonResponse
    {
        $user = $request->user();

        $history = $user->diagnoses()
                        ->with(['phoneUsage', 'questionnaire'])
                        ->latest('diagnosed_at')
                        ->paginate(15);

        return response()->json([
            'status' => 'success',
            'user'   => $user->name,
            'data'   => $history
        ], 200);
    }
}
