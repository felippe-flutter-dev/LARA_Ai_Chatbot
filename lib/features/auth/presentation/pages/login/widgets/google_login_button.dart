import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/constants/font_sizes.dart';
import 'package:lara_ai/core/theme/app_assets.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:lara_ai/features/auth/presentation/cubit/login/login_states.dart';
import 'package:lara_ai/features/auth/presentation/pages/login/login_view_model.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';

import '../../../../../../core/theme/app_colors.dart';

class GoogleLoginButton extends StatefulWidget {
  final Function()? onPressed;

  const GoogleLoginButton({super.key, this.onPressed});

  @override
  State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  final _vm = Modular.get<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: _vm.loginCubit,
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return FilledButton(
          onPressed:
              widget.onPressed ??
              (isLoading ? null : () => _vm.loginCubit.loginWithGoogle()),
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
                isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
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
      },
    );
  }
}
