import 'package:lara_ai/core/constants/route_names.dart';

class NavigationRouteNames {
  NavigationRouteNames._();

  static String get toEmailLoginPage => RouteNames.emailPage;
  static String get toRegisterPage => '/register-page';
  static String get toChatPage => RouteNames.chatModel + RouteNames.chatPage;
}
