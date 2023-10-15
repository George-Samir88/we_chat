
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:we_chat/core/widgets/custom_alert_message.dart';
import 'package:we_chat/features/chat/manager/cubits/send_message_cubit/send_message_cubit.dart';
import 'package:we_chat/features/chat/manager/cubits/send_message_cubit/send_message_state.dart';
import 'package:we_chat/features/chat/manager/models/message_model.dart';

import '../../../../core/global_var.dart';
import '../../manager/cubits/get_messages_cubit/get_messages_cubit.dart';
import 'package:just_audio/just_audio.dart';

import 'controls_audio.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendMessageCubit, SendMessageState>(
      listener: (context, state) {
        if (state is SendMessageError)
          customAlertMessage(
              message: 'An error occurred ' + state.error,
              backgroundColor: Colors.red);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: screenSize.width * 0.02,
              ),
              if (message.read.isNotEmpty)
                Icon(
                  Icons.done_all_rounded,
                  size: 24,
                  color: Colors.blue,
                ),
              if (message.read.isNotEmpty)
                SizedBox(
                  width: 4,
                ),
              Text(
                DateFormat.jm().format(DateTime.parse(message.sent)),
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),
            ],
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(
                top: screenSize.height * 0.015,
                left: screenSize.height * 0.02,
                right: screenSize.height * 0.02,
              ),
              padding: message.type == Type.text
                  ? EdgeInsets.all(screenSize.height * 0.02)
                  : EdgeInsets.all(screenSize.height * 0.01),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.lightGreen),
                color: Color.fromARGB(255, 218, 255, 176),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: message.type == Type.text
                  ? Text(
                      message.msg,
                    )
                  : (message.type == Type.image
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            height: screenSize.height * 0.3,
                            width: screenSize.height * 0.3,
                            imageUrl: message.msg,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(CupertinoIcons.photo_fill),
                          ),
                        )
                      : Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: screenSize.height * 0.03,
                              child: Icon(
                                Icons.keyboard_voice,
                                size: screenSize.height * 0.04,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenSize.width * 0.08),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: screenSize.height * 0.03,
                                child: Controls(
                                    audioPlayer: AudioPlayer()
                                      ..setUrl(message.msg)),
                              ),
                            ),
                          ],
                        )),
            ),
          ),
        ],
      ),
    );
  }
}

class ReceiverMessageCard extends StatelessWidget {
  const ReceiverMessageCard({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    if (message.read.isEmpty) {
      markMessageAsRead(messageModel: message);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              top: screenSize.height * 0.015,
              left: screenSize.height * 0.02,
              right: screenSize.height * 0.02,
            ),
            padding: message.type == Type.text
                ? EdgeInsets.all(screenSize.height * 0.02)
                : EdgeInsets.all(screenSize.height * 0.01),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlue),
              color: Color.fromARGB(255, 221, 245, 255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: message.type == Type.text
                ? Text(
                    message.msg,
                  )
                : message.type == Type.image
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          height: screenSize.height * 0.3,
                          width: screenSize.height * 0.3,
                          imageUrl: message.msg,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                strokeWidth: 2,
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(CupertinoIcons.photo_fill),
                        ),
                      )
                    : Container(
                        child: Text(
                          'Record',
                        ),
                      ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: screenSize.width * 0.02,
          ),
          child: Text(
            DateFormat.jm().format(DateTime.parse(message.sent)),
            style: TextStyle(color: Colors.black54, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
