<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            AdminSeeder::class,     // الأدمنز أولاً
            // UserSeeder::class,      // Students removed for production
            // DiagnosisSeeder::class, // Fake diagnoses removed for production
        ]);
    }
}