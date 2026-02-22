import 'package:lara_ai/features/chat/domain/repositories/i_chat_repository.dart';
import '../../../../core/data/services/gemini_services.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/conversation.dart';
import '../../../../core/data/local/conversation_dao.dart';
import '../../../../core/data/local/models.dart';

class ChatRepositoryImpl implements IChatRepositoryCustom {
  final GeminiChatService _service;
  final ConversationDao _dao;
  int? _currentConversationId;

  ChatRepositoryImpl(this._service, this._dao);

  @override
  Future<int> createConversation(String title, String userId) async {
    final id = await _dao.createConversation(title, userId);
    _currentConversationId = id;
    return id;
  }

  @override
  void resetCurrentConversation() {
    _currentConversationId = null;
  }

  @override
  Future<List<Conversation>> listConversations(String userId) async {
    final rows = await _dao.listConversations(userId);
    return rows
        .map(
          (r) => Conversation(
            id: r.id ?? 0,
            title: r.title,
            lastMessage: r.lastMessage,
            createdAt: r.createdAt,
            updateAt: r.updateAt,
          ),
        )
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
    final messages = await loadConversationMessages(conversationId);
    _service.startChatFromMessages(messages);
  }

  @override
  Stream<String> sendMessage(String message) async* {
    await for (final chunk in _service.sendMessageStream(message)) {
      yield chunk;
    }
  }

  @override
  void initChat() => _service.initChat();

  @override
  List<ChatMessage> get history => [];

  @override
  Future<String> sendMessageOnce(String message) async {
    final result = await _service.sendMessageOnce(message);
    if (_currentConversationId != null) {
      final m = MessageEntity(
        conversationId: _currentConversationId!,
        text: result,
        isUser: false,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      await _dao.addMessage(m);
    }
    return result;
  }

  @override
  Future<void> persistAiMessage(String text) async {
    if (_currentConversationId != null) {
      final m = MessageEntity(
        conversationId: _currentConversationId!,
        text: text,
        isUser: false,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      await _dao.addMessage(m);
    }
  }

  @override
  Future<void> persistUserMessage(String text) async {
    if (_currentConversationId != null) {
      final m = MessageEntity(
        conversationId: _currentConversationId!,
        text: text,
        isUser: true,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      await _dao.addMessage(m);
    }
  }

  @override
  Future<List<ChatMessage>> loadConversationMessages(int conversationId) async {
    final rows = await _dao.getMessages(conversationId);
    return rows
        .map(
          (m) => ChatMessage(
            text: m.text,
            isUser: m.isUser,
            timestamp: DateTime.fromMillisecondsSinceEpoch(m.createdAt),
          ),
        )
        .toList();
  }

  @override
  Future<void> updateLastMessage(int conversationId, String lastMessage) async {
    await _dao.updateLastMessage(conversationId, lastMessage);
  }

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
