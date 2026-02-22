import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/theme/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LogoApp extends StatelessWidget {
  const LogoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 157.h,
      width: 157.h,
      child: Stack(
        children: [
          SizedBox(
            height: 150.h,
            width: 150.h,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryMain,
                borderRadius: BorderRadiusGeometry.all(Radius.circular(40.r)),
              ),
              child: Center(
                child: Icon(
                  LucideIcons.sparkles,
                  size: 100.r,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 40.h,
              width: 40.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.success,
              ),
              child: Center(
                child: Container(
                  height: 16.h,
                  width: 16.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
