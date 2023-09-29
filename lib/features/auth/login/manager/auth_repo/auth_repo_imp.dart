import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/features/auth/login/manager/auth_repo/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  @override
  Future<Either<String, UserCredential>> signInWithGoogle() async {
    try {
      //check internet connection
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      return right(
          await firebaseAuth.signInWithCredential(credential));
    } catch (err) {
      if (err.toString().contains('SocketException')) {
        return left('Please check your internet connection');
      }
      return left(err.toString());
    }
  }
}
