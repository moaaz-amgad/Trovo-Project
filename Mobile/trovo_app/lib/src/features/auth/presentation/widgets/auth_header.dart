import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trovo_app/src/core/theming/app_colors.dart';

/// Header section for auth screens — logo + title + subtitle.
class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Logo
        Image.asset('assets/app/auth_logo.png', width: 91.w, height: 80.h),
        SizedBox(height: 16.h),
        // Title
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 25.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.authPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        // Subtitle
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.authSubtitle,
          ),
        ),
      ],
    );
  }
}
