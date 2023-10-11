import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_chat/core/widgets/custom_alert_message.dart';
import 'package:we_chat/features/chat/manager/cubits/send_message_cubit/send_message_cubit.dart';
import 'package:we_chat/features/chat/manager/cubits/send_message_cubit/send_message_state.dart';

import '../../../../core/function/emoji_picker.dart';
import '../../../../core/global_var.dart';
import '../../manager/models/message_model.dart';
import 'chat_view_body.dart';

class SendMessageSection extends StatefulWidget {
  SendMessageSection({
    super.key,
    required this.widget,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ChatViewBody widget;
  final ScrollController _scrollController;

  @override
  State<SendMessageSection> createState() => _SendMessageSectionState();
}

class _SendMessageSectionState extends State<SendMessageSection> {
  final textEditingController = TextEditingController();
  bool isPickingEmoji = false;

  @override
  Widget build(BuildContext context) {
    var blocHelper = BlocProvider.of<SendMessageCubit>(context);
    return WillPopScope(
      onWillPop: () {
        if (isPickingEmoji) {
          setState(() {
            isPickingEmoji = !isPickingEmoji;
          });
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenSize.height * 0.01,
          horizontal: screenSize.width * 0.02,
        ),
        child: BlocConsumer<SendMessageCubit, SendMessageState>(
          listener: (context, state) {
            if (state is PickImageError) {
              customAlertMessage(
                  message: 'An error occurred ' + state.error,
                  backgroundColor: Colors.red);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        shape: StadiumBorder(),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  FocusScope.of(context).unfocus();
                                  isPickingEmoji = !isPickingEmoji;
                                });
                              },
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
                                onTap: () {
                                  if (isPickingEmoji) {
                                    setState(() {
                                      isPickingEmoji = !isPickingEmoji;
                                    });
                                  }
                                },
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
                              onPressed: ()async {
                                await blocHelper.pickImage(imageSource: ImageSource.camera).then((value) {
                                  if(value!=null){
                                    blocHelper.sendImageMessage(chatUser: widget.widget.chatUser, file: File(value));
                                  }
                                });
                              },
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
                                    chatUser: widget.widget.chatUser,
                                    message: textEditingController.text,
                                    type: Type.text)
                                .then((value) {
                              textEditingController.clear();
                            });
                            widget._scrollController.animateTo(0,
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
                if (isPickingEmoji)
                  SizedBox(
                    height: screenSize.height * 0.35,
                    child:
                        pickEmoji(textEditingController: textEditingController),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
