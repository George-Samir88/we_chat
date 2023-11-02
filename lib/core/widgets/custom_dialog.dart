import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/core/widgets/custom_material_button.dart';
import 'package:we_chat/features/chat/presentation/chat_view.dart';
import 'package:we_chat/features/chat/presentation/widgets/one_to_one_audio_call.dart';
import 'package:we_chat/features/chat/presentation/widgets/one_to_one_video_call.dart';
import 'package:we_chat/features/chat_user_profile/presentation/chat_user_profile.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

import '../global_var.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key, required this.chatUser});

  final ChatUser chatUser;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        height: screenSize.height * 0.35,
        width: screenSize.width * 0.4,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: CachedNetworkImage(
                imageUrl: chatUser.image,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: screenSize.height * 0.35,
                    width: screenSize.width * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) =>
                    Icon(CupertinoIcons.person),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(screenSize.height * 0.006),
                height: screenSize.height * 0.05,
                color: Colors.black87.withOpacity(0.5),
                child: Text(
                  chatUser.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(screenSize.height * 0.006),
                height: screenSize.height * 0.05,
                color: Color(0xff121B22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomMaterialButton(
                      icon: Icons.message_rounded,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChatView(chatUser: chatUser),
                            ));
                      },
                    ),
                    CustomMaterialButton(
                      icon: Icons.add_call,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OneToOneAudioCall(
                                  userId: chatUser.id, userName: chatUser.name),
                            ));
                      },
                    ),
                    CustomMaterialButton(
                      icon: Icons.video_call_rounded,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OneToOneVideoCall(
                                  userId: chatUser.id, userName: chatUser.name),
                            ));
                      },
                    ),
                    CustomMaterialButton(
                      icon: Icons.info_outline,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChatUserProfile(chatUser: chatUser),
                            ));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
