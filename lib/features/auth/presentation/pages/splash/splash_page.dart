import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lara_ai/core/constants/route_names.dart';
import 'package:lara_ai/core/data/services/auth_service.dart';
import 'package:lara_ai/features/auth/presentation/pages/login/widgets/logo_app.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final authService = Modular.get<AuthService>();
    await Future.delayed(const Duration(seconds: 2));

    if (authService.currentUser != null) {
      final biometricsEnabled = await authService.isBiometricsEnabled();
      if (biometricsEnabled) {
        Modular.to.pushReplacementNamed(RouteNames.biometricLogin);
      } else {
        Modular.to.pushReplacementNamed(
          RouteNames.chatModel + RouteNames.chatPage,
        );
      }
    } else {
      Modular.to.pushReplacementNamed(RouteNames.loginPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoApp(),
            const SizedBox(height: 20),
            Text(
              context.localization!.made_with_love,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
