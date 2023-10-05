import 'package:flutter/material.dart';
import 'package:we_chat/features/chat/presentation/widgets/send_message_section.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

import 'chat_user_bloc_consumer.dart';
import 'custom_message_card_list_view.dart';

class ChatViewBody extends StatelessWidget {
  ChatViewBody({super.key, required this.chatUser});

  final ChatUser chatUser;
  final GlobalKey<CustomMessageCardListViewState> listViewKey =
      GlobalKey<CustomMessageCardListViewState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ChatUserBlocConsumer(
          // listViewKey: listViewKey,
        )),
        SendMessageSection(
          // listViewKey: listViewKey,
          chatUser: chatUser,
        ),
      ],
    );
  }
}
