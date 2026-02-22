import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/constants/font_sizes.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:lara_ai/features/auth/presentation/cubit/login/login_states.dart';
import 'package:lara_ai/features/auth/presentation/pages/login/login_view_model.dart';
import 'package:lara_ai/features/auth/presentation/pages/login/widgets/google_login_button.dart';
import 'package:lara_ai/core/widgets/logo_app.dart';
import 'package:lara_ai/features/auth/presentation/widgets/filled_buttom_custom.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';

import '../../../../../core/constants/navigation_route_names.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _vm = Modular.get<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: _vm.loginCubit,
      listener: _vm.stateObserver,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LogoApp(),
                SizedBox(height: 24.h),
                Text(
                  context.localization!.login_welcomeTitle,
                  style: context.textTheme.headlineLarge!.copyWith(
                    fontSize: FontSizes.headlineLarge,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  context.localization!.login_welcomeSubtitle,
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontSize: FontSizes.bodyLarge,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.h),
                Row(children: [Expanded(child: GoogleLoginButton())]),
                SizedBox(height: 16.h),
                FilledButtonCustom(
                  text: context.localization!.login_buttonEmail,
                  onPressed: () {
                    Modular.to.pushNamed(NavigationRouteNames.toEmailLoginPage);
                  },
                ),
                SizedBox(height: 40.h),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: context.localization!.login_footerPrefix),
                      TextSpan(
                        text: context.localization!.login_footerTerms,
                        style: context.textTheme.bodySmall!.copyWith(
                          fontSize: FontSizes.bodySmall,
                          decoration: TextDecoration.underline,
                          decorationColor: context.primaryColorScheme,
                          color: context.primaryColorScheme,
                        ),
                      ),
                      TextSpan(text: context.localization!.login_footerAnd),
                      TextSpan(
                        text: context.localization!.login_footerPrivacy,
                        style: context.textTheme.bodySmall!.copyWith(
                          fontSize: FontSizes.bodySmall,
                          decoration: TextDecoration.underline,
                          decorationColor: context.primaryColorScheme,
                          color: context.primaryColorScheme,
                        ),
                      ),
                    ],
                  ),
                  style: context.textTheme.bodySmall!.copyWith(
                    fontSize: FontSizes.bodySmall,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
