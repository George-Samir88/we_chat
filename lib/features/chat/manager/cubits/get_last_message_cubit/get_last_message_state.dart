import 'package:flutter/material.dart';

import '../../models/message_model.dart';

@immutable
abstract class GetLastMessageState {}

class GetLastMessageInitial extends GetLastMessageState {}

class ChatGetLastMessageSuccess extends GetLastMessageState {
  final List<MessageModel>? messages;

  ChatGetLastMessageSuccess({required this.messages});
}

class ChatGetLastMessageError extends GetLastMessageState {
  final String error;

  ChatGetLastMessageError({required this.error});
}

class ChatGetLastMessageLoading extends GetLastMessageState {}
