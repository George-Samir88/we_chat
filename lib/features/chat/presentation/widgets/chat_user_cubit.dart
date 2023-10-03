import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/features/chat/presentation/widgets/message_card.dart';

import '../../../../core/widgets/custom_error_widget.dart';
import '../../manager/cubit/chat_cubit.dart';
import '../../manager/cubit/chat_state.dart';

class ChatUserCubit extends StatelessWidget {
  const ChatUserCubit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ChatGetMessagesError) {
            return CustomErrorWidget(error: state.error);
          } else if (state is ChatGetMessagesSuccess) {
            return MessageCard();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
