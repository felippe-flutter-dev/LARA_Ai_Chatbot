import 'package:flutter_test/flutter_test.dart';
import 'package:lara_ai/core/errors/auth_error/auth_error_handler.dart';
import 'package:lara_ai/core/errors/auth_error/auth_error_type.dart';

void main() {
  group('AuthErrorHandler', () {
    test('deve retornar AuthErrorType para erro user-not-found', () {
      const error = 'firebase_auth/user-not-found';
      final result = AuthErrorHandler.handle(error);
      expect(result, AuthErrorType.userNotFound);
    });

    test('deve retornar AuthErrorType para erro wrong-password', () {
      const error = 'firebase_auth/wrong-password';
      final result = AuthErrorHandler.handle(error);
      expect(result, AuthErrorType.wrongPassword);
    });

    test('deve retornar AuthErrorType para erro desconhecido', () {
      const error = 'erro-aleatorio-desconhecido';
      final result = AuthErrorHandler.handle(error);
      expect(result, AuthErrorType.unknown);
    });
  });
}
