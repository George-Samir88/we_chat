import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void getChatUsers() {
    emit(HomeGetUserLoadingState());
    try {
      firestore.collection('users').snapshots().listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          List<ChatUser> users = [];
          users = snapshot.docs.map((e) {
            return ChatUser.fromJson(e.data());
          }).toList();
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
