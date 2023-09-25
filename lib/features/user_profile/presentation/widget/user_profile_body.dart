import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/core/widgets/custom_elevated_button_with_icon.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

import '../../../../core/global_var.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({super.key, required this.chatUser});

  final ChatUser chatUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
      child: Column(
        children: [
          SizedBox(
            height: screenSize.height * 0.01,
            width: screenSize.width,
          ),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(screenSize.height * 0.15),
                child: CachedNetworkImage(
                  height: screenSize.height * 0.3,
                  imageUrl: chatUser.image,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) =>
                      Icon(CupertinoIcons.person),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: MaterialButton(
                  onPressed: () {},
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
            chatUser.email,
            style: TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          CustomTextFormField(
            labelText: 'Name',
            hintText: "ex: George Samir",
            maxLines: 1,
            prefixIcon: CupertinoIcons.person,
            initialValue: chatUser.name,
          ),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          CustomTextFormField(
            labelText: 'About',
            hintText: "ex: i'm happy now",
            maxLines: 1,
            prefixIcon: CupertinoIcons.info_circle,
            initialValue: chatUser.about,
          ),
          SizedBox(
            height: screenSize.height * 0.03,
          ),
          CustomElevatedButtonWithIcon(
              backgroundColor: Colors.blue,
              icon: Icons.logout_outlined,
              onPressed: () {},
              textColor: Colors.white,
              firstText: 'Edit'),
        ],
      ),
    );
  }
}
