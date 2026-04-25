🚀 Trovo API Documentation & Automated Workflows
This folder contains the official Postman Collection for the Trovo Project. It is designed to provide a seamless integration experience for Mobile and Frontend developers with the Digital Dopamine Addiction Diagnosis System.

📂 Contents
collection.json: Includes Auth operations, usage data recording, questionnaires, and AI-driven diagnosis.

environment.json: Storage for dynamic variables such as {{railway-URL}} and {{token}}.

⚙️ Setup & Installation
Import: Drag and drop the JSON files into your Postman app.

Environment: Select the Trovo-Prod environment from the environment selector (top-right corner).

Base URL: The {{railway-URL}} variable points to the server hosted on Railway: https://trovo-project-production.up.railway.app/api.

⚡ Automated Features (Smart Scripts)
Post-response Scripts have been programmed to automate processes and reduce manual copying and pasting:

Authentication: The Login and Register requests automatically update the {{token}} variable.

Logout: Automatically clears the token from the environment upon successful logout.

🛠 API Endpoints & Expected Responses
1. Register
Method: POST | Endpoint: {{railway-URL}}/register

Body (form-data): name, email, password, password_confirmation

Response (201 Created):

JSON
{
    "message": "User registered successfully",
    "access_token": "1|tpV6...",
    "user": {
        "id": 1,
        "name": "Moaaz Amgad",
        "email": "moaaz@gmail.com",
        "updated_at": "2026-04-25T21:00:00.000000Z",
        "created_at": "2026-04-25T21:00:00.000000Z"
    }
}
2. Login
Method: POST | Endpoint: {{railway-URL}}/login

Body (form-data): email, password

Response (200 OK):

JSON
{
    "access_token": "2|shY9...",
    "token_type": "Bearer",
    "user": {
        "id": 1,
        "name": "Moaaz Amgad",
        "email": "moaaz@gmail.com",
        "google_id": null,
        "created_at": "2026-04-25T21:00:00.000000Z",
        "updated_at": "2026-04-25T21:00:00.000000Z"
    }
}
3. Get Profile Data
Method: GET | Endpoint: {{railway-URL}}/user

Headers: Authorization: Bearer {{token}}

Response (200 OK):

JSON
{
    "data": {
        "id": 1,
        "name": "Moaaz Amgad",
        "email": "moaaz@gmail.com",
        "google_id": null,
        "created_at": "2026-04-25T21:00:00.000000Z",
        "updated_at": "2026-04-25T21:00:00.000000Z"
    }
}
4. Google Login
Method: POST | Endpoint: {{railway-URL}}/google-login

Body (form-data): name, email, google_id

Response (200 OK):

JSON
{
    "status": "success",
    "access_token": "3|go7...",
    "token_type": "Bearer",
    "user": {
        "id": 2,
        "name": "Moaaz Google",
        "email": "moaaz.google@gmail.com",
        "google_id": "123456789",
        "created_at": "2026-04-25T22:00:00.000000Z"
    }
}
5. Forgot Password
Method: POST | Endpoint: {{railway-URL}}/forgot-password

Body (form-data): email

Response (200 OK):

JSON
{
    "status": "success",
    "message": "Reset code generated successfully",
    "code_debug": 548210
}
6. Reset Password
Method: POST | Endpoint: {{railway-URL}}/reset-password

Body (form-data): email, code, password, password_confirmation

Response (200 OK):

JSON
{
    "status": "success",
    "message": "Password has been reset successfully"
}
7. Logout
Method: POST | Endpoint: {{railway-URL}}/logout

Headers: Authorization: Bearer {{token}}

Response (200 OK):

JSON
{
    "status": "success",
    "message": "Logged out successfully. Token revoked."
}
8. Store Phone Usage Data
Method: POST | Endpoint: {{railway-URL}}/phone-usage

Body (form-data): daily_usage_hours, screen_time_before_bed, phone_checks_per_day, apps_used_daily, time_on_social_media, time_on_gaming, phone_usage_purpose (Social Media, Gaming, Education, Other), weekend_usage_hours.

