import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/constants/font_sizes.dart';
import 'package:lara_ai/core/theme/app_assets.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';

import '../../../../../../core/theme/app_colors.dart';

class GoogleLoginButton extends StatelessWidget {
  final Function()? onPressed;
  const GoogleLoginButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          context.isDarkMode ? AppColors.darkBg200 : AppColors.gray50,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(24)),
          ),
        ),
        side: WidgetStatePropertyAll(
          BorderSide(
            color: context.isDarkMode
                ? AppColors.surfaceOverlay
                : AppColors.gray100,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 26.h,
              width: 26.h,
              child: Image.asset(AppAssets.googleLogo),
            ),
            SizedBox(width: 16.w),
            Text(
              context.localization!.login_buttonGoogle,
              style: context.textTheme.bodyLarge!.copyWith(
                fontSize: FontSizes.bodyLarge,
                fontWeight: FontWeight.w700,
                color: context.brightness == Brightness.dark
                    ? AppColors.textOnDark
                    : AppColors.gray700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
