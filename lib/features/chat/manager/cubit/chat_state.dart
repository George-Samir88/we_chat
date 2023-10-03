import 'package:flutter/material.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatGetMessagesSuccess extends ChatState {}

class ChatGetMessagesError extends ChatState {
  final String error;

  ChatGetMessagesError({required this.error});
}

class ChatGetMessagesLoading extends ChatState {}
