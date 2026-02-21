import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_extension.dart';
import '../../../../l10n/extension_localizations.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_states.dart';
import '../pages/chat_view/chat_view_model.dart';

class ChatTextField extends StatefulWidget {
  final ChatViewModel vm;
  final ChatCubit cubit;
  const ChatTextField(this.vm, this.cubit, {super.key});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  @override
  Widget build(BuildContext context) {
    final vm = widget.vm;
    final cubit = widget.cubit;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 56.h, maxHeight: 150.h),
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(46.r),
          ),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.settings),
                ),
                Expanded(
                  child: TextField(
                    controller: vm.textController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textOnDark,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: context.localization!.chat_inputHint,
                      hintStyle: context.textTheme.bodyMedium,
                    ),
                  ),
                ),
                BlocBuilder<ChatCubit, ChatState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return IconButton(
                      onPressed: vm.isTyping ? null : vm.sendMessage,
                      icon: vm.isTyping
                          ? SizedBox(
                              width: 18.w,
                              height: 18.w,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(LucideIcons.send),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
