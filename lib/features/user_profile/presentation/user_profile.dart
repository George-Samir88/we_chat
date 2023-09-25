import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';
import 'package:we_chat/features/user_profile/presentation/widget/user_profile_body.dart';

import '../../../core/function/cache_token.dart';
import '../../../core/widgets/custom_alert_message.dart';
import '../../auth/login/presentation/login_view.dart';

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
          onPressed: () async {
            await FirebaseAuth.instance.signOut().then((value) async {
              await GoogleSignIn().signOut().then((value) {
                // Remove data for the 'token' key.
                removeDataFromSharedPreferences(key: 'token');
                customAlertMessage(
                    message: 'Logged out successfully',
                    backgroundColor: Colors.green);
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginView()));
              });
            });
          },
          backgroundColor: Colors.red,
          label: Text(
            'Logout',
            style: TextStyle(fontSize: 16.0),
          ),
          icon: Icon(
            Icons.add_comment_rounded,
          ),
        ),
      ),
      body: UserProfileBody(
        chatUser: chatUser,
      ),
    );
  }
}
