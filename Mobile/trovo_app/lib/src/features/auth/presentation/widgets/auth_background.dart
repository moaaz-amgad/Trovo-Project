import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trovo_app/src/core/theming/app_colors.dart';

/// Shared auth background: blue (#BACBE7) behind a white/grey rounded card.
class AuthBackground extends StatelessWidget {
  final Widget child;
  final bool fullHeight;

  const AuthBackground({
    super.key,
    required this.child,
    this.fullHeight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authSecondaryBg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              decoration: BoxDecoration(
                color: AppColors.authCardBg,
                borderRadius: BorderRadius.circular(20.r),
              ),
              constraints: BoxConstraints(minHeight: fullHeight ? 0 : 550.h),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
