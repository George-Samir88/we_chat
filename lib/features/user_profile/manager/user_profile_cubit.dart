import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_chat/features/user_profile/manager/user_profile_state.dart';

import '../../../core/function/update_user_profile_image.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());
  String? imagePicked;

  Future<void> pickProfilePictureAndUpdateInFirestore(
      {required ImageSource imageSource}) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image =
          await picker.pickImage(source: imageSource, imageQuality: 80);
      if (image != null) {
        imagePicked = image.path;
        emit(UserProfileUpdatePhotoLoading());
        await updateUserProfileImage(File(imagePicked!)).then((value) {
          emit(UserProfileUpdatePhotoSuccess());
        }).catchError((err) {
          emit(UserProfileUpdatePhotoError(error: err.toString()));
        });
        emit(UserProfilePickPhotoSuccess());
      }
    } catch (error) {
      emit(UserProfilePickPhotoError(error: error.toString()));
    }
  }
}
