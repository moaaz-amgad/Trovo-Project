<?php
$user = App\Models\User::first();
if (!$user) {
    echo "No user found\n";
    exit;
}
$service = new App\Services\DiagnosisService();
try {
    $result = $service->generateForUser($user);
    print_r($result);
} catch (\Exception $e) {
    echo "EXCEPTION: " . $e->getMessage() . "\n" . $e->getTraceAsString();
}
