import 'package:flutter/material.dart';

@immutable
abstract class SendMessageState {}

class SendMessageInitial extends SendMessageState {}

class SendMessageSuccess extends SendMessageState {}

class SendMessageError extends SendMessageState {
  final String error;

  SendMessageError({required this.error});
}

class SendMessageLoading extends SendMessageState {}

class PickImageSuccess extends SendMessageState {}

class PickImageError extends SendMessageState {
  final String error;

  PickImageError({required this.error});
}
