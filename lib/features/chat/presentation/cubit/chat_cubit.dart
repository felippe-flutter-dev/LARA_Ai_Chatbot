import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:lara_ai/core/data/services/auth_service.dart';
import 'package:lara_ai/core/errors/ai_error/ai_error_handler.dart';
import 'package:lara_ai/core/errors/ai_error/ai_error_type.dart';
import 'package:lara_ai/features/chat/domain/repositories/i_chat_repository.dart';
import '../../domain/entities/chat_message.dart';
import 'chat_states.dart';
import 'chat_stream_handler.dart';

class ChatCubit extends Cubit<ChatState> {
  final IChatRepositoryCustom repository;
  final AuthService _authService;
  final ChatStreamHandler _handler;

  final List<ChatMessage> _messages = [];

  ChatCubit(this.repository, this._authService)
    : _handler = ChatStreamHandler(repository),
      super(ChatInitial()) {
    try {
      repository.initChat();
    } catch (e) {
      if (kDebugMode) debugPrint('initChat failed: $e');
    }

    Future.microtask(() => newEmptyConversation());
  }

  String? get _userId => _authService.currentUser?.uid;

  Future<void> newEmptyConversation() async {
    repository.resetCurrentConversation();
    _messages.clear();
    emit(ChatUpdated(messages: List.from(_messages), isTyping: false));
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || _userId == null) return;

    try {
      if (repository.currentConversationId == null) {
        final snippet = _makeSnippet(text);
        final id = await repository.createConversation(snippet, _userId!);
        await repository.selectConversation(id);
      }
    } catch (e) {
      if (kDebugMode) debugPrint('failed to create/select conversation: $e');
    }

    _addUserMessage(text);
    _showTypingPlaceholder();

    await _handler.processMessage(
      text,
      onChunkReceived: (fullText) => _updateLastAIMessage(fullText),
      onComplete: (fullText) => _finalizeLastAIMessage(fullText),
      onError: (error) => _handleError(error),
    );
  }

  String _makeSnippet(String text, {int maxLen = 60}) {
    final trimmed = text.trim();
    if (trimmed.length <= maxLen) return trimmed;
    return '${trimmed.substring(0, maxLen).trim()}...';
  }

  void _addUserMessage(String text) {
    _messages.add(
      ChatMessage(text: text, isUser: true, timestamp: DateTime.now()),
    );
    emit(ChatUpdated(messages: List.from(_messages), isTyping: true));
  }

  void _showTypingPlaceholder() {
    _messages.add(
      ChatMessage(text: '...', isUser: false, timestamp: DateTime.now()),
    );
    emit(ChatUpdated(messages: List.from(_messages), isTyping: true));
  }

  void _updateLastAIMessage(String fullText) {
    if (_messages.isNotEmpty) {
      _messages[_messages.length - 1] = ChatMessage(
        text: fullText,
        isUser: false,
        timestamp: DateTime.now(),
      );
    }
    emit(ChatUpdated(messages: List.from(_messages), isTyping: true));
  }

  void _finalizeLastAIMessage(String fullText) async {
    if (_messages.isNotEmpty) {
      _messages[_messages.length - 1] = ChatMessage(
        text: fullText,
        isUser: false,
        timestamp: DateTime.now(),
      );
    }
    emit(ChatUpdated(messages: List.from(_messages), isTyping: false));

    final currentId = repository.currentConversationId;
    if (currentId != null && fullText.isNotEmpty) {
      final preview = fullText.length > 70
          ? '${fullText.substring(0, 67)}...'
          : fullText;
      await repository.updateLastMessage(currentId, preview);
    }

    try {
      final currentId = repository.currentConversationId;
      if (currentId != null) {
        final title = await repository.getConversationTitle(currentId);
        final shouldUpdate =
            (title == null ||
            title.isEmpty ||
            title == 'Conversa' ||
            title == 'Nova conversa');
        if (shouldUpdate && _messages.isNotEmpty) {
          final firstUser = _messages.firstWhere(
            (m) => m.isUser,
            orElse: () => ChatMessage(text: '', isUser: true),
          );
          final snippet = _makeSnippet(firstUser.text);
          await repository.updateConversationTitle(currentId, snippet);
        }
      }
    } catch (e) {
      if (kDebugMode) debugPrint('failed to update conversation title: $e');
    }
  }

  void _handleError(dynamic error) {
    if (_messages.isNotEmpty && _messages.last.text == '...') {
      _messages.removeLast();
    }
    if (_messages.isNotEmpty && _messages.last.isUser) {
      _messages.removeLast();
    }

    final AiErrorType userFriendlyError = AiErrorHandler.handle(error);

    emit(
      ChatError(
        userFriendlyError,
        messages: List.from(_messages),
        isTyping: false,
      ),
    );
  }

  Future<List> listConversations() async {
    if (_userId == null) return [];
    return await repository.listConversations(_userId!);
  }

  Future<int> createConversation(String title) async {
    if (_userId == null) throw Exception("User not logged in");
    final id = await repository.createConversation(title, _userId!);
    await repository.selectConversation(id);
    final msgs = await repository.loadConversationMessages(id);
    _messages
      ..clear()
      ..addAll(msgs);
    emit(ChatUpdated(messages: List.from(_messages), isTyping: false));
    return id;
  }

  Future<void> selectConversation(int id) async {
    await repository.selectConversation(id);
    final msgs = await repository.loadConversationMessages(id);
    _messages
      ..clear()
      ..addAll(msgs);
    emit(ChatUpdated(messages: List.from(_messages), isTyping: false));
  }

  Future<void> deleteConversation(int id) async {
    final isDeletingCurrent = repository.currentConversationId == id;
    await repository.deleteConversation(id);
    if (isDeletingCurrent) {
      await newEmptyConversation();
    }
  }
}
