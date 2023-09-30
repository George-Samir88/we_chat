import 'package:flutter/material.dart';

@immutable
abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserProfilePickPhotoSuccess extends UserProfileState {}

class UserProfilePickPhotoError extends UserProfileState {
  final String error;

  UserProfilePickPhotoError({required this.error});
}

class UserProfileUpdatePhotoLoading extends UserProfileState {}

class UserProfileUpdatePhotoSuccess extends UserProfileState {}

class UserProfileUpdatePhotoError extends UserProfileState {
  final String error;

  UserProfileUpdatePhotoError({required this.error});
}
