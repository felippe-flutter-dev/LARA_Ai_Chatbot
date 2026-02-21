import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lara_ai/core/constants/navigation_route_names.dart';
import 'package:lara_ai/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:lara_ai/features/auth/presentation/cubit/login/login_states.dart';

import '../../../../../core/widgets/enable_biometrics_dialog.dart';

class LoginViewModel {
  final LoginCubit loginCubit = Modular.get<LoginCubit>();

  void stateObserver(BuildContext context, LoginState state) async {
    if (state is LoginSuccess) {
      final biometricsEnabled = await loginCubit.checkBiometricsEnabled();
      if (!biometricsEnabled) {
        if (!context.mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const EnableBiometricsDialog(),
        );
      } else {
        Modular.to.pushReplacementNamed(NavigationRouteNames.toChatPage);
      }
    }
  }
}
