/// API Endpoints
class Endpoints {
  Endpoints._();

  // Auth
  static const String login = '/api/login';
  static const String register = '/api/register';
  static const String googleAuth = '/api/auth/google';
  static const String verifyEmail = '/api/verify-email';
  static const String resendOtp = '/api/resend-otp';
  static const String logout = '/api/logout';
  static const String user = '/api/user'; // Profile data

  static const String forgotPassword = '/api/forgot-password';
  static const String resetPassword = '/api/reset-password';
  static const String refreshToken = '/api/refresh-token';

  // User account management
  static const String updateProfile = '/api/user/update-profile';
  static const String changePassword = '/api/user/change-password';
  static const String deleteAccount = '/api/user/delete-account';

  // Phone Usage
  static const String submitPhoneUsage = '/api/phone-usage';
  static const String phoneUsageHistory = '/api/phone-usage';

  // Questionnaire
  static const String submitQuestionnaire = '/api/questionnaire';
  static const String questionnaireHistory = '/api/questionnaire';

  // Diagnosis
  static const String generateDiagnosis = '/api/diagnosis/generate';
  static const String diagnosisHistory = '/api/diagnosis-history';

  // Progress
  static const String progress = '/api/progress';
  static const String progressHistory = '/api/progress/history';

  // Mini Games
  static const String submitMiniGame = '/api/mini-game';
  static const String miniGameHistory = '/api/mini-game/history';
  static const String miniGameStats = '/api/mini-game/stats';
  static const String miniGameDashboard = '/api/mini-game/dashboard';
}
