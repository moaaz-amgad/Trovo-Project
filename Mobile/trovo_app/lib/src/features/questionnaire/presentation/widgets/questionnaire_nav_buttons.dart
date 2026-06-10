import 'package:flutter/material.dart';

class QuestionnaireNavButtons extends StatelessWidget {
  const QuestionnaireNavButtons({
    super.key,
    required this.onBack,
    required this.onNext,
    required this.canGoBack,
    this.isLoading = false,
  });

  final VoidCallback onBack;
  final VoidCallback onNext;
  final bool canGoBack;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _NavCircleButton(
          icon: Icons.arrow_back_rounded,
          onPressed: onBack,
          enabled: canGoBack && !isLoading,
          filled: canGoBack,
        ),
        _NavCircleButton(
          icon: Icons.arrow_forward_rounded,
          onPressed: onNext,
          enabled: !isLoading,
          filled: true,
          loading: isLoading,
        ),
      ],
    );
  }
}

class _NavCircleButton extends StatelessWidget {
  const _NavCircleButton({
    required this.icon,
    required this.onPressed,
    required this.enabled,
    required this.filled,
    this.loading = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final bool enabled;
  final bool filled;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final Color bg;
    if (filled) {
      bg = const Color(0xFF042F40);
    } else if (enabled) {
      bg = const Color(0xFF95A7AF);
    } else {
      bg = const Color(0xFFB8C4CA);
    }

    return Material(
      color: bg,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: enabled ? onPressed : null,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 48,
          height: 48,
          child: Center(
            child: loading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Icon(icon, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }
}
