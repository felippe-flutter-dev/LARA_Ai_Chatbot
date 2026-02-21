import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lara_ai/core/theme/app_colors.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../cubit/chat_cubit.dart';
import '../../cubit/chat_states.dart';
import '../../widgets/chat_bubble.dart';
import 'chat_view_model.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final ChatViewModel _vm;
  List<_ConversationListItem> _conversations = [];
  bool _loadingConvos = false;

  @override
  void initState() {
    super.initState();
    _vm = ChatViewModel(context.read<ChatCubit>());
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    setState(() => _loadingConvos = true);
    try {
      final convos = await _vm.getConversations();
      if (!mounted) return;
      setState(() {
        _conversations = convos
            .map((c) => _ConversationListItem(id: c.id, title: c.title))
            .toList();
      });
    } catch (e) {
      // ignore for now; UI will show empty list
    } finally {
      if (mounted) setState(() => _loadingConvos = false);
    }
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: const Text('Conversas'),
                trailing: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    // create a new conversation automatically
                    final id = await _vm.createConversation('Conversa');
                    await _loadConversations();
                    await _vm.selectConversation(id);
                    if (!mounted) return;
                    Navigator.of(context).pop();
                  },
                ),
              ),
              if (_loadingConvos) const LinearProgressIndicator(),
              Expanded(
                child: _conversations.isEmpty
                    ? const Center(child: Text('Nenhuma conversa ainda'))
                    : ListView.builder(
                        itemCount: _conversations.length,
                        itemBuilder: (context, index) {
                          final c = _conversations[index];
                          return ListTile(
                            title: Text(c.title),
                            onTap: () async {
                              final navigator = Navigator.of(context);
                              await _vm.selectConversation(c.id);
                              if (!mounted) return;
                              navigator.pop();
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
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
            child: Column(
              children: [
                SafeArea(
                  // 1. Protege contra o recorte da barra de status
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      0,
                      16,
                      0,
                    ), // 2. O respiro lateral e superior
                    child: AppBar(
                      elevation: 4,
                      shadowColor: Colors.black,
                      toolbarHeight: 64,
                      // 3. Define uma altura fixa para centralizar o conteúdo
                      title: const Text("LARA"),
                      centerTitle: true,
                      // O arredondamento de 18 vem do seu Theme que configuramos antes
                    ),
                  ),
                ),
                Expanded(
                  child: BlocListener<ChatCubit, ChatState>(
                    listener: (context, state) {
                      if (state is ChatUpdated) {
                        _vm.scrollToBottom(); // ← ViewModel cuida do scroll
                      } else if (state is ChatError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    child: BlocBuilder<ChatCubit, ChatState>(
                      builder: (context, state) {
                        return ListView.builder(
                          controller: _vm.scrollController,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 8,
                          ),
                          itemCount: _vm.messages.length,
                          itemBuilder: (context, index) {
                            final msg = _vm.messages[index];

                            return Column(
                              crossAxisAlignment: msg.isUser
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                ChatBubble(message: msg),
                                if (!msg.isUser &&
                                    index == _vm.messages.length - 1 &&
                                    _vm.isTyping)
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      left: 20,
                                      bottom: 10,
                                    ),
                                    child: SizedBox(
                                      width: 12,
                                      height: 12,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                _buildInput(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(BuildContext context) {
    return Padding(
      // Padding para o input não colar no teclado/fundo
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      child: ConstrainedBox(
        // Define os limites: começa pequeno e cresce até onde você quiser
        constraints: const BoxConstraints(
          minHeight: 56,
          maxHeight: 150, // Ajuste aqui o "X" (altura máxima antes de rolar)
        ),
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              // Mantém botões alinhados na base
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.settings),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: TextField(
                      controller: _vm.textController,
                      // MULTILINE: Isso faz a mágica
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      // Sobe até 5 linhas, depois disso rola
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textOnDark,
                      ),
                      decoration: InputDecoration(
                        // Usar contentPadding aqui ajuda a centralizar o texto inicial
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        border: InputBorder.none, // Melhor dentro de Card
                        hintText:
                            context.localization?.chat_inputHint ??
                            'sem hint aqui',
                        hintStyle: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textOnDark.withOpacity(0.5),
                        ),
                      ),
                      // Nota: onSubmitted em multiline não funciona via teclado (Enter pula linha)
                      // O envio deve ser pelo botão de Send
                    ),
                  ),
                ),
                BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: IconButton(
                        onPressed: _vm.isTyping ? null : _vm.sendMessage,
                        icon: _vm.isTyping
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(LucideIcons.send),
                      ),
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

class _ConversationListItem {
  final int id;
  final String title;

  _ConversationListItem({required this.id, required this.title});
}
