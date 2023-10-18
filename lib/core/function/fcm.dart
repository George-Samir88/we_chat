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
  //for firebase foreground message
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  print('User granted permission: }');
}
