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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _vm = Modular.get<EmailViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: _vm.loginCubit,
      listener: (context, state) => _vm.registerStateObserver,
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
                  context.localization!.auth_registerTitle,
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32.h),
                TextField(
                  controller: _vm.emailController,
                  decoration: InputDecoration(
                    labelText: context.localization!.auth_emailLabel,
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: _vm.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: context.localization!.auth_passwordLabel,
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: _vm.confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: context.localization!.auth_confirmPasswordLabel,
                    prefixIcon: Icon(Icons.lock_clock_outlined),
                  ),
                ),
                SizedBox(height: 32.h),
                BlocBuilder<LoginCubit, LoginState>(
                  bloc: _vm.loginCubit,
                  builder: (context, state) {
                    return FilledButtonCustom(
                      text: context.localization!.auth_buttonRegister,
                      onPressed: state is LoginLoading ? null : _vm.register,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
