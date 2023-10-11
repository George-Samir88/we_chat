import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/core/widgets/custom_alert_message.dart';
import 'package:we_chat/features/chat/manager/cubits/get_last_message_cubit/get_last_message_cubit.dart';
import 'package:we_chat/features/chat/manager/cubits/get_last_message_cubit/get_last_message_state.dart';
import 'package:we_chat/features/chat/manager/models/message_model.dart';
import 'package:we_chat/features/chat/presentation/chat_view.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

class ChatUserCard extends StatelessWidget {
  const ChatUserCard({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    MessageModel? messageModel;
    return BlocProvider(
      create: (context) =>
          GetLastMessageCubit()..getLastMessage(chatUser: user),
      child: Card(
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
          child: BlocConsumer<GetLastMessageCubit, GetLastMessageState>(
            listener: (context, state) {
              if (state is ChatGetLastMessageError) {
                customAlertMessage(
                    message: 'An error occurred ' + state.error,
                    backgroundColor: Colors.red);
              } else if (state is ChatGetLastMessageSuccess) {
                messageModel = state.messages[0];
              }
            },
            builder: (context, state) {
              return ListTile(
                title: Text(
                  user.name,
                  style: TextStyle(fontSize: 18),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: state is ChatGetLastMessageSuccess
                    ? (state.messages.isNotEmpty
                        ? (state.messages[0].type == Type.text
                            ? Text(
                                state.messages[0].msg,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                                maxLines: 1,
                              )
                            : Row(
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: screenSize.width * 0.06,
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.012,
                                  ),
                                  Text(
                                    'Photo',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ))
                        : Text(
                            user.about,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            maxLines: 1,
                          ))
                    : Text(
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
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) =>
                      Icon(CupertinoIcons.person),
                ),
                // trailing: Text(
                //   '12:00 pm',
                //   style: TextStyle(
                //     color: Colors.black,
                //   ),
                // ),
                trailing: messageModel == null
                    ? null
                    : (messageModel!.read.isEmpty &&
                            messageModel!.fromId !=
                                firebaseAuth.currentUser!.uid)
                        ? Container(
                            height: screenSize.height * 0.02,
                            width: screenSize.height * 0.02,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    screenSize.width * 0.05),
                                color: Colors.lightGreenAccent),
                          )
                        : Text(
                            formatDate(messageModel!.sent),
                            style:
                                TextStyle(color: Colors.black54, fontSize: 13),
                          ),
              );
            },
          ),
        ),
      ),
    );
  }

  String formatDate(String time) {
    DateTime now = DateTime.now();
    if (now.day == DateTime.parse(time).day &&
        now.month == DateTime.parse(time).month &&
        now.year == DateTime.parse(time).year) {
      return DateFormat.jm().format(DateTime.parse(time));
    }
    return DateFormat.yMd().format(DateTime.parse(time));
  }
}
