import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_chat/features/home/presentation/home_view.dart';

import '../../../../core/global_var.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    Future.delayed(
      Duration(milliseconds: 1500),
      () {
        //exit full screen mode
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.edgeToEdge,
        );
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: screenSize.height * 0.2,
          right: screenSize.width * 0.25,
          width: screenSize.width * 0.5,
          child: Image.asset('assets/images/message.png'),
        ),
        Positioned(
          width: screenSize.width,
          bottom: screenSize.height * 0.20,
          child: Text(
            'Go Chatting ❤️',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ],
    );
  }
}
