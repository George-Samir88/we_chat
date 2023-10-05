import '../../features/home/manager/models/user_model.dart';
import '../global_var.dart';
import 'add_user_to_firestore.dart';

Future<void> getSelfInfo({required String uid}) async {
  await firestore.collection('users').doc(uid).get().then((value) {
    if (value.exists) {
      me = ChatUser.fromJson(value.data()!);
    } else {
      addUserToFireStore().then((value) {
        getSelfInfo(uid: firebaseAuth.currentUser!.uid);
      });
    }
  });
}
