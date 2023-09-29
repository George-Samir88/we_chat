import 'package:flutter/material.dart';

@immutable
abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserProfilePickPhotoSuccess extends UserProfileState {}

class UserProfilePickPhotoError extends UserProfileState {
  final String error;

  UserProfilePickPhotoError({required this.error});
}
