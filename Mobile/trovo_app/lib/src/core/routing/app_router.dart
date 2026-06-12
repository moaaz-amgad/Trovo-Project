import 'package:go_router/go_router.dart';

import 'package:trovo_app/src/features/home/presentation/home_screen.dart';
import 'package:trovo_app/src/features/layout/presentation/screens/main_layout_screen.dart';
import 'package:trovo_app/src/features/attention_span/presentation/screens/attention_span_screen.dart';
import 'package:trovo_app/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:trovo_app/src/features/memory_sequence/presentation/screens/memory_sequence_screen.dart';
import 'package:trovo_app/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:trovo_app/src/features/phone_usage/presentation/phone_usage_screen.dart';
import 'package:trovo_app/src/features/questionnaire/presentation/screens/questionnaire_screen.dart';
import 'package:trovo_app/src/features/splash/presentation/splash_screen.dart';
import 'package:trovo_app/src/features/auth/presentation/screens/login_screen.dart';
import 'package:trovo_app/src/features/auth/presentation/screens/register_screen.dart';
import 'package:trovo_app/src/features/auth/presentation/screens/otp_screen.dart';
import 'package:trovo_app/src/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:trovo_app/src/features/auth/presentation/screens/new_password_screen.dart';
import 'package:trovo_app/src/features/diagnosis/presentation/screens/diagnosis_result_screen.dart';
import 'package:trovo_app/src/features/diagnosis/presentation/screens/diagnosis_history_screen.dart';
import 'package:trovo_app/src/features/number_letter/presentation/screens/nl_screen.dart';
import 'package:trovo_app/src/features/stroop/presentation/screens/stroop_screen.dart';
import 'package:trovo_app/src/features/time_focus/presentation/time_focus_screen.dart';
import 'package:trovo_app/src/core/routing/app_router_paths.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutePaths.splashScreen,
    routes: [
      GoRoute(
        path: AppRoutePaths.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.onboardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.questionnaireScreen,
        builder: (context, state) => const QuestionnaireScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.timeFocusScreen,
        builder: (context, state) => const TimeFocusScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.phoneUsageScreen,
        builder: (context, state) => const PhoneUsageScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.memorySequenceScreen,
        builder: (context, state) => const MemorySequenceScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.stroopScreen,
        builder: (context, state) => const StroopScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.signUpScreen,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.otpScreen,
        builder: (context, state) =>
            OtpScreen(email: state.uri.queryParameters['email'] ?? ''),
      ),
      GoRoute(
        path: AppRoutePaths.forgetPasswordScreen,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.resetPasswordScreen,
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          final debugCodeStr = state.uri.queryParameters['code'];
          final debugCode = debugCodeStr != null
              ? int.tryParse(debugCodeStr)
              : null;
          return NewPasswordScreen(email: email, debugCode: debugCode);
        },
      ),
      GoRoute(
        path: AppRoutePaths.diagnosisResultScreen,
        builder: (context, state) => const DiagnosisResultScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.layoutScreen,
        builder: (context, state) => const MainLayoutScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.numberLetterScreen,
        builder: (context, state) => const NlScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.attentionSpanScreen,
        builder: (context, state) => const AttentionSpanScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.profileScreen,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.diagnosisHistoryScreen,
        builder: (context, state) => const DiagnosisHistoryScreen(),
      ),
    ],
  );
}
