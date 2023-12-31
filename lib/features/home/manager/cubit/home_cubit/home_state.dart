import 'package:flutter/material.dart';

import '../../models/user_model.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeGetUserSuccessState extends HomeState {
  final List<ChatUser> users;

  HomeGetUserSuccessState({required this.users});
}

class HomeGetUserErrorState extends HomeState {
  final String error;

  HomeGetUserErrorState({required this.error});
}

class HomeGetUserLoadingState extends HomeState {}

class HomeSearchSuccessState extends HomeState {
  final List<ChatUser> chatUserSearchList;

  HomeSearchSuccessState({required this.chatUserSearchList});
}

class HomeSearchLoadingState extends HomeState {}

class HomeSearchErrorState extends HomeState {
  final String error;

  HomeSearchErrorState({required this.error});
}
