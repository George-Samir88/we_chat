import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_chat/core/utils/dio_helper.dart';
import 'package:we_chat/features/chat/manager/cubits/send_message_cubit/send_message_state.dart';

import '../../../../../core/global_var.dart';
import '../../../../home/manager/models/user_model.dart';
import '../../models/message_model.dart';
import '../get_messages_cubit/get_messages_cubit.dart';
import 'package:record/record.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit() : super(SendMessageInitial());
  Record record = Record();

  // AudioPlayer audioPlayer = AudioPlayer();
  bool isRecording = false;
  String? audioPath;
  DioHelper dioHelper = DioHelper(Dio());

  Future<void> sendMessage(
      {required ChatUser chatUser,
      required String message,
      required Type type}) async {
    emit(SendMessageLoading());
    try {
      final String dateTime = DateTime.now().toString();
      final MessageModel messageModel = MessageModel(
          msg: message,
          toId: chatUser.id,
          read: '',
          type: type,
          fromId: firebaseAuth.currentUser!.uid,
          sent: dateTime);
      var ref = firestore
          .collection('chats/${getConversationId(chatUser.id)}/messages/');
      await ref.doc(dateTime).set(messageModel.toJson());
      //for sending notification
      dioHelper.post(data: {
        "to": chatUser.pushToken,
        "notification": {
          "title": chatUser.name,
          "body": type == Type.text
              ? message
              : (type == Type.image ? 'Photo' : 'Voice')
        }
      });
      emit(SendMessageSuccess());
    } catch (err) {
      emit(SendMessageError(error: err.toString()));
    }
  }

  Future<void> sendImageMessage(
      {required ChatUser chatUser, required File file}) async {
    var extension = file.path.split('.').last;
    var ref = firebaseStorage.ref().child(
        'chat_image/${getConversationId(chatUser.id)}/${DateTime.now()}.${extension}');
    await ref
        .putFile(
      file,
      SettableMetadata(contentType: 'image/$extension'),
    )
        .then((p0) {
      print(p0.bytesTransferred / 1000);
    });
    String imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser: chatUser, message: imageUrl, type: Type.image);
  }

  Future<String?> pickImage({required ImageSource imageSource}) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image =
          await picker.pickImage(source: imageSource, imageQuality: 80);
      emit(PickImageSuccess());
      return image!.path;
    } catch (err) {
      emit(PickImageError(error: err.toString()));
      return null;
    }
  }

  Future<List<XFile?>?> pickMultipleImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile>? image = await picker.pickMultiImage(imageQuality: 80);
      emit(PickImageSuccess());
      return image;
    } catch (err) {
      emit(PickImageError(error: err.toString()));
      return null;
    }
  }

  Future<void> sendVoiceMessage(
      {required ChatUser chatUser, required File file}) async {
    var extension = file.path.split('.').last;
    var ref = firebaseStorage.ref().child(
        'chat_voice/${getConversationId(chatUser.id)}/${DateTime.now()}.${extension}');
    await ref
        .putFile(
      file,
      SettableMetadata(contentType: 'voice/$extension'),
    )
        .then((p0) {
      print(p0.bytesTransferred / 1000);
    });
    String voiceUrl = await ref.getDownloadURL();
    await sendMessage(chatUser: chatUser, message: voiceUrl, type: Type.voice);
  }

  Future<void> startRecording() async {
    try {
      if (await record.hasPermission()) {
        await record.start();
        isRecording = true;
        emit(IsRecordingAudio());
      }
    } catch (err) {
      print('here error' + err.toString());
      emit(StartRecordingAudioError(error: err.toString()));
    }
  }

  Future<void> stopRecord() async {
    try {
      String? path = await record.stop();
      isRecording = false;
      audioPath = path!;
      emit(StopRecordingAudio());
    } catch (err) {
      print('here an error occurred' + err.toString());
      emit(StopRecordingAudioError(error: err.toString()));
    }
  }

// Future<void> playRecord({required String? path}) async {
//   try {
//     Source urlSource = UrlSource(path!);
//     await audioPlayer.play(urlSource);
//     emit(AudioPlayerStart());
//   } catch (err) {
//     print('here an error occurred ' + err.toString());
//     emit(AudioPlayerError(error: err.toString()));
//   }
// }
}
