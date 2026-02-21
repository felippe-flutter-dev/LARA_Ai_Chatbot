import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/constants/font_sizes.dart';
import 'package:lara_ai/core/theme/app_colors.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        color: context.isDarkMode ? AppColors.darkBg300 : AppColors.gray50,
        border: Border.all(
          color: context.isDarkMode
              ? AppColors.surfaceOverlay
              : AppColors.gray100,
        ),
      ),
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
      child: TextField(
        controller: controller,
        style: context.textTheme.bodyLarge!.copyWith(
          fontSize: FontSizes.bodyLarge,
        ),
        decoration: InputDecoration(
          hintText: context.localization!.email_fieldHint,
          hintStyle: context.textTheme.bodyLarge!.copyWith(
            fontSize: FontSizes.bodyLarge,
            color: context.isDarkMode
                ? AppColors.surfaceOverlay
                : AppColors.gray200,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
