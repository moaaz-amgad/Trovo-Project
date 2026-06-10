import 'package:flutter/material.dart';

enum StroopColor {
  red(label: 'red', color: Color(0xFFC42C2F)),
  blue(label: 'blue', color: Color(0xFF2C85C4)),
  green(label: 'green', color: Color(0xFF2EC451)),
  yellow(label: 'yellow', color: Color(0xFFFFC107));

  const StroopColor({required this.label, required this.color});

  final String label;
  final Color color;
}
