import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/features/chat/presentation/chat_view.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

class ChatUserCard extends StatelessWidget {
  const ChatUserCard({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.symmetric(
        vertical: screenSize.height * 0.004,
        horizontal: screenSize.width * 0.02,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatView(
                        chatUser: user,
                      )));
        },
        child: ListTile(
          title: Text(user.name, style: TextStyle(fontSize: 18)),
          subtitle: Text(
            user.about,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
            ),
            maxLines: 1,
          ),
          leading: CachedNetworkImage(
            imageUrl: user.image,
            imageBuilder: (context, imageProvider) {
              return Container(
                width: screenSize.width * 0.15,
                height: screenSize.width * 0.15,
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
          // trailing: Text(
          //   '12:00 pm',
          //   style: TextStyle(
          //     color: Colors.black,
          //   ),
          // ),
          trailing: Container(
            height: screenSize.height * 0.02,
            width: screenSize.height * 0.02,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenSize.width * 0.05),
                color: Colors.lightGreenAccent),
          ),
        ),
      ),
    );
  }
}
