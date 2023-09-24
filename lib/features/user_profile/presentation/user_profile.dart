import 'package:flutter/material.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';
import 'package:we_chat/features/user_profile/presentation/widget/user_profile_body.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key, required this.chatUser});

  final ChatUser chatUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserProfileBody(
        chatUser: chatUser,
      ),
    );
  }
}
