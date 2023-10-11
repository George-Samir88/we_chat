import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/features/chat/presentation/widgets/send_message_section.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

import '../../manager/cubits/get_messages_cubit/get_messages_cubit.dart';
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
    context.read<GetMessagesCubit>().getAllMessages(chatUser: widget.chatUser);
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
          child: GestureDetector(onTap:(){
            FocusScope.of(context).unfocus();
          },
            child: ChatUserBlocConsumer(scrollController: _scrollController),),
        ),
        SendMessageSection(widget: widget, scrollController: _scrollController),
      ],
    );
  }
}
