import 'package:we_chat/core/global_var.dart';

Future<bool> userExistenceChecker() async {
  return (await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get())
      .exists;
}
