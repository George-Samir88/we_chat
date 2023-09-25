import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

import '../../../../core/global_var.dart';

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({super.key, required this.chatUser});

  final ChatUser chatUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: screenSize.height * 0.01,
          width: screenSize.width,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(screenSize.height * 0.15),
          child: CachedNetworkImage(
            height: screenSize.height * 0.3,
            imageUrl: chatUser.image,
            fit: BoxFit.fill,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(CupertinoIcons.person),
          ),
        ),
        TextFormField(
          initialValue: chatUser.email,
        ),
      ],
    );
  }
}
