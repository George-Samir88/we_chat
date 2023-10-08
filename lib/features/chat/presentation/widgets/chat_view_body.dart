import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/features/chat/manager/cubits/chat_cubit/chat_cubit.dart';
import 'package:we_chat/features/chat/presentation/widgets/send_message_section.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

import 'chat_user_bloc_consumer.dart';

class ChatViewBody extends StatefulWidget {
  ChatViewBody({
    super.key,
    required this.chatUser,
  });

  final ChatUser chatUser;

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<ChatCubit>().getAllMessages(chatUser: widget.chatUser);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ChatUserBlocConsumer(scrollController: _scrollController),
        ),
        SendMessageSection(widget: widget, scrollController: _scrollController),
      ],
    );
  }
}
