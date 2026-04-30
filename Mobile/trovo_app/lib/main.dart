import 'package:flutter/material.dart';
import 'package:trovo_app/bourding/bourding1.dart';
import 'package:trovo_app/screans/forget_password.dart';
import 'package:trovo_app/screans/new-password.dart';
import 'package:trovo_app/screans/splash.dart';
import 'package:flutter/services.dart';
import 'package:trovo_app/screens/main_game_screen.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewPassword(),
    );
  }
}
