import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat/core/global_var.dart';

//this function for update user profile image
Future<void> updateUserProfileImage(File file) async {
  //for get extension of photo like jpg, jpeg and png
  var extension = file.path.split('.').last;
  //storage file reference with path
  var reference =
      firebaseStorage.ref().child('profile_pictures/${me.id}.$extension');
  //uploading image
  await reference
      .putFile(file, SettableMetadata(contentType: 'image/$extension'))
      .then((p0) {
    print(' ${p0.bytesTransferred / 1000} kb');
  });
  //updating image in firestore
  me.image = await reference.getDownloadURL();
  await firestore.collection('users').doc(me.id).update({
    'image': me.image,
  });
}
