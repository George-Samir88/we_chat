import 'package:flutter/material.dart';
import 'package:we_chat/features/chat/presentation/widgets/send_message_section.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SendMessageSection(),
      ],
    );
  }
}