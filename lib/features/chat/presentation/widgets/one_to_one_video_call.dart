import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class OneToOneVideoCall extends StatelessWidget {
  const OneToOneVideoCall(
      {Key? key, required this.userId, required this.userName})
      : super(key: key);
  final String userId;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1321492848,
      // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          '6f3909a857b9d860279c42cd3b0a15d730bef8e46126e2fbd85cb8c539532f8d',
      // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userId,
      userName: userName,
      callID: 'demo_call_id_for_testing',
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
