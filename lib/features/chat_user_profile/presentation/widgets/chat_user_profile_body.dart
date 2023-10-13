import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/global_var.dart';
import '../../../home/manager/models/user_model.dart';

class ChatUserProfileBody extends StatelessWidget {
  const ChatUserProfileBody({super.key, required this.chatUser});

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
            width: screenSize.height * 0.3,
            imageUrl: chatUser.image,
            fit: BoxFit.fill,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child:
                  CircularProgressIndicator(value: downloadProgress.progress),
            ),
            errorWidget: (context, url, error) => Icon(CupertinoIcons.person),
          ),
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
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'About: ',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
              TextSpan(
                text: chatUser.about,
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
