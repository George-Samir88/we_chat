import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

import '../../../../../core/global_var.dart';
import '../../models/message_model.dart';
import '../chat_cubit/chat_cubit.dart';
import 'get_last_message_state.dart';

class GetLastMessageCubit extends Cubit<GetLastMessageState> {
  GetLastMessageCubit() : super(GetLastMessageInitial());

  Future<void> getLastMessage({required ChatUser chatUser}) async {
    emit(ChatGetLastMessageLoading());
    try {
      await firestore
          .collection('chats/${getConversationId(chatUser.id)}/messages/')
          .orderBy('sent', descending: true)
          .limit(1)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.docs.isEmpty) {
          emit(ChatGetLastMessageSuccess(messages: []));
        } else {
          List<MessageModel> messageModel;
          messageModel = snapshot.docs.map((e) {
            return MessageModel.fromJson(e.data());
          }).toList();
          emit(ChatGetLastMessageSuccess(messages: messageModel));
        }
      });
    } catch (err) {
      emit(ChatGetLastMessageError(error: err.toString()));
    }
  }
}
