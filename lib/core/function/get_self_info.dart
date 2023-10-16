import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/core/function/fcm.dart';

import '../../features/chat/manager/cubits/last_activate_cubit/last_activate_cubit.dart';
import '../../features/home/manager/models/user_model.dart';
import '../global_var.dart';
import 'add_user_to_firestore.dart';

Future<void> getSelfInfo({required String uid, required context}) async {
  await firestore.collection('users').doc(uid).get().then((value) async {
    if (value.exists) {
      me = ChatUser.fromJson(value.data()!);
      await getFirebaseMessagingToken();
      BlocProvider.of<LastActivateCubit>(context)
          .updateMyActivateStatus(isOnline: true);
    } else {
      addUserToFireStore().then((value) {
        getSelfInfo(uid: firebaseAuth.currentUser!.uid, context: context);
      });
    }
  });
}
