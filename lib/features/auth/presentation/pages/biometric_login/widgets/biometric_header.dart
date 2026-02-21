import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';

import '../../../../../../core/constants/font_sizes.dart';
import '../../../../../../core/theme/app_colors.dart';

class BiometricHeader extends StatelessWidget {
  const BiometricHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.w, vertical: 55.h),
      decoration: BoxDecoration(
        gradient: !context.isDarkMode ? AppColors.purpleGradient : null,
        color: context.isDarkMode ? context.primaryColorScheme : null,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            context.localization!.bio_welcomeBack,
            style: context.textTheme.headlineLarge!.copyWith(
              fontSize: FontSizes.headlineLarge,
              fontWeight: FontWeight.w700,
              color: AppColors.gray50,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            context.localization!.bio_authRequired,
            style: context.textTheme.bodyMedium!.copyWith(
              fontSize: FontSizes.bodyMedium,
              fontWeight: FontWeight.w700,
              color: AppColors.gray50,
            ),
          ),
        ],
      ),
    );
  }
}
