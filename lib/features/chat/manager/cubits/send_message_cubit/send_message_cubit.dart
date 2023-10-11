import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_chat/features/chat/manager/cubits/send_message_cubit/send_message_state.dart';

import '../../../../../core/global_var.dart';
import '../../../../home/manager/models/user_model.dart';
import '../../models/message_model.dart';
import '../get_messages_cubit/get_messages_cubit.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit() : super(SendMessageInitial());

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
}
