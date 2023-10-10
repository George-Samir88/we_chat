import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

EmojiPicker pickEmoji(
    {required TextEditingController textEditingController}) {
  return EmojiPicker(
    textEditingController: textEditingController,
    // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
    config: Config(
      columns: 8,
      emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
      // Issue: https://github.com/flutter/flutter/issues/28894
      verticalSpacing: 0,
      horizontalSpacing: 0,
      gridPadding: EdgeInsets.zero,
      initCategory: Category.RECENT,
      bgColor: Color.fromARGB(255, 234, 248, 255),
      indicatorColor: Colors.blue,
      iconColor: Colors.grey,
      iconColorSelected: Colors.blue,
      backspaceColor: Colors.blue,
      skinToneDialogBgColor: Colors.white,
      skinToneIndicatorColor: Colors.grey,
      enableSkinTones: true,
      recentTabBehavior: RecentTabBehavior.RECENT,
      recentsLimit: 28,
      noRecents: const Text(
        'No Recents',
        style: TextStyle(fontSize: 20, color: Colors.black26),
        textAlign: TextAlign.center,
      ),
      // Needs to be const Widget
      loadingIndicator: const SizedBox.shrink(),
      // Needs to be const Widget
      tabIndicatorAnimDuration: kTabScrollDuration,
      categoryIcons: const CategoryIcons(),
      buttonMode: ButtonMode.MATERIAL,
    ),
  );
}
