import 'package:lara_ai/core/errors/ai_error/ai_error_type.dart';

import '../../domain/entities/chat_message.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatUpdated extends ChatState {
  final List<ChatMessage> messages;
  final bool isTyping; // Para mostrar um indicador de "Lara pensando"

  ChatUpdated({required this.messages, this.isTyping = false});
}

class ChatError extends ChatState {
  final AiErrorType errorType;
  final List<ChatMessage> messages; // ← NOVO
  final bool isTyping;

  ChatError(this.errorType, {required this.messages, this.isTyping = false});
}
