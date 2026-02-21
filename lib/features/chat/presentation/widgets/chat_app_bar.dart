import 'package:flutter/material.dart';

class ChatAppBar extends StatefulWidget {
  const ChatAppBar({super.key});

  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: AppBar(
          elevation: 4,
          shadowColor: Colors.black,
          toolbarHeight: 64,
          title: const Text("LARA"),
          centerTitle: true,
        ),
      ),
    );
  }
}
