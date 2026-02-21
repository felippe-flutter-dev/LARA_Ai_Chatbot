import 'package:flutter_modular/flutter_modular.dart';
import 'package:lara_ai/features/auth/modules/auth_module.dart';
import '../../features/chat/modules/chat_module.dart';

import '../constants/route_names.dart';

class MainModule extends Module {
  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.module(RouteNames.authModel, module: AuthModule());
    r.module(RouteNames.chatModel, module: ChatModule());
  }
}
