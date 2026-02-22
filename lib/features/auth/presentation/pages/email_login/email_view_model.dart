import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lara_ai/core/errors/auth_error_handler.dart';
import 'package:lara_ai/core/theme/app_colors.dart';
import 'package:lara_ai/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:lara_ai/features/auth/presentation/cubit/login/login_states.dart';

import '../../../../../core/constants/navigation_route_names.dart';

class EmailViewModel {
  final LoginCubit loginCubit = Modular.get<LoginCubit>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void stateObserver(BuildContext context, LoginState state) {
    if (state is LoginSuccess) {
      Modular.to.pushReplacementNamed(NavigationRouteNames.toChatPage);
    } else if (state is LoginError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AuthErrorHandler.handle(context)),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else if (state is RegisterSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Cadastro realizado com sucesso! Faça login."),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Modular.to.pop();
    }
  }

  void login() {
    loginCubit.loginWithEmail(emailController.text, passwordController.text);
  }

  void register() {
    loginCubit.registerWithEmail(emailController.text, passwordController.text);
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
