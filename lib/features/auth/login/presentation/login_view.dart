import 'package:flutter/material.dart';
import 'package:we_chat/features/auth/login/presentation/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Welcome to We Chat',
        ),
      ),
      body: LoginViewBody(),
    );
  }
}
