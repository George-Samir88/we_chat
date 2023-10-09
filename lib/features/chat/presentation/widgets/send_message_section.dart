import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/features/chat/manager/cubits/send_message_cubit/send_message_cubit.dart';

import '../../../../core/global_var.dart';
import 'chat_view_body.dart';

class SendMessageSection extends StatelessWidget {
  SendMessageSection({
    super.key,
    required this.widget,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final textEditingController = TextEditingController();
  final ChatViewBody widget;
  final ScrollController _scrollController;

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
                      minLines: 1,
                      maxLines: 5,
                      controller: textEditingController,
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
                    splashRadius: screenSize.width * 0.06,
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
            radius: screenSize.width * 0.06,
            child: IconButton(
              onPressed: () async {
                if (textEditingController.text.isNotEmpty) {
                  await BlocProvider.of<SendMessageCubit>(context)
                      .sendMessage(
                          chatUser: widget.chatUser,
                          message: textEditingController.text)
                      .then((value) {
                    textEditingController.clear();
                  });
                  _scrollController.animateTo(0,
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.easeIn);
                }
              },
              splashRadius: screenSize.width * 0.06,
              icon: Icon(
                Icons.send,
                size: screenSize.width * 0.07,
              ),
              color: Colors.white,
              splashColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
