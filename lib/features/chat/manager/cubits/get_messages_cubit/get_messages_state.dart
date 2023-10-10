import 'package:flutter/material.dart';

import '../../models/message_model.dart';

@immutable
abstract class GetMessagesState {}

class ChatGetMessagesInitial extends GetMessagesState {}

class ChatGetMessagesSuccess extends GetMessagesState {
  final List<MessageModel> messages;

  ChatGetMessagesSuccess({required this.messages});
}

class ChatGetMessagesError extends GetMessagesState {
  final String error;

  ChatGetMessagesError({required this.error});
}

class ChatGetMessagesLoading extends GetMessagesState {}
