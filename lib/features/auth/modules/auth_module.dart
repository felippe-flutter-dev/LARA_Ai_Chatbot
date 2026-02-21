import 'package:flutter_modular/flutter_modular.dart';
import 'package:lara_ai/core/constants/route_names.dart';
import 'package:lara_ai/features/auth/presentation/login_page.dart';

class AuthModule extends Module {
  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(RouteNames.loginPage, child: (context) => LoginPage());
  }
}
