import 'package:flutter_test/flutter_test.dart';
import 'package:lara_ai/core/errors/ai_error/ai_error_handler.dart';
import 'package:lara_ai/core/errors/ai_error/ai_error_type.dart';

void main() {
  group('AiErrorHandler', () {
    test(
      'deve retornar AiErrorType.safety quando o erro contiver "safety"',
      () {
        const error = 'The response was blocked due to safety filters.';
        final result = AiErrorHandler.handle(error);
        expect(result, AiErrorType.safety);
      },
    );

    test('deve retornar AiErrorType.quota quando o erro for 429 ou quota', () {
      const error429 = 'Error 429: Rate limit exceeded';
      const errorQuota = 'Resource exhaust: quota exceeded';

      expect(AiErrorHandler.handle(error429), AiErrorType.quota);
      expect(AiErrorHandler.handle(errorQuota), AiErrorType.quota);
    });

    test('deve retornar AiErrorType.network para problemas de conexão', () {
      const error = 'SocketException: Connection failed';
      final result = AiErrorHandler.handle(error);
      expect(result, AiErrorType.network);
    });

    test(
      'deve retornar AiErrorType.config para problemas de API Key (401/403)',
      () {
        const error401 = 'Invalid API Key (401)';
        expect(AiErrorHandler.handle(error401), AiErrorType.config);
      },
    );

    test('deve retornar AiErrorType.unknown para erros genéricos', () {
      const error = 'algum erro bizarro que eu não mapeei';
      final result = AiErrorHandler.handle(error);
      expect(result, AiErrorType.unknown);
    });
  });
}
