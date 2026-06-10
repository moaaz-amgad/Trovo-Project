import 'package:flutter/material.dart';

class QuestionnaireIntroCard extends StatelessWidget {
  const QuestionnaireIntroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trovo wants to ask you some\nquestions to get to know you',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF042F40),
              height: 1.15,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'There is no ideal answer we appreaciate your honesty',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0x99042F40),
            ),
          ),
        ],
      ),
    );
  }
}
