import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      listener: (context, state) {
        if (state is ChatUpdated) {
          vm.scrollToBottom();
        } else if (state is ChatError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return ListView.builder(
            controller: vm.scrollController,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            itemCount: vm.messages.length,
            itemBuilder: (context, index) {
              final msg = vm.messages[index];

              return Column(
                crossAxisAlignment: msg.isUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  ChatBubble(message: msg),
                  if (!msg.isUser &&
                      index == vm.messages.length - 1 &&
                      vm.isTyping)
                    const Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 10),
                      child: SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(strokeWidth: 2),
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
