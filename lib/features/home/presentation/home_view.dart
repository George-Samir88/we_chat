import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/core/widgets/custom_alert_message.dart';
import 'package:we_chat/features/auth/login/presentation/login_view.dart';

import 'package:we_chat/features/home/presentation/widgets/home_view_body.dart';

import '../../../core/function/cache_token.dart';
import '../../user_profile/presentation/user_profile.dart';
import '../manager/cubit/home_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    if (!isFetchingChatUsers) {
      BlocProvider.of<HomeCubit>(context).getChatUsers();
    }
    isFetchingChatUsers = false;
    super.initState();
  }

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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfile(
                    chatUser:
                        BlocProvider.of<HomeCubit>(context).currentChatUser,
                  ),
                ),
              );
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
        child: FloatingActionButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
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
