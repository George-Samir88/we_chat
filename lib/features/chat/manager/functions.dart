import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/global_var.dart';
import '../../../core/widgets/custom_alert_message.dart';
import 'cubits/get_messages_cubit/get_messages_cubit.dart';
import 'models/message_model.dart';

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
