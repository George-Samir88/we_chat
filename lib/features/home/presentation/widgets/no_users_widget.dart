import 'package:flutter/material.dart';

class NoUsersWidget extends StatelessWidget {
  const NoUsersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(24)),
        child: Text(
          'No Users yet',
          style: TextStyle(
            fontSize: 22.0,
          ),
        ),
      ),
    );
  }
}
