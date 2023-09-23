import 'package:flutter/material.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/features/home/presentation/widgets/chat_user_card.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenSize.height * 0.008, bottom: screenSize.height * 0.008),
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ChatUserCard();
          },
          itemCount: 10),
    );
  }
}
