import 'package:flutter/material.dart';
import 'package:we_chat/features/chat/manager/models/message_model.dart';

import '../../../../core/global_var.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.message});

  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: screenSize.height * 0.015,
          left: screenSize.height * 0.02,
          right: screenSize.height * 0.02,
        ),
        padding: EdgeInsets.all(screenSize.height * 0.02),
        decoration: BoxDecoration(
          color: Colors.green.shade200,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Text(
          message.msg,
        ),
      ),
    );
  }
}
