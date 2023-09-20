import 'package:flutter/material.dart';
import 'package:we_chat/core/global_var.dart';

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
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 223, 255, 187),
              elevation: 1,
              shape: StadiumBorder(),
            ),
            onPressed: () {},
            icon: Image.asset('assets/images/google.png',
                height: screenSize.height * 0.03,
                ),
            label: RichText(
              text: TextSpan(
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Sign In with ',
                    ),
                    TextSpan(
                      text: 'Google',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}
