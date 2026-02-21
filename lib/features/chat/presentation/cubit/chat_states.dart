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
  final String message;
  ChatError(this.message);
}
