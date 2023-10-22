import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:we_chat/core/widgets/custom_alert_message.dart';
import 'package:we_chat/features/chat/manager/cubits/get_messages_cubit/get_messages_cubit.dart';
import 'package:we_chat/features/chat/manager/models/message_model.dart';

import '../../../../core/global_var.dart';
import 'option_item.dart';

void customShowModalBottomSheet({
  required context,
  required bool isMe,
  required MessageModel messageModel,
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
          messageModel.type == Type.text
              ? OptionItem(
                  icon: Icons.copy_outlined,
                  text: '   Copy Text',
                  iconColor: Colors.blue,
                  onTap: () async {
                    await Clipboard.setData(
                            ClipboardData(text: messageModel.msg))
                        .then((value) {
                      Navigator.pop(context);
                      customAlertMessage(
                          message: 'Message copied!',
                          backgroundColor: Colors.green);
                    });
                  },
                )
              : (messageModel.type == Type.image
                  ? OptionItem(
                      icon: Icons.download,
                      text: '   Save Image',
                      iconColor: Colors.blue,
                      onTap: () {
                        try {
                          GallerySaver.saveImage(messageModel.msg,
                                  albumName: 'We Chat')
                              .then((success) {
                            if (success != null && success) {
                              Navigator.pop(context);
                              customAlertMessage(
                                  message: 'Image Saved!',
                                  backgroundColor: Colors.green);
                            }
                          });
                        } catch (err) {
                          Navigator.pop(context);
                          customAlertMessage(
                              message: 'An error occurred',
                              backgroundColor: Colors.red);
                        }
                      },
                    )
                  : OptionItem(
                      icon: Icons.download,
                      text: '   Save Audio',
                      iconColor: Colors.blue,
                      onTap: () async {
                        await downloadAndSaveAudio(
                                url: messageModel.msg,
                                fileName: messageModel.sent)
                            .then((value) => Navigator.pop(context));
                      },
                    )),
          if (isMe == true)
            Divider(
              endIndent: screenSize.width * 0.1,
              indent: screenSize.width * 0.1,
              thickness: 1,
            ),
          if (messageModel.type == Type.text && isMe == true)
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
              onTap: () {
                deleteMessage(messageModel: messageModel).then((value) {
                  Navigator.pop(context);
                  customAlertMessage(
                      message: 'Message deleted successfully',
                      backgroundColor: Colors.green);
                });
              },
            ),
          Divider(
            endIndent: screenSize.width * 0.1,
            indent: screenSize.width * 0.1,
            thickness: 1,
          ),
          //for showing when message send at
          OptionItem(
            icon: Icons.remove_red_eye_outlined,
            text: '   Sent At: ${formatDate(messageModel.sent)}',
            iconColor: Colors.blue,
            onTap: () {},
          ),
          //for showing when message read at
          OptionItem(
            icon: Icons.remove_red_eye_outlined,
            text:
                '   Read At: ${(messageModel.read.isEmpty ? "Haven't read yet" : formatDate(messageModel.read))}',
            iconColor: Colors.green,
            onTap: () {},
          ),
        ],
      );
    },
  );
}

String formatDate(String time) {
  DateTime now = DateTime.now();
  if (now.day == DateTime.parse(time).day &&
      now.month == DateTime.parse(time).month &&
      now.year == DateTime.parse(time).year) {
    return DateFormat.jm().format(DateTime.parse(time));
  }
  DateFormat dateFormat = DateFormat("d MMM", 'en_US');

  return dateFormat.format(DateTime.parse(time)) +
      ', ' +
      DateFormat.jm().format(DateTime.parse(time));
}

Future<void> deleteMessage({required MessageModel messageModel}) async {
  await firestore
      .collection('chats/${getConversationId(messageModel.toId)}/messages')
      .doc(messageModel.sent)
      .delete();
  if (messageModel.type == Type.image || messageModel.type == Type.voice) {
    firebaseStorage.refFromURL(messageModel.msg).delete();
  }
}

Dio dio = Dio();

Future<void> downloadAndSaveAudio(
    {required String url, required String fileName}) async {
  // Check and request the WRITE_EXTERNAL_STORAGE permission
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }

  try {
    // Get the external storage directory
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory!.path}/$fileName';

    // Download the audio file using Dio
    await dio.download(url, filePath);

    // Check if the file was successfully downloaded
    File audioFile = File(filePath);
    if (audioFile.existsSync()) {
      // File downloaded successfully
      print('Audio file saved to: $filePath');
      customAlertMessage(message: 'saved', backgroundColor: Colors.green);
    } else {
      // Handle download failure
      print('Failed to download audio.');
      customAlertMessage(
          message: 'Download failed', backgroundColor: Colors.red);
    }
  } catch (e) {
    // Handle any exceptions that may occur during the download
    print('Error while downloading audio: $e');
    customAlertMessage(message: 'Error: $e', backgroundColor: Colors.red);
  }
}
