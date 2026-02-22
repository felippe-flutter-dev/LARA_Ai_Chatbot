import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/constants/font_sizes.dart';
import 'package:lara_ai/core/constants/route_names.dart';
import 'package:lara_ai/core/data/services/auth_service.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/core/widgets/fingerprint_icon.dart';
import 'package:lara_ai/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:lara_ai/features/auth/presentation/widgets/filled_buttom_custom.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';

class EnableBiometricsDialog extends StatelessWidget {
  const EnableBiometricsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = Modular.get<LoginCubit>();
    final authService = Modular.get<AuthService>();

    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      contentPadding: EdgeInsets.all(24.r),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            context.localization!.bio_dialogEnableTitle,
            style: context.textTheme.bodyLarge!.copyWith(
              fontSize: FontSizes.bodyLarge,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: const FingerprintIcon(size: 80),
          ),
          Text(
            context.localization!.bio_dialogEnableMessage,
            style: context.textTheme.bodySmall!.copyWith(
              fontSize: FontSizes.bodySmall,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
          FilledButtonCustom(
            text: context.localization!.bio_buttonEnableNow,
            onPressed: () async {
              final authenticated = await authService.authenticate();
              if (authenticated) {
                await loginCubit.enableBiometrics(true);
                Modular.to.pop();
                Modular.to.pushReplacementNamed(
                  RouteNames.chatModel + RouteNames.chatPage,
                );
              }
            },
          ),
          SizedBox(height: 8.h),
          TextButton(
            onPressed: () {
              Modular.to.pop();
              Modular.to.pushReplacementNamed(
                RouteNames.chatModel + RouteNames.chatPage,
              );
            },
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
    );
  }
}
