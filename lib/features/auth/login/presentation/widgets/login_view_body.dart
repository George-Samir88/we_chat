import 'package:flutter/material.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/core/widgets/custom_elevated_button.dart';
import 'package:we_chat/features/home/presentation/home_view.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  bool isAnimate = false;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isAnimate = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
          top: screenSize.height * 0.1,
          right: isAnimate ? screenSize.width * 0.25 : -screenSize.width * 0.5,
          width: screenSize.width * 0.5,
          child: Image.asset('assets/images/message.png'),
        ),
        Positioned(
          bottom: screenSize.height * 0.15,
          left: screenSize.width * 0.08,
          right: screenSize.width * 0.08,
          height: screenSize.height * 0.06,
          child: CustomElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeView(),
                ),
              );
            },
            backgroundColor: Color.fromARGB(255, 223, 255, 187),
            image: 'assets/images/google.png',
            firstText: 'Sign In with ',
            secondText: 'Google',
            textColor: Colors.black,
          ),
        ),
      ],
    );
  }
}
