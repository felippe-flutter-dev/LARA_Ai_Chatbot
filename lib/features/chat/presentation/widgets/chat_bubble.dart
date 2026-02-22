import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/features/chat/presentation/pages/chat_view/chat_view_model.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../domain/entities/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final ChatViewModel vm;

  const ChatBubble({super.key, required this.message, required this.vm});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final time = vm.formatTime(message.timestamp);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
                bottomLeft: Radius.circular(isUser ? 16.r : 0),
                bottomRight: Radius.circular(isUser ? 0 : 16.r),
              ),
            ),
            margin: EdgeInsets.symmetric(vertical: 4.h),
            color: isUser
                ? context.theme.colorScheme.primary
                : context.theme.cardColor,
            elevation: 2,
            child: Container(
              padding: EdgeInsets.all(12.r),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              child: GptMarkdown(
                message.text,
                style: TextStyle(
                  color: isUser
                      ? Colors.white
                      : context.theme.textTheme.bodyMedium?.color,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  LucideIcons.clock,
                  size: 10.r,
                  color: context.theme.hintColor,
                ),
                SizedBox(width: 4.w),
                Text(
                  time,
                  style: context.theme.textTheme.bodySmall?.copyWith(
                    fontSize: 10.sp,
                    color: context.theme.hintColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
