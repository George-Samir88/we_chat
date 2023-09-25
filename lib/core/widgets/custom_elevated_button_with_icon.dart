import 'package:flutter/material.dart';

import '../global_var.dart';

class CustomElevatedButtonWithIcon extends StatelessWidget {
  const CustomElevatedButtonWithIcon({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.firstText,
    this.secondText = '',
    this.textColor = Colors.black,
    this.onPressed,
  });

  final Color backgroundColor;
  final IconData icon;
  final String firstText;
  final String? secondText;
  final Color? textColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(screenSize.width, screenSize.height * 0.05),
        elevation: 1,
        shape: StadiumBorder(),
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: screenSize.height * 0.03,
      ),
      label: RichText(
        text: TextSpan(
            style: TextStyle(fontSize: 20.0, color: textColor),
            children: [
              TextSpan(
                text: firstText,
              ),
              TextSpan(
                text: secondText,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]),
      ),
    );
  }
}
