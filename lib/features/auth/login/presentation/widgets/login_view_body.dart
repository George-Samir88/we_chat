import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/core/function/add_user_to_firestore.dart';
import 'package:we_chat/core/function/check_user_existence.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/core/widgets/custom_alert_message.dart';
import 'package:we_chat/core/widgets/custom_elevated_button_with_image.dart';
import 'package:we_chat/features/auth/login/manager/cubit/auth_cubit.dart';
import 'package:we_chat/features/auth/login/manager/cubit/auth_state.dart';
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
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) async {
            if (state is AuthErrorState) {
              customAlertMessage(
                  message: state.error.toString(), backgroundColor: Colors.red);
            } else if (state is AuthSuccessState) {
              customAlertMessage(
                  message: 'Signed In Successfully',
                  backgroundColor: Colors.green);
              if (await userExistenceChecker()) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeView()));
              } else {
                await addUserToFireStore().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeView()));
                });
              }
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return Positioned(
                bottom: screenSize.height * 0.15,
                left: screenSize.width * 0.08,
                right: screenSize.width * 0.08,
                height: screenSize.height * 0.06,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Positioned(
                bottom: screenSize.height * 0.15,
                left: screenSize.width * 0.08,
                right: screenSize.width * 0.08,
                height: screenSize.height * 0.06,
                child: CustomElevatedButtonWithImage(
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).signInWithGoogle();
                  },
                  backgroundColor: Color.fromARGB(255, 223, 255, 187),
                  image: 'assets/images/google.png',
                  firstText: 'Sign In with ',
                  secondText: 'Google',
                  textColor: Colors.black,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
