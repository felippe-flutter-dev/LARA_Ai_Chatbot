class AiErrorHandler {
  static String handle(dynamic error) {
    final String msg = error.toString().toLowerCase();

    if (msg.contains('safety')) {
      return 'Ops! Este assunto é um pouco sensível para mim e não posso responder. Vamos falar de outra coisa?';
    } else if (msg.contains('quota') || msg.contains('429')) {
      return 'Estou um pouco sobrecarregada agora com muitos pedidos. Pode tentar novamente em um minutinho?';
    } else if (msg.contains('network') ||
        msg.contains('socketexception') ||
        msg.contains('connection')) {
      return 'Parece que perdi o sinal por um momento. Verifique sua conexão e tente me perguntar de novo!';
    } else if (msg.contains('api key') ||
        msg.contains('403') ||
        msg.contains('401')) {
      return 'Estou com um problema técnico na minha configuração (chave de acesso). Avise o suporte, por favor!';
    } else if (msg.contains('invalid') || msg.contains('400')) {
      return 'Tive um pequeno problema ao processar sua mensagem. Pode tentar reescrevê-la de outra forma?';
    } else if (msg.contains('500') || msg.contains('server error')) {
      return 'Meus servidores estão passando por uma manutenção rápida. Tente novamente em breve!';
    }

    return 'Tive um probleminha interno e não consegui te responder agora. Pode tentar de novo?';
  }
}
