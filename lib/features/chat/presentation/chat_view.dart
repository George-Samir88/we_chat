import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/features/chat/presentation/widgets/chat_view_body.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

import '../../../core/global_var.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.chatUser});

  final ChatUser chatUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: CustomFlexibleAppBar(
            chatUser: chatUser,
          ),
        ),
        body: ChatViewBody(),
      ),
    );
  }
}

class CustomFlexibleAppBar extends StatelessWidget {
  const CustomFlexibleAppBar({super.key, required this.chatUser});

  final ChatUser chatUser;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.back,
                size: screenSize.width * 0.08,
                color: Colors.black,
              )),
          CachedNetworkImage(
            imageUrl: chatUser.image,
            imageBuilder: (context, imageProvider) {
              return Container(
                width: screenSize.width * 0.1,
                height: screenSize.width * 0.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(CupertinoIcons.person),
          ),
          SizedBox(
            width: screenSize.width * 0.04,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chatUser.name,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    letterSpacing: 0.5),
              ),
              Text(
                'last seen: today at 05:49',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
