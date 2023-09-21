import 'package:flutter/material.dart';
import 'package:we_chat/features/splash/presentation/widgets/splash_view_body.dart';

import '../../../core/global_var.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SplashViewBody(),
    );
  }
}
