import 'package:flutter/material.dart';

class StroopQuestion {
  final String meaningWord; 
  final String displayWord; 
  final Color displayColor; 
  final String displayColorName; 

  StroopQuestion({
    required this.meaningWord,
    required this.displayWord,
    required this.displayColor,
    required this.displayColorName,
  });

  bool get isMatch => meaningWord == displayColorName;
}

class GameResult {
  final int totalAnswers;
  final int correctAnswers;
  final int wrongAnswers;
  final double averageReactionTime;

  GameResult({
    required this.totalAnswers,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.averageReactionTime,
  });

  double get accuracy => totalAnswers == 0 ? 0 : (correctAnswers / totalAnswers) * 100;
}
