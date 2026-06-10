import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppMargin {
  static double get m8 => 8.w;
  static double get m12 => 12.w;
  static double get m14 => 14.w;
  static double get m16 => 16.w;
  static double get m18 => 18.w;
  static double get m20 => 20.w;
  static double get m24 => 24.w;
  static double get m32 => 32.w;
}

class AppPadding {
  static EdgeInsetsGeometry get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: 16.w);

  static EdgeInsetsGeometry get pagePadding =>
      EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 40.h).copyWith();

  static double get p2 => 2.w;
  static double get p4 => 4.w;
  static double get p8 => 8.w;
  static double get p10 => 10.w;
  static double get p12 => 12.w;
  static double get p14 => 14.w;
  static double get p16 => 16.w;
  static double get pf16 => 16;
  static double get p18 => 18.w;
  static double get p20 => 20.w;
  static double get pf20 => 20;
  static double get p24 => 24.w;
  static double get p32 => 32.w;
}

class AppSize {
  static double get s2 => 2.r;
  static double get s4 => 4.r;
  static double get s6 => 6.r;
  static double get s8 => 8.r;
  static double get s12 => 12.r;
  static double get s14 => 14.r;
  static double get s16 => 16.r;
  static double get s18 => 18.r;
  static double get s20 => 20.r;
  static double get s24 => 24.r;
  static double get s32 => 32.r;
}

class AppRadius {
  static double kRadius4 = 4.r;
  static double kRadius6 = 6.r;
  static double kRadius8 = 8.r;
  static double kRadius12 = 12.r;
  static double kRadius16 = 16.r;
}

class AppSpacing {
  static double h4 = 4.w;
  static double v4 = 4.h;

  static double h6 = 6.w;
  static double v6 = 6.h;

  static double h8 = 8.w;
  static double v8 = 8.h;

  static double h12 = 12.w;
  static double v12 = 12.h;

  static double h16 = 16.w;
  static double v16 = 16.h;

  static double h20 = 20.w;
  static double v20 = 20.h;
}
