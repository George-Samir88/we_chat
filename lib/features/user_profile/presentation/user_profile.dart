import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';
import 'package:we_chat/features/user_profile/presentation/widget/user_profile_body.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key, required this.chatUser});

  final ChatUser chatUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.home),
        title: Text('We Chat'),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
            bottom: screenSize.height * 0.035, right: screenSize.width * 0.01),
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: Text(
            'Update',
            style: TextStyle(fontSize: 16.0),
          ),
          icon: Icon(
            Icons.edit,
          ),
        ),
      ),
      body: UserProfileBody(
        chatUser: chatUser,
      ),
    );
  }
}
