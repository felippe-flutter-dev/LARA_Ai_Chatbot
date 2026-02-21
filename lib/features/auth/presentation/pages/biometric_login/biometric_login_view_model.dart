import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lara_ai/core/constants/route_names.dart';
import 'package:lara_ai/core/data/services/auth_service.dart';
import 'package:lara_ai/features/auth/presentation/cubit/login/login_cubit.dart';

class BiometricLoginViewModel {
  final AuthService _authService = Modular.get<AuthService>();
  final LoginCubit _loginCubit = Modular.get<LoginCubit>();

  Future<void> authenticate(BuildContext context) async {
    final success = await _authService.authenticate();
    if (success) {
      Modular.to.pushReplacementNamed(
        RouteNames.chatModel + RouteNames.chatPage,
      );
    }
    // Se falhar, não faz nada. O usuário permanece na tela para tentar de novo.
  }

  Future<void> goToLogin() async {
    await _loginCubit.logout();
    Modular.to.pushReplacementNamed(RouteNames.loginPage);
  }
}
