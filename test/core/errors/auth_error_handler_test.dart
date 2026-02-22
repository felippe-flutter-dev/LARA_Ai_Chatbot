import 'package:flutter_test/flutter_test.dart';
import 'package:lara_ai/core/errors/auth_error_handler.dart';

void main() {
  group('AuthErrorHandler', () {
    test('deve retornar mensagem amigável para erro user-not-found', () {
      const error = 'firebase_auth/user-not-found';
      final result = AuthErrorHandler.handle(error);
      expect(result, 'Usuário não encontrado. Verifique seu e-mail.');
    });

    test('deve retornar mensagem amigável para erro wrong-password', () {
      const error = 'firebase_auth/wrong-password';
      final result = AuthErrorHandler.handle(error);
      expect(result, 'Senha incorreta. Tente novamente.');
    });

    test('deve retornar mensagem padrão para erro desconhecido', () {
      const error = 'erro-aleatorio-desconhecido';
      final result = AuthErrorHandler.handle(error);
      expect(result, 'Ocorreu um erro inesperado. Tente novamente.');
    });
  });
}
