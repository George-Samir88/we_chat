import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:we_chat/core/custom_bloc_observer.dart';
import 'package:we_chat/core/function/service_locator.dart';
import 'package:we_chat/features/chat/manager/cubits/last_activate_cubit/last_activate_cubit.dart';
import 'package:we_chat/features/home/manager/cubit/home_cubit/home_cubit.dart';
import 'package:we_chat/features/splash/presentation/splash_view.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //enter full screen mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  //set screen portrait only
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    Future.wait([
      _initializeFirebase(),
      _initializeChannelsNotification(),
    ]);
    Bloc.observer = CustomBlocObserver();
    setupSharedPreferencesSingleton();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => LastActivateCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'We Chat',
        theme: ThemeData(
          fontFamily: 'Poppins',
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 1,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            titleTextStyle: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
        home: SplashView(),
      ),
    );
  }
}

Future<void> _initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

//for initialize notification channels for some configuration
Future<void> _initializeChannelsNotification() async {
  var result = await FlutterNotificationChannel.registerNotificationChannel(
    description: 'For showing message notification',
    id: 'chats',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'Chats',
    visibility: NotificationVisibility.VISIBILITY_PUBLIC,
    allowBubbles: true,
    enableVibration: true,
    enableSound: true,
    showBadge: true,
  );
  print(result);
}
