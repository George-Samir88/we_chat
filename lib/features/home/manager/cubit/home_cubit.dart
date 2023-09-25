import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  late ChatUser currentChatUser;

  void getChatUsers() {
    if (!isFetchingChatUsers) {
      isFetchingChatUsers = true;
      emit(HomeGetUserLoadingState());
      try {
        firestore.collection('users').snapshots().listen((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            List<ChatUser> users = [];
            users = snapshot.docs.map((e) {
              return ChatUser.fromJson(e.data());
            }).toList();
            currentChatUser = users[currentUserSelector(
                FirebaseAuth.instance.currentUser!.uid, users)];
            emit(HomeGetUserSuccessState(users: users));
          } else {
            emit(HomeGetUserSuccessState(users: []));
          }
        });
      } catch (err) {
        emit(HomeGetUserErrorState(error: err.toString()));
      }
    }
  }
}

int currentUserSelector(String authUserUid, List<ChatUser> fireStoreUsers) {
  for (int i = 0; i < fireStoreUsers.length; i++) {
    if (authUserUid == fireStoreUsers[i].id) {
      return i;
    }
  }
  return 0;
}
