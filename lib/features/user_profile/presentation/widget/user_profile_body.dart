import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_chat/core/function/update_user.dart';
import 'package:we_chat/core/widgets/custom_alert_message.dart';
import 'package:we_chat/core/widgets/custom_elevated_button_with_icon.dart';

import '../../../../core/global_var.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import 'custom_bottom_sheet.dart';

class UserProfileBody extends StatefulWidget {
  const UserProfileBody({super.key});

  static var formKey = GlobalKey<FormState>();

  @override
  State<UserProfileBody> createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  String? imagePicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
      child: SingleChildScrollView(
        child: Form(
          key: UserProfileBody.formKey,
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.01,
                width: screenSize.width,
              ),
              Stack(
                children: [
                  imagePicked == null
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
                            File(imagePicked!),
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
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.camera);
                            if (image != null) {
                              setState(() {
                                imagePicked = image.path;
                              });
                              Navigator.pop(context);
                            }
                          },
                          onGalleryButtonPressed: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              setState(() {
                                imagePicked = image.path;
                              });
                              Navigator.pop(context);
                            }
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
              CustomTextFormField(
                onSaved: (value) {
                  me.name = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Required field';
                  }
                  return null;
                },
                labelText: 'Name',
                hintText: "ex: George Samir",
                maxLines: 1,
                prefixIcon: CupertinoIcons.person,
                initialValue: me.name,
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              CustomTextFormField(
                onSaved: (value) {
                  me.about = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Required field';
                  }
                  return null;
                },
                labelText: 'About',
                hintText: "ex: i'm happy now",
                maxLines: 1,
                prefixIcon: CupertinoIcons.info_circle,
                initialValue: me.about,
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              CustomElevatedButtonWithIcon(
                  backgroundColor: Colors.blue,
                  icon: Icons.add_comment_rounded,
                  onPressed: () {
                    if (UserProfileBody.formKey.currentState!.validate()) {
                      UserProfileBody.formKey.currentState!.save();
                      updateUserprofile().then((value) {
                        customAlertMessage(
                            message: 'Updated Successfully',
                            backgroundColor: Colors.green);
                      });
                    }
                  },
                  textColor: Colors.white,
                  firstText: 'Edit'),
            ],
          ),
        ),
      ),
    );
  }
}
