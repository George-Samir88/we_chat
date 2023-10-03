import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/core/widgets/custom_alert_message.dart';

import '../../../../core/widgets/custom_error_widget.dart';
import '../../manager/cubit/chat_cubit.dart';
import '../../manager/cubit/chat_state.dart';
import 'custom_message_card_list_view.dart';

class ChatUserCubit extends StatelessWidget {
  const ChatUserCubit({super.key});

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
        return CustomMessageCardListView(
          messages: state.messages,
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
