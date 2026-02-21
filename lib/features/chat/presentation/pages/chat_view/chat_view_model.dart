import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_assets.dart';
import '../../../domain/entities/chat_message.dart';
import '../../../domain/entities/conversation.dart';
import '../../cubit/chat_cubit.dart';
import '../../cubit/chat_states.dart';

class ChatViewModel {
  final ChatCubit cubit;

  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  ChatViewModel(this.cubit);

  // ─────────────────────────────────────────────────────────────
  // Getters que a View usa (sem ficar verificando tipo de estado)
  // ─────────────────────────────────────────────────────────────
  List<ChatMessage> get messages {
    final state = cubit.state;
    if (state is ChatUpdated) return state.messages;
    if (state is ChatError) return state.messages; // ← ADICIONE
    return [];
  }

  bool get isTyping {
    final state = cubit.state;
    if (state is ChatUpdated) return state.isTyping;
    if (state is ChatError) return state.isTyping; // ← ADICIONE
    return false;
  }

  // ─────────────────────────────────────────────────────────────
  // Ações da tela (View chama isso)
  // ─────────────────────────────────────────────────────────────
  Future<void> newEmptyConversation() async {
    await cubit.newEmptyConversation();
    scrollToBottom();
  }

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    cubit.sendMessage(text);
    textController.clear();

    // rola automaticamente depois de enviar
    scrollToBottom(duration: const Duration(milliseconds: 80));
  }

  Future<List<Conversation>> getConversations() async {
    final convos = await cubit.listConversations();
    // cast to domain type if necessary
    return convos.cast<Conversation>();
  }

  Future<int> createConversation(String title) async {
    final id = await cubit.createConversation(title);
    return id;
  }

  Future<void> selectConversation(int id) async {
    await cubit.selectConversation(id);
    // load messages happens inside cubit; ensure UI scrolls to bottom
    scrollToBottom(duration: const Duration(milliseconds: 120));
  }

  Future<void> deleteConversation(int id) async {
    await cubit.deleteConversation(id);
  }

  void scrollToBottom({Duration duration = const Duration(milliseconds: 250)}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;
      try {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: duration,
          curve: Curves.easeOut,
        );
      } catch (_) {
        // ignora race conditions rápidas
      }
    });
  }

  String getBackgroundImage(Brightness brightness) {
    return brightness == Brightness.dark
        ? AppAssets.backgroundImageChatDark
        : AppAssets.backgroundImageChatLight;
  }

  void dispose() {
    textController.dispose();
    scrollController.dispose();
  }
}
