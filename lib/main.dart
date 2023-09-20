import 'package:flutter/material.dart';
import 'package:we_chat/features/auth/login/presentation/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'We Chat',
      theme: ThemeData(
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
      home: LoginView(),
    );
  }
}
