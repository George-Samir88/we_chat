import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  List<ChatUser> chatUserSearchList = [];
  List<ChatUser> allChatUsers = [];

  void getChatUsers() {
    emit(HomeGetUserLoadingState());
    try {
      firestore
          .collection('users')
          .where('id', isNotEqualTo:firebaseAuth.currentUser!.uid)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          List<ChatUser> users = [];
          users = snapshot.docs.map((e) {
            return ChatUser.fromJson(e.data());
          }).toList();
          allChatUsers = users;
          emit(HomeGetUserSuccessState(users: users));
        } else {
          emit(HomeGetUserSuccessState(users: []));
        }
      });
    } catch (err) {
      emit(HomeGetUserErrorState(error: err.toString()));
    }
  }

  void searchAboutUser({required String searchItem}) {
    emit(HomeSearchLoadingState());
    chatUserSearchList.clear();
    try {
      for (var i in allChatUsers) {
        if (i.name.toLowerCase().contains(searchItem.toLowerCase()) ||
            i.email.toLowerCase().contains(searchItem.toLowerCase())) {
          chatUserSearchList.add(i);
        }
        emit(HomeSearchSuccessState(chatUserSearchList: chatUserSearchList));
      }
    } catch (err) {
      emit(HomeSearchErrorState(error: err.toString()));
    }
  }
}

// int currentUserSelector(String authUserUid, List<ChatUser> fireStoreUsers) {
//   for (int i = 0; i < fireStoreUsers.length; i++) {
//     if (authUserUid == fireStoreUsers[i].id) {
//       return i;
//     }
//   }
//   return 0;
// }

//this function for get all users bases on condition where id != my id
// void getAllUsersExceptMe() {
//   firestore
//       .collection('users')
//       .where('id', isNotEqualTo: firebaseAuth.currentUser!.uid)
//       .snapshots()
//       .listen((snapshot) {
//     if (snapshot.docs.isNotEmpty) {
//       List<ChatUser> users = [];
//       users = snapshot.docs.map((e) {
//         return ChatUser.fromJson(e.data());
//       }).toList();
//     }
//   });
// }
