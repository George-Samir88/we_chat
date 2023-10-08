import 'package:flutter/material.dart';

import '../../models/message_model.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatGetMessagesSuccess extends ChatState {
  final List<MessageModel> messages;

  ChatGetMessagesSuccess({required this.messages});
}

class ChatGetMessagesError extends ChatState {
  final String error;

  ChatGetMessagesError({required this.error});
}

class ChatGetMessagesLoading extends ChatState {}
