import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/global_var.dart';

class PositionData {
  final Duration? position;
  final Duration? bufferPosition;
  final Duration? duration;

  PositionData({this.position, this.bufferPosition, this.duration});
}

class Controls extends StatefulWidget {
  const Controls({
    Key? key,
    required this.audioUrl,
  }) : super(key: key);
  final String audioUrl;

  @override
  _ControlsState createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  late StreamSubscription<PlayerState> _playerStateSubscription;
  late AudioPlayer _audioPlayer;

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration?, Duration?, Duration?, PositionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, bufferPosition, duration) => PositionData(
              position: position ?? Duration.zero,
              bufferPosition: bufferPosition ?? Duration.zero,
              duration: duration ?? Duration.zero));

  void _initializeAudioPlayer() {
    _audioPlayer = AudioPlayer()..setUrl(widget.audioUrl);
    _playerStateSubscription =
        _audioPlayer.playerStateStream.listen((playerState) {
      setState(() {
        // Handle player state changes here
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeAudioPlayer();
  }

  @override
  void didUpdateWidget(Controls oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.audioUrl != oldWidget.audioUrl) {
      // Audio URL has changed, dispose of the old player and create a new one
      _audioPlayer.dispose();
      _playerStateSubscription.cancel();
      _initializeAudioPlayer();
    }
  }

  @override
  void dispose() {
    _playerStateSubscription.cancel();
    _audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: screenSize.height * 0.008),
          child: StreamBuilder<PlayerState>(
            stream: _audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;

              if (!(playing ?? false)) {
                return IconButton(
                  onPressed: () {
                    _audioPlayer.play();
                  },
                  iconSize: screenSize.height * 0.045,
                  color: Colors.white,
                  constraints: BoxConstraints(),
                  splashColor: Colors.grey,
                  splashRadius: screenSize.height * 0.033,
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.grey,
                  ),
                );
              } else if (processingState == ProcessingState.completed) {
                // Reset or prepare the player for the next playback
                _audioPlayer.stop();
                _audioPlayer.seek(Duration.zero);
                return IconButton(
                  onPressed: () {
                    _audioPlayer.play();
                  },
                  constraints: BoxConstraints(),
                  iconSize: screenSize.height * 0.045,
                  color: Colors.white,
                  splashColor: Colors.grey,
                  splashRadius: screenSize.height * 0.033,
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.grey,
                  ),
                );
              } else {
                return IconButton(
                  onPressed: () {
                    _audioPlayer.pause();
                  },
                  constraints: BoxConstraints(),
                  iconSize: screenSize.height * 0.045,
                  color: Colors.white,
                  splashColor: Colors.grey,
                  splashRadius: screenSize.height * 0.033,
                  icon: Icon(
                    Icons.pause,
                    color: Colors.grey,
                  ),
                );
              }
            },
          ),
        ),
        StreamBuilder<PositionData>(
          stream: _positionDataStream,
          builder: (context, snapshot) {
            final positionData = snapshot.data;
            return Expanded(
              child: ProgressBar(
                barHeight: screenSize.height * 0.005,
                timeLabelLocation: TimeLabelLocation.sides,
                baseBarColor: Colors.grey[600],
                thumbRadius: screenSize.height * 0.008,
                bufferedBarColor: Colors.grey,
                progressBarColor: Colors.blue,
                timeLabelTextStyle: TextStyle(
                  color: Colors.grey[600],
                ),
                progress: positionData?.position ?? Duration.zero,
                buffered: positionData?.bufferPosition ?? Duration.zero,
                total: positionData?.duration ?? Duration.zero,
                onSeek: _audioPlayer.seek,
              ),
            );
          },
        ),
      ],
    );
  }
}
