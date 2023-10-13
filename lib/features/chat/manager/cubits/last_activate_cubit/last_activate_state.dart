import 'package:flutter/material.dart';

@immutable
abstract class LastActivateState {}

class LastActivateInitial extends LastActivateState {}

class LastActivateSuccess extends LastActivateState {}

class LastActivateError extends LastActivateState {
  final String failure;

  LastActivateError({required this.failure});
}

class LastActivateLoading extends LastActivateState {}
