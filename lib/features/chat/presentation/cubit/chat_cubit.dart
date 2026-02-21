import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:lara_ai/features/chat/domain/repositories/i_chat_repository.dart';
import '../../domain/entities/chat_message.dart';
import 'chat_states.dart';
import 'chat_stream_handler.dart';

class ChatCubit extends Cubit<ChatState> {
  final IChatRepositoryCustom repository;
  final ChatStreamHandler _handler;

  final List<ChatMessage> _messages = [];

  ChatCubit(this.repository)
    : _handler = ChatStreamHandler(repository),
      super(ChatInitial()) {
    // try to warm up chat session to reduce first-response latency
    try {
      repository.initChat();
    } catch (e) {
      if (kDebugMode) debugPrint('initChat failed: $e');
    }

    // Ensure there's at least one conversation (run async)
    Future.microtask(() async {
      try {
        final convos = await repository.listConversations();
        if (convos.isEmpty) {
          final id = await repository.createConversation('Nova conversa');
          await repository.selectConversation(id);
          if (kDebugMode) {
            debugPrint('[ChatCubit] created default conversation id=$id');
          }
          // load messages (likely empty)
          final msgs = await repository.loadConversationMessages(id);
          _messages
            ..clear()
            ..addAll(msgs);
          emit(ChatUpdated(messages: List.from(_messages), isTyping: false));
        } else {
          // select the most recent conversation
          final firstId = convos.first.id;
          await repository.selectConversation(firstId);
          final msgs = await repository.loadConversationMessages(firstId);
          _messages
            ..clear()
            ..addAll(msgs);
          emit(ChatUpdated(messages: List.from(_messages), isTyping: false));
          if (kDebugMode) {
            debugPrint(
              '[ChatCubit] selected conversation id=${convos.first.id}',
            );
          }
        }
      } catch (e) {
        if (kDebugMode) debugPrint('[ChatCubit] conversation init error: $e');
      }
    });
  }

  Future<void> newEmptyConversation() async {
    repository.resetCurrentConversation();
    _messages.clear();
    emit(ChatUpdated(messages: List.from(_messages), isTyping: false));
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Ensure a conversation exists; if not, create one with title snippet from first message
    try {
      if (repository.currentConversationId == null) {
        final snippet = _makeSnippet(text);
        final id = await repository.createConversation(snippet);
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
      onError: (error) => _handleError(error), // ← MUDE PARA ISSO
    );
  }

  String _makeSnippet(String text, {int maxLen = 60}) {
    final trimmed = text.trim();
    if (trimmed.length <= maxLen) return trimmed;
    return '${trimmed.substring(0, maxLen).trim()}...';
  }

  // ── Métodos privados simples ──
  void _addUserMessage(String text) {
    _messages.add(ChatMessage(text: text, isUser: true));
    emit(ChatUpdated(messages: List.from(_messages), isTyping: true));
  }

  void _showTypingPlaceholder() {
    _messages.add(ChatMessage(text: '...', isUser: false));
    emit(ChatUpdated(messages: List.from(_messages), isTyping: true));
  }

  void _updateLastAIMessage(String fullText) {
    if (_messages.isNotEmpty) {
      _messages[_messages.length - 1] = ChatMessage(
        text: fullText,
        isUser: false,
      );
    }
    emit(ChatUpdated(messages: List.from(_messages), isTyping: true));
  }

  void _finalizeLastAIMessage(String fullText) async {
    if (_messages.isNotEmpty) {
      _messages[_messages.length - 1] = ChatMessage(
        text: fullText,
        isUser: false,
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

    // If conversation had no meaningful title, update it from first user message
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

  void _handleError(String error) {
    // Remove o placeholder de "..."
    if (_messages.isNotEmpty && _messages.last.text == '...') {
      _messages.removeLast();
    }
    emit(
      ChatError(
        'Erro na resposta: $error',
        messages: List.from(_messages),
        isTyping: false,
      ),
    );
  }

  // Optional: expose conversation helpers
  Future<List> listConversations() async =>
      await repository.listConversations();

  Future<int> createConversation(String title) async {
    final id = await repository.createConversation(title);
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
    await repository.deleteConversation(id);
    // if current messages belong to deleted conversation, clear
    _messages.clear();
    emit(ChatUpdated(messages: List.from(_messages), isTyping: false));
  }
}
