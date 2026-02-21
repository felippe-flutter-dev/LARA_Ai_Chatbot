import 'package:flutter/material.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import '../../domain/entities/chat_message.dart'; // Ajuste o path conforme sua estrutura

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth:
              MediaQuery.of(context).size.width *
              0.75, // Não deixa a bolha ocupar a tela toda
        ),
        decoration: BoxDecoration(
          color: message.isUser
              ? context.theme.colorScheme.primary
              : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: Radius.circular(message.isUser ? 15 : 0),
            bottomRight: Radius.circular(message.isUser ? 0 : 15),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? Colors.black87 : Colors.black,
          ),
        ),
      ),
    );
  }
}
