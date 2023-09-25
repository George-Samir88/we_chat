import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

late Size screenSize;
FirebaseFirestore firestore = FirebaseFirestore.instance;
//this bool var controls isolation of getChatUsersFunction avoiding calling it twice
bool isFetchingChatUsers = false;
