import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_chat/core/widgets/custom_alert_message.dart';
import 'package:we_chat/features/user_profile/manager/user_profile_cubit.dart';
import 'package:we_chat/features/user_profile/manager/user_profile_state.dart';

import '../../../../core/global_var.dart';
import 'custom_bottom_sheet.dart';

class PhotoEmailSectionUserProfile extends StatelessWidget {
  const PhotoEmailSectionUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var blocHelper = BlocProvider.of<UserProfileCubit>(context);
    return Column(
      children: [
        BlocConsumer<UserProfileCubit, UserProfileState>(
          listener: (context, state) {
            if (state is UserProfilePickPhotoError) {
              customAlertMessage(
                  message: state.error, backgroundColor: Colors.red);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                blocHelper.imagePicked == null
                    ? ClipRRect(
                        borderRadius:
                            BorderRadius.circular(screenSize.height * 0.15),
                        child: CachedNetworkImage(
                          height: screenSize.height * 0.3,
                          width: screenSize.height * 0.3,
                          imageUrl: me.image,
                          fit: BoxFit.fill,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(CupertinoIcons.person),
                        ),
                      )
                    : ClipRRect(
                        borderRadius:
                            BorderRadius.circular(screenSize.height * 0.15),
                        child: Image.file(
                          File(blocHelper.imagePicked!),
                          height: screenSize.height * 0.3,
                          width: screenSize.height * 0.3,
                          fit: BoxFit.cover,
                        ),
                      ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: MaterialButton(
                    onPressed: () {
                      showBottomSheetFun(
                        onCameraButtonPressed: () async {
                          await blocHelper.pickProfilePicture(
                              imageSource: ImageSource.camera);
                          Navigator.pop(context);
                        },
                        onGalleryButtonPressed: () async {
                          await blocHelper.pickProfilePicture(
                              imageSource: ImageSource.gallery);
                          Navigator.pop(context);
                        },
                        context: context,
                      );
                    },
                    color: Colors.white,
                    shape: CircleBorder(),
                    height: screenSize.height * 0.05,
                    elevation: 1,
                    child: Icon(
                      Icons.edit,
                      color: Colors.blue,
                      size: screenSize.height * 0.035,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(
          height: screenSize.height * 0.03,
        ),
        Text(
          me.email,
          style: TextStyle(
              color: Colors.grey.shade700, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: screenSize.height * 0.02,
        ),
      ],
    );
  }
}
