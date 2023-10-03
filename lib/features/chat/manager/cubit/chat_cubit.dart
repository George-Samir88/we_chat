import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/core/global_var.dart';

import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  Future<void> getAllMessages() async {
    await firestore.collection('messages').snapshots().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {}
    });
  }
}
