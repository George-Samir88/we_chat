import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_chat/features/home/presentation/home_view.dart';
import '../../../../core/function/get_data_from_shared_pref.dart';
import '../../../../core/global_var.dart';
import '../../../auth/login/presentation/login_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    String? token = await getTokenFromCacheMemory(key: 'token');

    await Future.delayed(Duration(milliseconds: 1500));

    // Exit full-screen mode
    exitFullScreenMode();

    if (token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
    }
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

  void exitFullScreenMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
    ));
  }
}
