import 'package:flutter_modular/flutter_modular.dart';
import 'package:lara_ai/core/constants/route_names.dart';
import 'package:lara_ai/features/auth/presentation/pages/email_login/email_login_page.dart';
import 'package:lara_ai/features/auth/presentation/pages/email_login/email_view_model.dart';
import 'package:lara_ai/features/auth/presentation/pages/login/login_page.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
    i.addLazySingleton(EmailViewModel.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(RouteNames.loginPage, child: (context) => LoginPage());
    r.child(RouteNames.emailPage, child: (context) => EmailLoginPage());
  }
}
