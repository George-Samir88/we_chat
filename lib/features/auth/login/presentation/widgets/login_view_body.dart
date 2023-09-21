import 'package:flutter/material.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/core/widgets/custom_elevated_button.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: screenSize.height * 0.1,
          left: screenSize.width * 0.25,
          width: screenSize.width * 0.5,
          child: Image.asset('assets/images/message.png'),
        ),
        Positioned(
          bottom: screenSize.height * 0.15,
          left: screenSize.width * 0.08,
          right: screenSize.width * 0.08,
          height: screenSize.height * 0.06,
          child: CustomElevatedButton(
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
