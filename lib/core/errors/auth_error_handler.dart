class AuthErrorHandler {
  static String handle(dynamic error) {
    final String code = error.toString();

    if (code.contains('user-not-found')) {
      return 'Usuário não encontrado. Verifique seu e-mail.';
    } else if (code.contains('wrong-password')) {
      return 'Senha incorreta. Tente novamente.';
    } else if (code.contains('email-already-in-use')) {
      return 'Este e-mail já está em uso por outra conta.';
    } else if (code.contains('invalid-email')) {
      return 'O formato do e-mail é inválido.';
    } else if (code.contains('weak-password')) {
      return 'A senha é muito fraca. Use pelo menos 6 caracteres.';
    } else if (code.contains('network-request-failed')) {
      return 'Erro de conexão. Verifique sua internet.';
    } else if (code.contains('too-many-requests')) {
      return 'Muitas tentativas. Tente novamente mais tarde.';
    } else if (code.contains('user-disabled')) {
      return 'Esta conta foi desativada.';
    } else if (code.contains('operation-not-allowed')) {
      return 'Login com e-mail e senha não está habilitado.';
    }

    return 'Ocorreu um erro inesperado. Tente novamente.';
  }
}
