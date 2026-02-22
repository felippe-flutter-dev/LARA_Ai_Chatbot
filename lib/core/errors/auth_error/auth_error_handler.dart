import 'package:lara_ai/core/errors/auth_error/auth_error_type.dart';

class AuthErrorHandler {
  static AuthErrorType handle(dynamic error) {
    final String code = error.toString().toLowerCase();

    if (code.contains('user-not-found')) {
      return AuthErrorType.userNotFound;
    } else if (code.contains('wrong-password')) {
      return AuthErrorType.wrongPassword;
    } else if (code.contains('email-already-in-use')) {
      return AuthErrorType.emailInUse;
    } else if (code.contains('invalid-email')) {
      return AuthErrorType.invalidEmail;
    } else if (code.contains('weak-password')) {
      return AuthErrorType.weakPassword;
    } else if (code.contains('network-request-failed')) {
      return AuthErrorType.network;
    } else if (code.contains('too-many-requests')) {
      return AuthErrorType.tooManyRequests;
    } else if (code.contains('user-disabled')) {
      return AuthErrorType.userDisabled;
    } else if (code.contains('operation-not-allowed')) {
      return AuthErrorType.operationNotAllowed;
    }

    return AuthErrorType.unknown;
  }
}
