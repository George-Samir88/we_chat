import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

import 'last_activate_state.dart';

class LastActivateCubit extends Cubit<LastActivateState> {
  LastActivateCubit() : super(LastActivateInitial());

  @override
  void emit(LastActivateState state) {
    if (!isClosed) super.emit(state);
  }

  ChatUser? userActivate;

  Future<void> getUserInfo({required ChatUser chatUser}) async {
    emit(LastActivateLoading());
    try {
      await firestore
          .collection('users')
          .doc(chatUser.id)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.data()!.isNotEmpty) {
          ChatUser user = ChatUser.fromJson(snapshot.data()!);
          userActivate = user;
          emit(LastActivateSuccess());
        }
      });
    } catch (err) {
      emit(LastActivateError(failure: err.toString()));
    }
  }

  Future<void> updateMyActivateStatus({required bool isOnline}) async {
    firestore.collection('users').doc(firebaseAuth.currentUser!.uid).update({
      'last_active': DateTime.now().toString(),
      'is_online': isOnline,
      'push_token': me!.pushToken,
    });
  }
}
