import 'package:flutter/material.dart';
import 'package:we_chat/features/chat/manager/models/message_model.dart';

import '../../../../core/global_var.dart';
import 'option_item.dart';

void customShowModalBottomSheet({
  required context,
  required bool isMe,
  required Type type,
}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.black,
        width: 0.5,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return ListView(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.01,
          bottom: screenSize.height * 0.03,
        ),
        shrinkWrap: true,
        children: [
          Divider(
            color: Colors.black54,
            endIndent: screenSize.width * 0.4,
            indent: screenSize.width * 0.4,
            thickness: 2.5,
          ),
          //for copy text or save image
          type == Type.text
              ? OptionItem(
                  icon: Icons.copy_outlined,
                  text: '   Copy Text',
                  iconColor: Colors.blue,
                  onTap: () {},
                )
              : (type == Type.image
                  ? OptionItem(
                      icon: Icons.download,
                      text: '   Save Image',
                      iconColor: Colors.blue,
                      onTap: () {},
                    )
                  : OptionItem(
                      icon: Icons.download,
                      text: '   Save Audio',
                      iconColor: Colors.blue,
                      onTap: () {},
                    )),
          if (isMe == true)
            Divider(
              endIndent: screenSize.width * 0.1,
              indent: screenSize.width * 0.1,
              thickness: 1,
            ),
          if (type == Type.text && isMe == true)
            //for edit message
            OptionItem(
              icon: Icons.edit,
              text: '   Edit Message',
              iconColor: Colors.blue,
              onTap: () {},
            ),
          if (isMe == true)
            //for delete message
            OptionItem(
              icon: Icons.delete_forever_rounded,
              text: '   Delete Message',
              iconColor: Colors.red,
              onTap: () {},
            ),
          Divider(
            endIndent: screenSize.width * 0.1,
            indent: screenSize.width * 0.1,
            thickness: 1,
          ),
          //for showing when message send at
          OptionItem(
            icon: Icons.remove_red_eye_outlined,
            text: '   Sent At:',
            iconColor: Colors.blue,
            onTap: () {},
          ),
          //for showing when message read at
          OptionItem(
            icon: Icons.remove_red_eye_outlined,
            text: '   Read At:',
            iconColor: Colors.green,
            onTap: () {},
          ),
        ],
      );
    },
  );
}
