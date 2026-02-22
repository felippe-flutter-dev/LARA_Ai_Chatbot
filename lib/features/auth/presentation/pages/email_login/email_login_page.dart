import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:lara_ai/features/auth/presentation/cubit/login/login_states.dart';
import 'package:lara_ai/features/auth/presentation/pages/email_login/email_view_model.dart';
import 'package:lara_ai/core/widgets/logo_app.dart';
import 'package:lara_ai/features/auth/presentation/widgets/filled_buttom_custom.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';

import '../../../../../core/constants/navigation_route_names.dart';

class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({super.key});

  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  final _vm = Modular.get<EmailViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: _vm.loginCubit,
      listener: (context, state) => _vm.loginStateObserver,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                const LogoApp(),
                SizedBox(height: 40.h),
                Text(
                  context.localization!.auth_loginEmailTitle,
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32.h),
                TextField(
                  controller: _vm.emailController,
                  decoration: InputDecoration(
                    labelText: context.localization!.auth_emailLabel,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: _vm.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: context.localization!.auth_passwordLabel,
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                ),
                SizedBox(height: 32.h),
                BlocBuilder<LoginCubit, LoginState>(
                  bloc: _vm.loginCubit,
                  builder: (context, state) {
                    return FilledButtonCustom(
                      text: context.localization!.auth_buttonLogin,
                      onPressed: state is LoginLoading ? null : _vm.login,
                    );
                  },
                ),
                SizedBox(height: 16.h),
                TextButton(
                  onPressed: () =>
                      Modular.to.pushNamed(NavigationRouteNames.toRegisterPage),
                  child: Text.rich(
                    TextSpan(
                      text: context.localization!.auth_noAccount,
                      children: [
                        TextSpan(
                          text: context.localization!.auth_registerLink,
                          style: TextStyle(
                            color: context.primaryColorScheme,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
