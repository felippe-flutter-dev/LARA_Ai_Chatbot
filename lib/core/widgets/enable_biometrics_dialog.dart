import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/constants/font_sizes.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/core/widgets/fingerprint_icon.dart';
import 'package:lara_ai/features/auth/presentation/widgets/filled_buttom_custom.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';

class EnableBiometricsDialog extends StatelessWidget {
  const EnableBiometricsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      titlePadding: EdgeInsets.all(16.r),
      title: Container(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              context.localization!.bio_dialogEnableMessage,
              style: context.textTheme.bodyLarge!.copyWith(
                fontSize: FontSizes.bodyLarge,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(vertical: 16.h),
              child: FingerprintIcon(size: 80),
            ),
            Text(
              context.localization!.bio_dialogEnableMessage,
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: FontSizes.bodySmall,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilledButtonCustom(
                  text: context.localization!.bio_buttonEnableNow,
                  expanded: false,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    context.localization!.bio_buttonMaybeLater,
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontSize: FontSizes.bodyLarge,
                      fontWeight: FontWeight.w700,
                      color: context.primaryColorScheme,
                      decoration: TextDecoration.underline,
                      decorationColor: context.primaryColorScheme,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
