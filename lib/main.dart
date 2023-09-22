import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/features/auth/login/manager/auth_repo/auth_repo_imp.dart';
import 'package:we_chat/features/auth/login/manager/cubit/auth_cubit.dart';
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
    _initializeFirebase();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: AuthRepoImp()),
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

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
