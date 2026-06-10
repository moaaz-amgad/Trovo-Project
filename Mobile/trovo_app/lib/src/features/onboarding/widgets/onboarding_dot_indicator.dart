import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class OnboardingDotIndicator extends StatelessWidget {
  const OnboardingDotIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
  });

  final int currentIndex;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(itemCount, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 34 : 14,
          height: 14,
          decoration: BoxDecoration(
            color: isActive ? AppTheme.deepTeal : AppTheme.dotInactive,
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}
