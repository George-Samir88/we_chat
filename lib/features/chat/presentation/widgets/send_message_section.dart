import 'package:flutter/material.dart';

import '../../../../core/global_var.dart';

class SendMessageSection extends StatelessWidget {
  const SendMessageSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenSize.height * 0.01,
        horizontal: screenSize.width * 0.02,
      ),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: StadiumBorder(),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.emoji_emotions_outlined,
                    ),
                    color: Colors.blueAccent,
                    splashRadius: 20,
                    padding: EdgeInsets.only(
                      right: screenSize.width * 0.04,
                      left: screenSize.width * 0.04,
                    ),
                    iconSize: screenSize.width * 0.07,
                    tooltip: 'Send emoji',
                  ),
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Message',
                        hintStyle: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.image,
                    ),
                    color: Colors.blueAccent,
                    splashRadius:  screenSize.width * 0.06,
                    iconSize: screenSize.width * 0.07,
                    tooltip: 'Attach image',
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera_alt,
                    ),
                    color: Colors.blueAccent,
                    splashRadius: screenSize.width * 0.06,
                    iconSize: screenSize.width * 0.07,
                    tooltip: 'open camera',
                  ),
                ],
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.green,
            child: IconButton(
              onPressed: () {},
              splashRadius: screenSize.width * 0.06,
              icon: Icon(Icons.send),
              iconSize: screenSize.width * 0.07,
              color: Colors.white,
              splashColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
