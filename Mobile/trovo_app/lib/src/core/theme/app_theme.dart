import 'package:flutter/material.dart';

class AppTheme {
  static const Color deepTeal = Color(0xFF0B3A4A);
  static const Color bg = Color(0xFFF7F7F7);
  static const Color softBlue = Color(0xFFAFCBE8);
  static const Color dotInactive = Color(0xFFD9D9D9);

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(seedColor: deepTeal, surface: bg);

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: bg,
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w800,
          color: deepTeal,
          height: 1.15,
          letterSpacing: -0.8,
        ),
        bodyLarge: TextStyle(fontSize: 18, height: 1.45, color: deepTeal),
      ),
    );
  }
}