Response (201 Created):

JSON
{
    "status": "success",
    "message": "Phone usage data recorded successfully for Moaaz Amgad",
    "data": {
        "daily_usage_hours": "6.5",
        "screen_time_before_bed": "2.0",
        "phone_checks_per_day": "50",
        "apps_used_daily": "15",
        "time_on_social_media": "4.0",
        "time_on_gaming": "1.0",
        "phone_usage_purpose": "Social Media",
        "weekend_usage_hours": "8.0",
        "user_id": 1,
        "collected_at": "2026-04-25 22:05:00",
        "usage_id": 12
    }
}
9. Get Phone Usage History
Method: GET | Endpoint: {{railway-URL}}/phone-usage

Response (200 OK):

JSON
{
    "status": "success",
    "user": "Moaaz Amgad",
    "count": 1,
    "data": [ { "usage_id": 12, "daily_usage_hours": 6.5, "..." : "..." } ]
}
10. Store Questionnaire Response
Method: POST | Endpoint: {{railway-URL}}/questionnaire

Body (form-data): gender (male, female, other), sleep_hours, academic_performance, social_interactions, exercise_hours, anxiety_level, depression_level, self_esteem, time_on_education.

Response (201 Created):

JSON
{
    "status": "success",
    "message": "Questionnaire recorded successfully for Moaaz Amgad",
    "data": {
        "gender": "male",
        "sleep_hours": "7.5",
        "academic_performance": "85",
        "social_interactions": "6",
        "exercise_hours": "1",
        "user_id": 1,
        "answered_at": "2026-04-25 22:05:00",
        "questionnaire_id": 8
    }
}
11. Generate AI Diagnosis
Method: POST | Endpoint: {{railway-URL}}/diagnosis/generate

Response (201 Created):

JSON
{
    "status": "success",
    "message": "Analysis completed successfully for Moaaz Amgad",
    "data": {
        "usage_id": 12,
        "questionnaire_id": 8,
        "addiction_level": 7,
        "brain_rot_stage": "moderate",
        "main_issue": "Social Media Overuse",
        "recommendations": [
            "Limit TikTok to 30 mins",
            "Try outdoor activities"
        ],
        "diagnosed_at": "2026-04-25T22:05:00.000000Z",
        "id": 5
    }
}
12. Get Diagnosis History
Method: GET | Endpoint: {{railway-URL}}/diagnosis

Response (200 OK): Returns diagnosis history including phone_usage and questionnaire data linked to each record.

13. Admin: Get All Diagnoses (Dashboard Stats)
Method: GET | Endpoint: {{railway-URL}}/admin/all-diagnoses

Response (200 OK):

JSON
{
    "status": "success",
    "stats": {
        "total_users": 150,
        "mild_cases": 45,
        "moderate_cases": 80,
        "severe_cases": 25,
        "addiction_rate": "70%",
        "efficiency": "94.8%"
    },
    "data": [ { "id": 1, "user": { "name": "..." }, "addiction_level": 7, "..." : "..." } ]
}
14. Admin: Get Student Detail
Method: GET | Endpoint: {{railway-URL}}/admin/student/{id}

Response (200 OK): Returns complete student data with usage history, questionnaires, and diagnoses.

15. Maintenance: Fix Database
Method: GET | Endpoint: {{railway-URL}}/fix-db

Response (200 OK):

JSON
{
    "message": "Database Updated Successfully!",
    "output": "Migration table created successfully..."
}
🧪 Testing Guidelines & Notes
Content-Type: The header Accept: application/json must be included in all requests.

Authentication: Protected requests use the Bearer Token stored in {{token}}.

Smart Diagnosis: The generate endpoint requires at least one record in the Usage and Questionnaire tables to function successfully.

Maintained by Moaaz Amgad - Laravel Backend Developer
Last Updated: April 2026
