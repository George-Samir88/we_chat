import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/core/widgets/custom_alert_message.dart';
import 'package:we_chat/features/auth/login/presentation/login_view.dart';
import 'package:we_chat/features/home/presentation/widgets/home_view_body.dart';

import '../../../core/function/cache_token.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.home),
        title: Text('We Chat'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
        child: FloatingActionButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            // Remove data for the 'token' key.
            removeDataFromSharedPreferences(key: 'token');
            customAlertMessage(
                message: 'Signed out successfully',
                backgroundColor: Colors.green);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginView()));
          },
          child: Icon(
            Icons.add_comment_rounded,
          ),
        ),
      ),
      body: HomeViewBody(),
    );
  }
}
