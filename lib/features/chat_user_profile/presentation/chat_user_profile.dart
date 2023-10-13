import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/features/chat_user_profile/presentation/widgets/chat_user_profile_body.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

class ChatUserProfile extends StatelessWidget {
  const ChatUserProfile({super.key, required this.chatUser});

  final ChatUser chatUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatUser.name),
      ),
      body: ChatUserProfileBody(chatUser: chatUser),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: screenSize.height * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: 'Joined at: ',
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
              TextSpan(
                text: formatDate(chatUser.createdAt),
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
            ])),
          ],
        ),
      ),
    );
  }

  String formatDate(String time) {
    print(time);
    DateTime now = DateTime.now();
    if (now.day == DateTime.parse(time).day &&
        now.month == DateTime.parse(time).month &&
        now.year == DateTime.parse(time).year) {
      return DateFormat.jm().format(DateTime.parse(time));
    }
    return DateFormat.yMd().format(DateTime.parse(time));
  }
}
