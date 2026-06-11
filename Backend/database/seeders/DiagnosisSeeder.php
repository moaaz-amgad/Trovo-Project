<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Diagnosis;
use App\Models\User;
use App\Models\PhoneUsageData;
use App\Models\QuestionnaireResponse;
use Carbon\Carbon;

class DiagnosisSeeder extends Seeder
{
    public function run(): void
    {
        $users = User::all();

        $factorsList = [
            'Excessive Social Media Usage',
            'Late Night Screen Time',
            'Low Physical Activity',
            'High Anxiety Level',
            'Poor Sleep Quality',
            'Gaming Addiction',
            'Low Academic Focus',
            'Reduced Social Interactions',
        ];

        foreach ($users as $user) {
            // إنشاء بيانات phone usage أولاً
            $usage = PhoneUsageData::create([
                'user_id'                => $user->id,
                'daily_usage_hours'      => round(rand(20, 120) / 10, 1),
                'screen_time_before_bed' => round(rand(5, 40) / 10, 1),
                'phone_checks_per_day'   => rand(20, 150),
                'apps_used_daily'        => rand(3, 20),
                'time_on_social_media'   => round(rand(10, 80) / 10, 1),
                'time_on_gaming'         => round(rand(0, 50) / 10, 1),
                'weekend_usage_hours'    => round(rand(20, 140) / 10, 1),
                'collected_at'           => now(),
            ]);

            // إنشاء بيانات questionnaire
            $questionnaire = QuestionnaireResponse::create([
                'user_id'              => $user->id,
                'gender'               => ['male', 'female'][rand(0, 1)],
                'sleep_hours'          => round(rand(30, 90) / 10, 1),
                'academic_performance' => round(rand(30, 95) / 1, 1),
                'social_interactions'  => round(rand(10, 90) / 10, 1),
                'exercise_hours'       => round(rand(0, 30) / 10, 1),
                'anxiety_level'        => round(rand(10, 90) / 10, 1),
                'depression_level'     => round(rand(10, 80) / 10, 1),
                'self_esteem'          => round(rand(20, 90) / 1, 1),
                'time_on_education'    => round(rand(5, 60) / 10, 1),
                'phone_usage_purpose'  => ['Social Media', 'Gaming', 'Education', 'Other'][rand(0, 3)],
                'answered_at'          => now(),
            ]);

            // مستوى الإدمان من 1 لـ 10 (المقياس الصحيح للـ AI)
            $score = round(rand(10, 100) / 10, 1);
            if ($score <= 3) {
                $stage = 'Mild Brain Rot';
            } elseif ($score <= 6) {
                $stage = 'Moderate Brain Rot';
            } else {
                $stage = 'Severe Brain Rot';
            }

            // اختيار عوامل عشوائية
            shuffle($factorsList);
            $selectedFactors = array_slice($factorsList, 0, rand(2, 4));

            Diagnosis::create([
                'user_id'          => $user->id,
                'usage_id'         => $usage->usage_id,
                'questionnaire_id' => $questionnaire->questionnaire_id,
                'addiction_level'  => $score,
                'brainrot_stage'   => $stage,
                'analysis_intro'   => "Based on the analysis, the user shows patterns consistent with {$stage}. The data indicates significant digital dependency behaviors.",
                'top_factors'      => $selectedFactors,
                'recommendations'  => [
                    'Reduce daily screen time by at least 2 hours',
                    'Enable Focus Mode during study hours',
                    'Practice physical exercise for 30 minutes daily',
                    'Set a digital curfew 1 hour before bed',
                ],
                'diagnosed_at' => Carbon::now()->subDays(rand(0, 14)),
            ]);
        }

        $this->command->info('Diagnoses with phone usage & questionnaire data seeded successfully.');
    }
}
