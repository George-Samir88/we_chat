import 'package:flutter/material.dart';
import 'package:we_chat/features/chat/presentation/widgets/message_card.dart';

import '../../../../core/global_var.dart';
import '../../manager/models/message_model.dart';

class CustomMessagesListView extends StatelessWidget {
  const CustomMessagesListView({
    super.key,
    required ScrollController scrollController,
    required this.messages,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<MessageModel> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        reverse: true,
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
