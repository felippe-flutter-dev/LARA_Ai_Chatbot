import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/core/widgets/fingerprint_icon.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';
import '../../../../../../core/constants/font_sizes.dart';
import '../biometric_login_view_model.dart';

class BiometricUnlockButton extends StatelessWidget {
  const BiometricUnlockButton({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Modular.get<BiometricLoginViewModel>();
    return GestureDetector(
      onTap: () => vm.showBiometricDialog(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FingerprintIcon(size: 150),
          SizedBox(height: 16.h),
          Text(
            context.localization!.bio_buttonUnlock,
            style: context.textTheme.headlineMedium!.copyWith(
              fontSize: FontSizes.headlineMedium,
              fontWeight: FontWeight.w700,
              color: context.primaryColorScheme,
            ),
          ),
        ],
      ),
    );
  }
}
