<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Diagnosis;
use App\Models\User;
use Carbon\Carbon;

class DiagnosisSeeder extends Seeder
{
    public function run(): void
    {
        $users = User::all();
        
        foreach ($users as $user) {
            $score = rand(20, 95);
            $stage = $score > 75 ? 'Terminal Brainrot' : ($score > 50 ? 'Advanced Rot' : 'Early Stage');
            
            Diagnosis::create([
                'user_id' => $user->id,
                'addiction_level' => $score,
                'brainrot_stage' => $stage,
                'analysis_intro' => "بناءً على تحليل البيانات، يظهر المستخدم أعراض $stage.",
                'top_factors' => ['TikTok', 'Instagram Reels', 'Late Night Scrolling'],
                'recommendations' => [
                    'تقليل وقت الشاشة بمعدل ساعتين',
                    'تفعيل وضع التركيز (Focus Mode)',
                    'ممارسة نشاط رياضي يومي'
                ],
                'diagnosed_at' => Carbon::now(),
            ]);
        }
    }
}
