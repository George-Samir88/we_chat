import 'package:flutter/material.dart';

import '../global_var.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({super.key, this.onPressed, required this.icon});

  final void Function()? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: 10,
      padding: EdgeInsets.zero,
      child: Icon(
        icon,
        size: screenSize.height * 0.030,
        color: Color(0xff00AB82),
      ),
      shape: CircleBorder(),
    );
  }
}
