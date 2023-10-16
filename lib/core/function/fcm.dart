import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:we_chat/core/global_var.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<void> getFirebaseMessagingToken() async {
  await messaging.requestPermission();
  messaging.getToken().then((value) {
    if (value != null) {
      me!.pushToken = value;
      print(me!.pushToken);
    }
  });

  print('User granted permission: }');
}
