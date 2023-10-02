import 'package:flutter/material.dart';
import 'package:we_chat/features/chat/presentation/widgets/chat_view_body.dart';
import 'package:we_chat/features/chat/presentation/widgets/custom_flexible_app_bar.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.chatUser});

  final ChatUser chatUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: CustomFlexibleAppBar(
            chatUser: chatUser,
          ),
        ),
        body: ChatViewBody(),
      ),
    );
  }
}
