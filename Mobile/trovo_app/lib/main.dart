import 'package:flutter/material.dart';
import 'package:trovo_app/bourding/bourding1.dart';
import 'package:trovo_app/screans/forget_password.dart';
import 'package:trovo_app/screans/new-password.dart';
import 'package:trovo_app/screans/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}
