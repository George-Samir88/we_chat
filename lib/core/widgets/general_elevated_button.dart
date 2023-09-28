import 'package:flutter/material.dart';
import 'package:we_chat/core/global_var.dart';

class GeneralElevatedButton extends StatelessWidget {
  const GeneralElevatedButton({
    super.key,
    required this.imagePath,
    this.onPressed,
  });

  final String imagePath;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 1,
          fixedSize: Size(screenSize.width * 0.35, screenSize.height * 0.15),
          shape: CircleBorder(),
          backgroundColor: Colors.white),
      onPressed: onPressed,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
