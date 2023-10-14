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

class StartRecordingAudio extends SendMessageState {}

class StartRecordingAudioError extends SendMessageState {
  final String error;

  StartRecordingAudioError({required this.error});
}

class IsRecordingAudio extends SendMessageState {}

class StopRecordingAudio extends SendMessageState {}

class StopRecordingAudioError extends SendMessageState {
  final String error;

  StopRecordingAudioError({required this.error});
}

class AudioPlayerStart extends SendMessageState {}

class AudioPlayerError extends SendMessageState {
  final String error;

  AudioPlayerError({required this.error});
}
