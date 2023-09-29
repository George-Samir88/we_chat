
import '../../features/home/manager/models/user_model.dart';
import '../global_var.dart';
import 'add_user_to_firestore.dart';

Future<void> getSelfInfo() async {
  await firestore
      .collection('users')
      .doc(firebaseAuth.currentUser!.uid)
      .get()
      .then((value) {
    if (value.exists) {
      me = ChatUser.fromJson(value.data()!);
    } else {
      addUserToFireStore().then((value) {
        getSelfInfo();
      });
    }
  });
}
