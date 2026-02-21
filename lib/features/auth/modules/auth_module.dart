import 'package:flutter_modular/flutter_modular.dart';
import 'package:lara_ai/core/constants/route_names.dart';
import 'package:lara_ai/core/data/services/auth_service.dart';
import 'package:lara_ai/core/modules/main_module.dart';
import 'package:lara_ai/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:lara_ai/features/auth/presentation/pages/email_login/email_login_page.dart';
import 'package:lara_ai/features/auth/presentation/pages/email_login/email_view_model.dart';
import 'package:lara_ai/features/auth/presentation/pages/login/login_page.dart';
import 'package:lara_ai/features/auth/presentation/pages/login/login_view_model.dart';
import 'package:lara_ai/features/auth/presentation/pages/register/register_page.dart';
import '../presentation/pages/biometric_login/biometric_login_page.dart';
import '../presentation/pages/biometric_login/biometric_login_view_model.dart';
import '../presentation/pages/splash/splash_page.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
    i.addLazySingleton(AuthService.new);
    i.addLazySingleton(LoginCubit.new);
    i.addLazySingleton(LoginViewModel.new);
    i.addLazySingleton(EmailViewModel.new);
    i.addLazySingleton(BiometricLoginViewModel.new);
  }

  @override
  List<Module> get imports => [MainModule()];

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(RouteNames.splashPage, child: (context) => const SplashPage());
    r.child(RouteNames.loginPage, child: (context) => LoginPage());
    r.child(RouteNames.emailPage, child: (context) => EmailLoginPage());
    r.child('/register-page', child: (context) => const RegisterPage());
    r.child(
      RouteNames.biometricLogin,
      child: (context) => BiometricLoginPage(),
    );
  }
}
