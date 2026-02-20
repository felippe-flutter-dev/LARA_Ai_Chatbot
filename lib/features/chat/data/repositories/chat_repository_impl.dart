import 'package:lara_ai/features/chat/domain/repositories/i_chat_repository.dart';
import '../../../../core/data/services/gemini_services.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/conversation.dart';
import '../../../../core/data/local/conversation_dao.dart';
import '../../../../core/data/local/models.dart';

class ChatRepositoryImpl implements IChatRepositoryCustom {
  final GeminiChatService _service;
  final ConversationDao _dao = ConversationDao();
  int? _currentConversationId;

  ChatRepositoryImpl(this._service);

  // Create a new conversation and set it as current
  @override
  Future<int> createConversation(String title) async {
    final id = await _dao.createConversation(title);
    _currentConversationId = id;
    return id;
  }

  @override
  Future<List<Conversation>> listConversations() async {
    final rows = await _dao.listConversations();
    return rows
        .map((r) => Conversation(id: r.id ?? 0, title: r.title, createdAt: r.createdAt))
        .toList();
  }

  @override
  Future<void> deleteConversation(int conversationId) async {
    await _dao.deleteConversation(conversationId);
    if (_currentConversationId == conversationId) _currentConversationId = null;
  }

  @override
  Future<void> selectConversation(int conversationId) async {
    _currentConversationId = conversationId;
    // Load messages and initialize chat session with history so context is preserved
    final messages = await loadConversationMessages(conversationId);
    // Convert domain ChatMessage to service ChatMessage and start session
    _service.startChatFromMessages(messages);
  }

  @override
  Stream<String> sendMessage(String message) async* {
    // Persist user message
    if (_currentConversationId != null) {
      final m = MessageEntity(conversationId: _currentConversationId!, text: message, isUser: true, createdAt: DateTime.now().millisecondsSinceEpoch);
      await _dao.addMessage(m);
    }

    await for (final chunk in _service.sendMessageStream(message)) {
      yield chunk;
    }
  }

  @override
  void initChat() => _service.initChat();

  @override
  List<ChatMessage> get history => []; // Implementação simples por enquanto

  @override
  Future<String> sendMessageOnce(String message) async {
    final result = await _service.sendMessageOnce(message);
    // persist final result
    if (_currentConversationId != null) {
      final m = MessageEntity(conversationId: _currentConversationId!, text: result, isUser: false, createdAt: DateTime.now().millisecondsSinceEpoch);
      await _dao.addMessage(m);
    }
    return result;
  }

  @override
  Future<void> persistAiMessage(String text) async {
    if (_currentConversationId != null) {
      final m = MessageEntity(conversationId: _currentConversationId!, text: text, isUser: false, createdAt: DateTime.now().millisecondsSinceEpoch);
      await _dao.addMessage(m);
    }
  }

  @override
  Future<List<ChatMessage>> loadConversationMessages(int conversationId) async {
    final rows = await _dao.getMessages(conversationId);
    return rows
        .map((m) => ChatMessage(text: m.text, isUser: m.isUser))
        .toList();
  }

  // New helpers
  @override
  int? get currentConversationId => _currentConversationId;

  @override
  Future<void> updateConversationTitle(int conversationId, String title) async {
    await _dao.updateConversationTitle(conversationId, title);
  }

  @override
  Future<String?> getConversationTitle(int conversationId) async {
    final conv = await _dao.getConversation(conversationId);
    return conv?.title;
  }
}