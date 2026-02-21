import 'package:flutter/material.dart';
import 'package:lara_ai/core/theme/app_assets.dart';
import 'package:lara_ai/core/theme/app_colors.dart';
import 'package:lara_ai/features/chat/presentation/cubit/lara_settings/lara_settings_cubit.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';
import '../../../domain/entities/chat_message.dart';
import '../../../domain/entities/conversation_list_item.dart';
import '../../cubit/chat_cubit.dart';
import '../../cubit/chat_states.dart';

class ChatViewModel {
  final ChatCubit cubit;
  final LaraSettingsCubit settingsCubit;

  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  String? _lastUserMessage;

  ChatViewModel(this.cubit, this.settingsCubit);

  List<ChatMessage> get messages {
    final state = cubit.state;
    if (state is ChatUpdated) return state.messages;
    if (state is ChatError) return state.messages;
    return [];
  }

  bool get isTyping {
    final state = cubit.state;
    if (state is ChatUpdated) return state.isTyping;
    if (state is ChatError) return state.isTyping;
    return false;
  }

  void stateObserver(BuildContext context, ChatState state) {
    if (state is ChatUpdated) {
      scrollToBottom();
    } else if (state is ChatError) {
      if (_lastUserMessage != null && textController.text.isEmpty) {
        textController.text = _lastUserMessage!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> newEmptyConversation() async {
    await cubit.newEmptyConversation();
    scrollToBottom();
  }

  void sendMessage(BuildContext context) {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    _lastUserMessage = text;
    cubit.sendMessage(text);
    textController.clear();

    scrollToBottom(duration: const Duration(milliseconds: 80));
  }

  Future<List<ConversationListItem>> getConversations(
    BuildContext context,
  ) async {
    final convos = await cubit.listConversations();
    return convos
        .map(
          (c) => ConversationListItem(
            id: c.id,
            title: c.title,
            lastMessage: c.lastMessage,
            lastMessageDate: c.updateAt,
          ),
        )
        .toList();
  }

  Future<void> selectConversation(int id) async {
    await cubit.selectConversation(id);
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
      } catch (_) {}
    });
  }

  String getBackgroundImage(Brightness brightness) {
    return brightness == Brightness.dark
        ? AppAssets.backgroundImageChatDark
        : AppAssets.backgroundImageChatLight;
  }

  String formatTime(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String formatRelativeTime(int time, BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(
      DateTime.fromMillisecondsSinceEpoch(time),
    );
    if (difference.inDays >= 1) {
      return context.localization!.time_days(difference.inDays);
    } else if (difference.inHours >= 1) {
      return context.localization!.time_hours(difference.inHours);
    } else if (difference.inMinutes >= 1) {
      return context.localization!.time_minutes(difference.inMinutes);
    } else {
      return context.localization!.time_just_now;
    }
  }

  void dispose() {
    textController.dispose();
    scrollController.dispose();
  }
}
