import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/core/global_var.dart';

class ChatUserCard extends StatelessWidget {
  const ChatUserCard({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.symmetric(
        vertical: screenSize.height * 0.004,
        horizontal: screenSize.width * 0.02,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: GestureDetector(
        onTap: () {},
        child: ListTile(
          title: Text(name, style: TextStyle(fontSize: 18)),
          subtitle: Text(
            'Hello im george how are you',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
            ),
            maxLines: 1,
          ),
          leading: CircleAvatar(
            child: Icon(CupertinoIcons.person),
          ),
          trailing: Text(
            '12:00 pm',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
