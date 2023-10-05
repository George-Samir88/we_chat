import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/core/widgets/custom_alert_message.dart';

import '../../../../core/widgets/custom_error_widget.dart';
import '../../manager/cubit/chat_cubit.dart';
import '../../manager/cubit/chat_state.dart';
import 'custom_message_card_list_view.dart';

class ChatUserBlocConsumer extends StatelessWidget {
  const ChatUserBlocConsumer({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(listener: (context, state) {
      if (state is ChatGetMessagesError) {
        customAlertMessage(
            message: 'an error occurred ${state.error}',
            backgroundColor: Colors.red);
      }
    }, builder: (context, state) {
      if (state is ChatGetMessagesError) {
        return CustomErrorWidget(error: state.error);
      } else if (state is ChatGetMessagesSuccess) {
        if (state.messages.isEmpty) {
          return Center(
            child: Text('Say hallo 👋'),
          );
        } else {
          return CustomMessagesListView(
            scrollController: _scrollController,
            messages: state.messages,
          );
        }
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
