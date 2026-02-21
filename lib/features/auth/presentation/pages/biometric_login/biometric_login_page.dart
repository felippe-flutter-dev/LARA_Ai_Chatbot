import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/features/auth/presentation/pages/biometric_login/widgets/biometric_header.dart';
import 'package:lara_ai/features/auth/presentation/pages/biometric_login/widgets/biometric_unlock_button.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';

import '../../../../../core/constants/font_sizes.dart';
import 'biometric_login_view_model.dart';

class BiometricLoginPage extends StatefulWidget {
  const BiometricLoginPage({super.key});

  @override
  State<BiometricLoginPage> createState() => _BiometricLoginPageState();
}

class _BiometricLoginPageState extends State<BiometricLoginPage> {
  final _vm = Modular.get<BiometricLoginViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.authenticate(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const BiometricHeader(),
          const Spacer(),
          const BiometricUnlockButton(),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text.rich(
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: FontSizes.bodySmall,
                fontWeight: FontWeight.w700,
              ),
              TextSpan(
                children: [
                  TextSpan(text: context.localization!.bio_notYou),
                  TextSpan(
                    text: context.localization!.bio_switchAccount,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _vm.goToLogin(),
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
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
