import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/constants/font_sizes.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/features/chat/domain/entities/conversation_list_item.dart';
import 'package:lara_ai/features/chat/presentation/pages/chat_view/chat_view_model.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';

class ChatDrawerItem extends StatelessWidget {
  final ConversationListItem conversation;
  final ChatViewModel vm;
  final Function()? onTap;

  const ChatDrawerItem(
    this.conversation, {
    super.key,
    required this.vm,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 32.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.isDarkMode
                          ? AppColors.darkElevated
                          : AppColors.secondaryMain,
                    ),
                    child: Center(
                      child: Icon(
                        LucideIcons.messageSquare,
                        color: context.primaryColorScheme,
                        size: 35.r,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          conversation.title,
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontSize: FontSizes.bodyLarge,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          conversation.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall!.copyWith(
                            color: context.isDarkMode
                                ? AppColors.gray400
                                : AppColors.gray500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        _buildTextTime(conversation.lastMessageDate, context),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextTime(int time, BuildContext context) {
    final formattedTime = vm.formatRelativeTime(time, context);
    final color = context.isDarkMode
        ? AppColors.surfaceOverlay
        : AppColors.gray200;

    return Row(
      children: [
        Icon(LucideIcons.clock, size: 14.r, color: color),
        SizedBox(width: 4.w),
        Text(
          formattedTime,
          style: context.textTheme.labelSmall!.copyWith(color: color),
        ),
      ],
    );
  }
}
