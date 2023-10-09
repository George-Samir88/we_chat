import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/features/chat/manager/cubits/send_message_cubit/send_message_state.dart';

import '../../../../../core/global_var.dart';
import '../../../../home/manager/models/user_model.dart';
import '../../models/message_model.dart';
import '../get_messages_cubit/get_messages_cubit.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit() : super(SendMessageInitial());

  Future<void> sendMessage(
      {required ChatUser chatUser, required String message}) async {
    emit(SendMessageLoading());
    try {
      final String dateTime = DateTime.now().toString();
      final MessageModel messageModel = MessageModel(
          msg: message,
          toId: chatUser.id,
          read: '',
          type: Type.text,
          fromId: firebaseAuth.currentUser!.uid,
          sent: dateTime);
      var ref = firestore
          .collection('chats/${getConversationId(chatUser.id)}/messages/');
      await ref.doc(dateTime).set(messageModel.toJson());
      emit(SendMessageSuccess());
    } catch (err) {
      emit(SendMessageError(error: err.toString()));
    }
  }
}
