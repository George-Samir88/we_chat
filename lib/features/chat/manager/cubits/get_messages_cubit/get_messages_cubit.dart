import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/features/chat/manager/models/message_model.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';
import 'get_messages_state.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  GetMessagesCubit() : super(ChatGetMessagesInitial());

  @override
  void emit(GetMessagesState state) {
    if (!isClosed) super.emit(state);
  }

  void getAllMessages({required ChatUser chatUser}) {
    emit(ChatGetMessagesLoading());
    try {
      firestore
          .collection('chats/${getConversationId(chatUser.id)}/messages/')
          .orderBy('sent', descending: true)
          .snapshots()
          .listen((snapshot) {
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

// Future<void> sendMessage(
//     {required ChatUser chatUser, required String message}) async {
//   final String dateTime = DateTime.now().toString();
//   final MessageModel messageModel = MessageModel(
//       msg: message,
//       toId: chatUser.id,
//       read: '',
//       type: Type.text,
//       fromId: firebaseAuth.currentUser!.uid,
//       sent: dateTime);
//   var ref = firestore
//       .collection('chats/${getConversationId(chatUser.id)}/messages/');
//   await ref.doc(dateTime).set(messageModel.toJson());
// }
}

//we will follow this pattern
//chats (collection) ==> conversation_id (doc) ==> messages (collection) ==> message (doc)
String getConversationId(String id) =>
    firebaseAuth.currentUser!.uid.hashCode <= id.hashCode
        ? '${firebaseAuth.currentUser!.uid}_$id'
        : '${id}_${firebaseAuth.currentUser!.uid}';

Future<void> markMessageAsRead({required MessageModel messageModel}) async {
  var time = DateTime.now().toString();
  print('---------------------' + messageModel.fromId + messageModel.sent);
  var ref = firestore
      .collection('chats/${getConversationId(messageModel.fromId)}/messages/');
  await ref.doc(messageModel.sent).update({
    'read': time,
  });
}
