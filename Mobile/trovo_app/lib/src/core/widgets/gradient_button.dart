import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trovo_app/src/core/theming/app_colors.dart';
import 'package:trovo_app/src/core/theming/app_text_styles.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;

    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        width: double.infinity,
        height: 48.h,
        decoration: BoxDecoration(
          gradient: isDisabled
              ? LinearGradient(
                  colors: [
                    AppColors.primaryStart.withValues(alpha: 0.5),
                    AppColors.primaryEnd.withValues(alpha: 0.5),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  text,
                  style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
