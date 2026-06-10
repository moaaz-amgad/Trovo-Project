import 'package:flutter/material.dart';

class QuestionnaireQuestionTitle extends StatelessWidget {
  const QuestionnaireQuestionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFF042F40),
      ),
    );
  }
}
