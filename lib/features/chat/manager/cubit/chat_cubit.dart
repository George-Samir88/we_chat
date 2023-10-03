import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/features/chat/manager/models/message_model.dart';

import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  void getAllMessages() {
    emit(ChatGetMessagesLoading());
    try {
      firestore.collection('messages').snapshots().listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          List<MessageModel> messages = [];
          messages = snapshot.docs.map((e) {
            return MessageModel.fromJson(e.data());
          }).toList();
          emit(ChatGetMessagesSuccess(messages: messages));
        } else {
          emit(ChatGetMessagesSuccess(messages: []));
        }
      });
    } catch (error) {
      emit(ChatGetMessagesError(error: error.toString()));
    }
  }
}
