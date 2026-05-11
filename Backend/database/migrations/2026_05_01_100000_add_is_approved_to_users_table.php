<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/**
 * This migration is kept as a no-op for migration history compatibility.
 * The is_approved column has been removed from the users table
 * and replaced with email_verified_at in the new auth system.
 */
return new class extends Migration
{
    public function up(): void
    {
        // No-op: is_approved removed in auth revamp
    }

    public function down(): void
    {
        // No-op
    }
};
