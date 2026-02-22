import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/features/chat/presentation/widgets/chat_app_bar.dart';
import 'package:lara_ai/features/chat/presentation/widgets/chat_builder.dart';
import 'package:lara_ai/features/chat/presentation/widgets/chat_drawer_menu.dart';
import '../../cubit/chat_cubit.dart';
import '../../widgets/chat_text_field.dart';
import 'chat_view_model.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final ChatViewModel _vm;
  late final ChatCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = Modular.get<ChatCubit>();
    _vm = Modular.get<ChatViewModel>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ChatDrawerMenu(_vm, mainContext: context),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_vm.getBackgroundImage(context.brightness)),
                  fit: BoxFit.cover,
                  opacity: 0.1,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: BlocProvider.value(
              value: _cubit,
              child: Column(
                children: [
                  ChatAppBar(),
                  Expanded(child: ChatBuilder(_vm, _cubit)),
                  ChatTextField(_vm, _cubit),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
