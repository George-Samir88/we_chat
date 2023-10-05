import 'package:flutter/material.dart';
import 'package:we_chat/features/chat/presentation/widgets/message_card.dart';

import '../../../../core/global_var.dart';
import '../../manager/models/message_model.dart';

class CustomMessageCardListView extends StatefulWidget {
  CustomMessageCardListView({Key? key, required this.messages})
      : super(key: key);

  final List<MessageModel> messages;

  @override
  State<CustomMessageCardListView> createState() =>
      CustomMessageCardListViewState();
}

class CustomMessageCardListViewState extends State<CustomMessageCardListView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        itemBuilder: (context, index) {
          return widget.messages[index].fromId == me.id
              ? SenderMessageCard(
                  message: widget.messages[index],
                )
              : ReceiverMessageCard(
                  message: widget.messages[index],
                );
        },
        itemCount: widget.messages.length);
  }
}
