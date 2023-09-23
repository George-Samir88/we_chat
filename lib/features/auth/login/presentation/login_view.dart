import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/features/auth/login/manager/auth_repo/auth_repo_imp.dart';
import 'package:we_chat/features/auth/login/manager/cubit/auth_cubit.dart';
import 'package:we_chat/features/auth/login/presentation/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: AuthRepoImp()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Welcome to We Chat',
          ),
        ),
        body: LoginViewBody(),
      ),
    );
  }
}
