import 'package:flutter/material.dart';
import 'package:we_chat/features/chat/presentation/widgets/message_card.dart';

import '../../../../core/global_var.dart';
import '../../manager/models/message_model.dart';

class CustomMessageCardListView extends StatelessWidget {
  const CustomMessageCardListView({super.key, required this.messages});

  final List<MessageModel> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return messages[index].fromId == me.id
              ? SenderMessageCard(
                  message: messages[index],
                )
              : ReceiverMessageCard(
                  message: messages[index],
                );
        },
        itemCount: messages.length);
  }
}
