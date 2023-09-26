import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:we_chat/features/home/manager/models/user_model.dart';

late Size screenSize;
FirebaseFirestore firestore = FirebaseFirestore.instance;
late ChatUser me;
