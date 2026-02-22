import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/theme/app_colors.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/constants/font_sizes.dart';

class LaraAppbarIcon extends StatelessWidget {
  const LaraAppbarIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 36.h,
          width: 36.h,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryMain,
                  ),
                  child: Center(
                    child: Icon(
                      LucideIcons.sparkles,
                      color: Colors.white,
                      size: 24.r,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 12.h,
                  width: 12.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      height: 8.h,
                      width: 8.h,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.localization!.common_appName,
              style: context.textTheme.bodyMedium!.copyWith(
                fontSize: FontSizes.bodyMedium,
              ),
            ),
            Text(
              context.localization!.common_onlineStatus,
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.success,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
