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
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );

            case ConnectionState.active:
            case ConnectionState.done:
              List<User> users = [];
              if (snapshot.hasData) {
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  users = snapshot.data!.docs
                      .map((e) =>
                          User.fromJson(e.data() as Map<String, dynamic>))
                      .toList();
                }
                if (users.isNotEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: screenSize.height * 0.008,
                        bottom: screenSize.height * 0.008),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ChatUserCard(
                            user: users[index],
                          );
                        },
                        itemCount: snapshot.data!.docs.length),
                  );
                } else {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(24)),
                      child: Text(
                        'No Connections Found!',
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  );
                }
              } else
                return Center(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(24)),
                    child: Text(
                      'No information',
                      style: TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                );
          }
        });
  }
}
