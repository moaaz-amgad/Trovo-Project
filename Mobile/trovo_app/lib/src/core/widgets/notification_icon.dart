import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28.w,
      height: 28.h,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EEEE).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: SvgPicture.asset(
        'assets/icons/notification.svg',
        width: 16.w,
        height: 16.w,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
    );
  }
}
