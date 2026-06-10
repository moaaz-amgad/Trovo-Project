import 'package:flutter/material.dart';

class QuestionnairePhonePurposeOption extends StatelessWidget {
  const QuestionnairePhonePurposeOption({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0x3382979F), width: 0.6),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF042F40)
                      : const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: selected
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF042F40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
