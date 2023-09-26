import 'package:firebase_auth/firebase_auth.dart';

import '../global_var.dart';

Future<void> updateUserprofile() async {
  await firestore
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
    'name': me.name,
    'image': me.image,
    'about': me.about,
  });
}
