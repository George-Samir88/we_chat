import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_chat/core/global_var.dart';

Future<bool> userExistenceChecker() async {
  return (await firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get())
      .exists;
}
