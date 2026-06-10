import 'package:flutter/material.dart';

class QuestionnaireSlothHeader extends StatelessWidget {
  const QuestionnaireSlothHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 286,
      height: 179,
      child: Image.asset('assets/images/sloth.png', fit: BoxFit.cover),
    );
  }
}
