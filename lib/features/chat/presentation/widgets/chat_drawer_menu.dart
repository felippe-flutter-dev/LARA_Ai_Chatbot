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
      final convos = await widget.vm.getConversations(context);
      if (!context.mounted) return;
      setState(() {
        _conversations = convos;
      });
    } catch (e) {
      // ignore
    } finally {
      if (context.mounted) setState(() => _loadingConvos = false);
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
                onPressed: () {
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
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                  ),
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    await widget.vm.newEmptyConversation();
                    if (!mounted) return;
                    navigator.pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(LucideIcons.plus, color: AppColors.gray50),
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
                            if (!context.mounted) return;
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
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: ChatDrawerItem(
                            conversation,
                            vm: vm,
                            onTap: () async {
                              final navigator = Navigator.of(context);
                              await vm.selectConversation(conversation.id);
                              if (!context.mounted) return;
                              navigator.pop();
                            },
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
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
