import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:we_chat/core/widgets/custom_alert_message.dart';
import 'package:we_chat/features/chat/manager/cubits/last_activate_cubit/last_activate_cubit.dart';
import 'package:we_chat/features/chat/manager/cubits/last_activate_cubit/last_activate_state.dart';
import 'package:we_chat/features/chat/presentation/widgets/one_to_one_audio_call.dart';
import 'package:we_chat/features/chat/presentation/widgets/one_to_one_video_call.dart';
import 'package:we_chat/features/chat_user_profile/presentation/chat_user_profile.dart';

import '../../../../core/global_var.dart';
import '../../../home/manager/models/user_model.dart';

class CustomFlexibleAppBar extends StatelessWidget {
  const CustomFlexibleAppBar({super.key, required this.chatUser});

  final ChatUser chatUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatUserProfile(
                          chatUser: chatUser,
                        )));
          },
          child: BlocConsumer<LastActivateCubit, LastActivateState>(
            listener: (context, state) {
              if (state is LastActivateError) {
                customAlertMessage(
                    message: 'An error occurred ' + state.failure,
                    backgroundColor: Colors.red);
              }
            },
            builder: (context, state) {
              var blocHelper = BlocProvider.of<LastActivateCubit>(context);
              return Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.zero,
                      splashRadius: screenSize.height * 0.008,
                      icon: Icon(
                        CupertinoIcons.back,
                        size: screenSize.height * 0.04,
                        color: Colors.black,
                      )),
                  CachedNetworkImage(
                    imageUrl: blocHelper.userActivate?.image ?? chatUser.image,
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
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        Icon(CupertinoIcons.person),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.015,
                  ),
                  SizedBox(
                    width: screenSize.width * 0.48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.005,
                        ),
                        Text(
                          blocHelper.userActivate?.name ?? chatUser.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              letterSpacing: 0.5),
                        ),
                        Text(
                          blocHelper.userActivate?.lastActive != null
                              ? (blocHelper.userActivate!.isOnline
                                  ? 'Online'
                                  : formatDate(
                                      lastActive:
                                          blocHelper.userActivate!.lastActive))
                              : formatDate(lastActive: chatUser.lastActive),
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 10,
                            overflow: TextOverflow.ellipsis,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Expanded(
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.call),
                constraints: BoxConstraints(),
                iconSize: screenSize.height * 0.030,
                padding: EdgeInsets.only(
                  left: screenSize.width * 0.04,
                ),
                color: Color(0xff00AB82),
                splashRadius: screenSize.height * 0.023,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OneToOneAudioCall(
                              userId: chatUser.id, userName: chatUser.name)));
                },
              ),
              SizedBox(
                width: 15,
              ),
              IconButton(
                icon: Icon(Icons.video_call_rounded),
                constraints: BoxConstraints(),
                padding: EdgeInsets.only(
                  right: screenSize.width * 0.05,
                ),
                iconSize: screenSize.height * 0.030,
                color: Color(0xff00AB82),
                splashRadius: screenSize.height * 0.023,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OneToOneVideoCall(
                              userId: chatUser.id, userName: chatUser.name)));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  String formatDate({required String lastActive}) {
    final lastActiveTryParse = DateTime.tryParse(lastActive) ?? -1;
    print(lastActiveTryParse);
    if (lastActiveTryParse == -1) {
      return 'Last seen now available';
    }
    DateTime now = DateTime.now();
    DateTime formattedLastActive = DateTime.parse(lastActive);
    if (now.day == formattedLastActive.day &&
        now.month == formattedLastActive.month &&
        now.year == formattedLastActive.year) {
      return 'Last seen today at ${DateFormat.jm().format(formattedLastActive)}';
    } else if ((now.difference(formattedLastActive).inHours / 24).round() ==
        1) {
      return 'Last seen yesterday at ${DateFormat.jm().format(formattedLastActive)}';
    }
    DateFormat dateFormat = DateFormat('dd/MM');
    return 'Last seen in ${dateFormat.format(formattedLastActive)} at ${DateFormat.jm().format(formattedLastActive)}';
  }
}
