import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/features/auth/presentation/pages/biometric_login/widgets/biometric_header.dart';
import 'package:lara_ai/features/auth/presentation/pages/biometric_login/widgets/biometric_unlock_button.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';

import '../../../../../core/constants/font_sizes.dart';

class BiometricLoginPage extends StatefulWidget {
  const BiometricLoginPage({super.key});

  @override
  State<BiometricLoginPage> createState() => _BiometricLoginPageState();
}

class _BiometricLoginPageState extends State<BiometricLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BiometricHeader(),
          Spacer(),
          BiometricUnlockButton(),
          Spacer(),
          Text.rich(
            style: context.textTheme.bodySmall!.copyWith(
              fontSize: FontSizes.bodySmall,
              fontWeight: FontWeight.w700,
            ),
            TextSpan(
              children: [
                TextSpan(text: context.localization!.bio_notYou),
                TextSpan(
                  text: context.localization!.bio_switchAccount,
                  style: context.textTheme.bodySmall!.copyWith(
                    fontSize: FontSizes.bodySmall,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    decorationColor: context.primaryColorScheme,
                    color: context.primaryColorScheme,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
