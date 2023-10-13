import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_chat/core/global_var.dart';

import '../../features/home/manager/models/user_model.dart';

Future<void> addUserToFireStore() async {
  User? currentUser = firebaseAuth.currentUser;
  String dateTime = DateTime.now().toString();
  ChatUser user = ChatUser(
      image: currentUser!.photoURL.toString(),
      name: currentUser.displayName.toString(),
      about: "i'm using we chat",
      createdAt: dateTime,
      isOnline: false,
      id: currentUser.uid,
      lastActive: dateTime,
      pushToken: '',
      email: currentUser.email.toString());
  return await firestore
      .collection('users')
      .doc(currentUser.uid)
      .set(user.toJson());
}
