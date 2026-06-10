import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthSocialRow extends StatelessWidget {
  const AuthSocialRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIcon(asset: 'assets/svgs/ic_google.svg'),
        SizedBox(width: 24.w),
        _SocialIcon(asset: 'assets/svgs/ic_apple.svg'),
        SizedBox(width: 24.w),
        _SocialIcon(asset: 'assets/svgs/ic_facebook.svg'),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final String asset;
  const _SocialIcon({required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55.w,
      height: 55.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.13),
            blurRadius: 13,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: SvgPicture.asset(asset, width: 37.w, height: 40.w),
      ),
    );
  }
}
