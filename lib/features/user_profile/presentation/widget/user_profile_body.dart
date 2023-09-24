import 'package:flutter/material.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({super.key, required this.chatUser});
  final ChatUser chatUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(chatUser.email)
      ],
    );
  }
}
