import '../entities/chat_message.dart';
import '../entities/conversation.dart';

abstract class IChatRepositoryCustom {
  Stream<String> sendMessage(String message);
  List<ChatMessage> get history;
  void initChat();

  // Fallback: get full response in one call (non-stream). Useful when the
  // streaming endpoint doesn't emit chunks or when network buffers delay SSE.
  Future<String> sendMessageOnce(String message);

  // Persist an AI message to current conversation
  Future<void> persistAiMessage(String text);

  // Persist a user message to current conversation (only when AI responds)
  Future<void> persistUserMessage(String text);

  // Conversation management
  Future<int> createConversation(String title);
  Future<List<Conversation>> listConversations();
  Future<List<ChatMessage>> loadConversationMessages(int conversationId);
  Future<void> deleteConversation(int conversationId);
  Future<void> selectConversation(int conversationId);

  // New helpers
  int? get currentConversationId;
  Future<void> updateConversationTitle(int conversationId, String title);

  // Read conversation title
  Future<String?> getConversationTitle(int conversationId);
}
