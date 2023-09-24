import 'package:flutter/material.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

import '../../../../core/global_var.dart';
import 'chat_user_card.dart';

class ChatUsersListView extends StatelessWidget {
  const ChatUsersListView({
    super.key,
    required this.users,
  });

  final List<ChatUser> users;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenSize.height * 0.008, bottom: screenSize.height * 0.008),
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ChatUserCard(
              user: users[index],
            );
          },
          itemCount: users.length),
    );
  }
}
