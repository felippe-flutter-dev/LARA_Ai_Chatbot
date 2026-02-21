import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/features/chat/presentation/pages/chat_view/chat_view_model.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/constants/font_sizes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/conversation_list_item.dart';
import 'chat_drawer_item.dart';

class ChatDrawerMenu extends StatefulWidget {
  final ChatViewModel vm;
  final BuildContext mainContext;

  const ChatDrawerMenu(this.vm, {super.key, required this.mainContext});

  @override
  State<ChatDrawerMenu> createState() => _ChatDrawerMenuState();
}

class _ChatDrawerMenuState extends State<ChatDrawerMenu> {
  List<ConversationListItem> _conversations = [];
  bool _loadingConvos = false;

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    setState(() => _loadingConvos = true);
    try {
      final convos = await widget.vm.getConversations();
      if (!mounted) return;
      setState(() {
        _conversations = convos
            .map(
              (c) => ConversationListItem(
                id: c.id,
                title: c.title,
                lastMessage: c.lastMessage,
                lastMessageDate: c.updateAt,
              ),
            )
            .toList();
      });
    } catch (e) {
      // ignore for now; UI will show empty list
    } finally {
      if (mounted) setState(() => _loadingConvos = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = widget.vm;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text(
                context.localization!.drawer_title,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontSize: FontSizes.headlineMedium,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(LucideIcons.x),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(26.r)),
                  gradient: AppColors.purpleGradient,
                ),
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                  ),
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    await widget.vm.newEmptyConversation();
                    await _loadConversations();
                    if (!mounted) return;
                    navigator.pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.plus,
                          color: AppColors.gray50,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          context.localization!.drawer_buttonNewChat,
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontSize: FontSizes.bodyLarge,
                            fontWeight: FontWeight.w700,
                            color: AppColors.gray50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (_loadingConvos) const LinearProgressIndicator(),
            Expanded(
              child: _conversations.isEmpty
                  ? Center(
                      child: Text(
                        context.localization!.drawer_emptyConversations,
                      ),
                    )
                  : ListView.builder(
                      itemCount: _conversations.length,
                      itemBuilder: (context, index) {
                        final conversation = _conversations[index];
                        return Dismissible(
                          key: Key(conversation.id.toString()),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (direction) async {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(
                              widget.mainContext,
                            ).showSnackBar(
                              SnackBar(
                                content: Text(
                                  context
                                      .localization!
                                      .common_deleteSuccessMessage,
                                  style: context.textTheme.bodyMedium,
                                ),
                                duration: const Duration(seconds: 1),
                                backgroundColor: AppColors.success,
                              ),
                            );
                            return true;
                          },
                          background: Container(
                            color: AppColors.error,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20.w),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (direction) async {
                            await widget.vm.deleteConversation(conversation.id);
                            await _loadConversations();
                          },
                          child: ChatDrawerItem(
                            conversation,
                            onTap: () async {
                              final navigator = Navigator.of(context);
                              await vm.selectConversation(conversation.id);
                              if (!mounted) return;
                              navigator.pop();
                            },
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(vertical: 16.h),
              child: Text(
                context.localization!.drawer_footerVersion,
                style: context.textTheme.bodySmall!.copyWith(
                  color: context.isDarkMode
                      ? AppColors.surfaceOverlay
                      : AppColors.gray500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
