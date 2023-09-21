import 'package:flutter/material.dart';

import '../global_var.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.backgroundColor,
    required this.image,
    required this.firstText,
    this.secondText = '',
    this.textColor = Colors.black,
    this.onPressed,
  });

  final Color backgroundColor;
  final String image;
  final String firstText;
  final String? secondText;
  final Color? textColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 1,
        shape: StadiumBorder(),
      ),
      onPressed: onPressed,
      icon: Image.asset(
        image,
        height: screenSize.height * 0.03,
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
