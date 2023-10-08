import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:we_chat/features/chat/manager/cubits/chat_cubit/chat_cubit.dart';
import 'package:we_chat/features/chat/manager/models/message_model.dart';

import '../../../../core/global_var.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: screenSize.width * 0.02,
            ),
            if (message.read.isNotEmpty)
              Icon(
                Icons.done_all_rounded,
                size: 24,
                color: Colors.blue,
              ),
            if (message.read.isNotEmpty)
              SizedBox(
                width: 4,
              ),
            Text(
              DateFormat.jm().format(DateTime.parse(message.sent)),
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
          ],
        ),
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              top: screenSize.height * 0.015,
              left: screenSize.height * 0.02,
              right: screenSize.height * 0.02,
            ),
            padding: EdgeInsets.all(screenSize.height * 0.02),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightGreen),
              color: Color.fromARGB(255, 218, 255, 176),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Text(
              message.msg,
            ),
          ),
        ),
      ],
    );
  }
}

class ReceiverMessageCard extends StatelessWidget {
  const ReceiverMessageCard({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    if (message.read.isEmpty) {
      markMessageAsRead(messageModel: message);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              top: screenSize.height * 0.015,
              left: screenSize.height * 0.02,
              right: screenSize.height * 0.02,
            ),
            padding: EdgeInsets.all(screenSize.height * 0.02),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlue),
              color: Color.fromARGB(255, 221, 245, 255),
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
        ),
        Padding(
          padding: EdgeInsets.only(
            right: screenSize.width * 0.02,
          ),
          child: Text(
            DateFormat.jm().format(DateTime.parse(message.sent)),
            style: TextStyle(color: Colors.black54, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
