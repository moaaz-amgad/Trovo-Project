import 'package:flutter/material.dart';

class QuestionnaireStepIndicator extends StatelessWidget {
  const QuestionnaireStepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isActive = index <= currentStep;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: index == totalSteps - 1 ? 0 : 5),
            height: 5,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF042F40)
                  : const Color(0xFF8EA0A9),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }),
    );
  }
}
