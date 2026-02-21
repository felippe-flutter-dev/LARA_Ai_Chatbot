import '../entities/chat_message.dart';
import '../entities/conversation.dart';

abstract class IChatRepositoryCustom {
  Stream<String> sendMessage(String message);
  List<ChatMessage> get history;
  void initChat();

  Future<String> sendMessageOnce(String message);
  Future<void> persistAiMessage(String text);
  Future<void> persistUserMessage(String text);

  Future<int> createConversation(String title, String userId);
  void resetCurrentConversation();
  Future<List<Conversation>> listConversations(String userId);
  Future<List<ChatMessage>> loadConversationMessages(int conversationId);
  Future<void> updateLastMessage(int conversationId, String lastMessage);
  Future<void> deleteConversation(int conversationId);
  Future<void> selectConversation(int conversationId);

  int? get currentConversationId;
  Future<void> updateConversationTitle(int conversationId, String title);
  Future<String?> getConversationTitle(int conversationId);
}
