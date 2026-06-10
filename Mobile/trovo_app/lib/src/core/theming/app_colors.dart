import 'package:flutter/material.dart';

class AppColors {
  // ---------- Primary Gradient ----------
  static const Color primaryStart = Color(0xFF162C83);
  static const Color primaryEnd = Color.fromARGB(255, 76, 106, 228);
  static const Color primary = Color(0xFF162C83);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryStart, primaryEnd],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // ---------- Semantic Colors ----------
  static const Color error = Color(0xFFF44336);
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFFA000);

  // ---------- Neutrals ----------
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color greyLight = Color(0xFFE0E0E0);
  static const Color greyDark = Color(0xFF616161);

  // ---------- Text Colors ----------
  static const Color textPrimary = Color(0xFF111827);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textOnSecondary = Color(0xFF000000);

  // ---------- Backgrounds ----------
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF0B1720);
  static const Color lightSurface = Color(0xFFF7F9FB);
  static const Color darkSurface = Color(0xFF121417);

  // ---------- Auth / Onboarding ----------
  static const Color authPrimary = Color(0xFF162C83);
  static const Color authSecondaryBg = Color(0xFFBACBE7);
  static const Color authCardBg = Color(0xFFF6F6F6);
  static const Color authButtonBg = Color(0xFF162C83);
  static const Color authSubtitle = Color(0xFF212529);
  static const Color authPlaceholder = Color(0xFF6C757D);
  static const Color authFieldBorder = Color(0xFF336749);
  static const Color authLink = Color(0xFF0077B6);
  static const Color authOtpHighlight = Color(0xFF0096C7);
  static const Color onboardingDotActive = Color(0xFF162C83);
  static const Color onboardingDotInactive = Color(0xFFE2E3E3);

  // ---------- Legacy (from old core) ----------
  static const Color deepTeal = Color(0xFF0B3A4A);
  static const Color bg = Color(0xFFF7F7F7);
  static const Color softBlue = Color(0xFFAFCBE8);
  static const Color dotInactive = Color(0xFFD9D9D9);

  // ---------- Private ----------
  const AppColors._();
}
