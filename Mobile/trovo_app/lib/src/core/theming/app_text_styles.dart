import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static String? fontFamily = 'Tajawal';

  // Display styles (largest)
  static TextStyle get displayLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 57.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
  );

  static TextStyle get displayMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 45.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get displaySmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 36.sp,
    fontWeight: FontWeight.w400,
  );

  // Headline styles
  static TextStyle get headlineLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.8,
  );

  static TextStyle get headlineMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.8,
  );

  static TextStyle get headlineSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
  );

  // Title styles
  static TextStyle get titleLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 22.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get titleMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  static TextStyle get titleSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  // Body styles
  static TextStyle get bodyLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static TextStyle get bodySmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  // Label styles
  static TextStyle get labelLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle get labelMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static TextStyle get labelSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  // Legacy names for backward compatibility
  static TextStyle get headline1 => displayLarge;
  static TextStyle get headline2 => displayMedium;
  static TextStyle get headline3 => displaySmall;
  static TextStyle get headline4 => headlineLarge;
  static TextStyle get headline5 => headlineMedium;
  static TextStyle get headline6 => headlineSmall;
  static TextStyle get subtitle1 => titleMedium;
  static TextStyle get subtitle2 => titleSmall;
  static TextStyle get bodyText1 => bodyLarge;
  static TextStyle get bodyText2 => bodyMedium;
  static TextStyle get caption => bodySmall;
  static TextStyle get button => labelLarge;
  static TextStyle get overline => labelSmall;

  // Complete TextTheme
  static TextTheme textTheme(Color textColor) => TextTheme(
    displayLarge: displayLarge.copyWith(color: textColor),
    displayMedium: displayMedium.copyWith(color: textColor),
    displaySmall: displaySmall.copyWith(color: textColor),
    headlineLarge: headlineLarge.copyWith(color: textColor),
    headlineMedium: headlineMedium.copyWith(color: textColor),
    headlineSmall: headlineSmall.copyWith(color: textColor),
    titleLarge: titleLarge.copyWith(color: textColor),
    titleMedium: titleMedium.copyWith(color: textColor),
    titleSmall: titleSmall.copyWith(color: textColor),
    bodyLarge: bodyLarge.copyWith(color: textColor),
    bodyMedium: bodyMedium.copyWith(color: textColor),
    bodySmall: bodySmall.copyWith(color: textColor),
    labelLarge: labelLarge.copyWith(color: textColor),
    labelMedium: labelMedium.copyWith(color: textColor),
    labelSmall: labelSmall.copyWith(color: textColor),
  );
}
