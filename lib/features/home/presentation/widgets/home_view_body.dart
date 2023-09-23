import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/features/home/presentation/widgets/chat_user_card.dart';

import '../../manager/models/user_model.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<User> users = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              Map<String, dynamic> data =
                  snapshot.data!.docs[i].data() as Map<String, dynamic>;
              users.add(User(Name: data['name'], about: data['about']));
            }
            return Padding(
              padding: EdgeInsets.only(
                  top: screenSize.height * 0.008,
                  bottom: screenSize.height * 0.008),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatUserCard(
                      name: users[index].Name,
                    );
                  },
                  itemCount: snapshot.data!.docs.length),
            );
          } else
            return Text('no data');
        });
  }
}
