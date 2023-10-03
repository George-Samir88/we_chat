import 'package:flutter/material.dart';

import '../../../../core/global_var.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(screenSize.height * 0.02),
      margin: EdgeInsets.all(screenSize.height * 0.02),
      width: screenSize.width,
      decoration: BoxDecoration(
        color: Colors.green.shade200,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Text(
        'Hi George where you',
      ),
    );
  }
}
