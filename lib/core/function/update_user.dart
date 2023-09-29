
import '../global_var.dart';

Future<void> updateUserprofile() async {
  await firestore
      .collection('users')
      .doc(firebaseAuth.currentUser!.uid)
      .update({
    'name': me.name,
    'image': me.image,
    'about': me.about,
  });
}
