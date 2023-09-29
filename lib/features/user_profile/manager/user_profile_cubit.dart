import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_chat/features/user_profile/manager/user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());
  String? imagePicked;

  Future<void> pickProfilePicture({required ImageSource imageSource}) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: imageSource);
      if (image != null) {
        imagePicked = image.path;
        emit(UserProfilePickPhotoSuccess());
      }
    } catch (error) {
      emit(UserProfilePickPhotoError(error: error.toString()));
    }
  }
}
