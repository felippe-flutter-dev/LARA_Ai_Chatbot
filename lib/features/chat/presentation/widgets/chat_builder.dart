import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/features/chat/presentation/pages/chat_view/chat_view_model.dart';

import '../cubit/chat_cubit.dart';
import '../cubit/chat_states.dart';
import 'chat_bubble.dart';

class ChatBuilder extends StatefulWidget {
  final ChatViewModel vm;
  final ChatCubit cubit;
  const ChatBuilder(this.vm, this.cubit, {super.key});

  @override
  State<ChatBuilder> createState() => _ChatBuilderState();
}

class _ChatBuilderState extends State<ChatBuilder> {
  @override
  Widget build(BuildContext context) {
    final vm = widget.vm;
    final cubit = widget.cubit;
    return BlocListener<ChatCubit, ChatState>(
      bloc: cubit,
      listener: (context, state) => vm.stateObserver(context, state),
      child: BlocBuilder<ChatCubit, ChatState>(
        bloc: cubit,
        builder: (context, state) {
          final messages = vm.messages;

          return ListView.builder(
            controller: vm.scrollController,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final msg = messages[index];

              return Column(
                crossAxisAlignment: msg.isUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  ChatBubble(message: msg, vm: vm),
                  if (!msg.isUser &&
                      index == messages.length - 1 &&
                      vm.isTyping)
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, bottom: 10.h),
                      child: SizedBox(
                        width: 12.w,
                        height: 12.w,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
