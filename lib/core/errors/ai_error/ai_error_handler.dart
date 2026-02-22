import 'package:lara_ai/core/errors/ai_error/ai_error_type.dart';

class AiErrorHandler {
  static AiErrorType handle(dynamic error) {
    final String msg = error.toString().toLowerCase();

    if (msg.contains('safety')) {
      return AiErrorType.safety;
    } else if (msg.contains('quota') || msg.contains('429')) {
      return AiErrorType.quota;
    } else if (msg.contains('network') ||
        msg.contains('socketexception') ||
        msg.contains('connection')) {
      return AiErrorType.network;
    } else if (msg.contains('api key') ||
        msg.contains('403') ||
        msg.contains('401')) {
      return AiErrorType.config;
    } else if (msg.contains('invalid') || msg.contains('400')) {
      return AiErrorType.invalid;
    } else if (msg.contains('500') || msg.contains('server error')) {
      return AiErrorType.server;
    }

    return AiErrorType.unknown;
  }
}
