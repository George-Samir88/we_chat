import 'package:flutter/material.dart';
import 'package:we_chat/core/global_var.dart';

class OptionItem extends StatelessWidget {
  const OptionItem({
    super.key,
    required this.icon,
    required this.text,
    required this.iconColor,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final Color iconColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          left: screenSize.width * 0.05,
          top: screenSize.height * 0.015,
          bottom: screenSize.height * 0.02,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black54,
                  letterSpacing: 0.5,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
