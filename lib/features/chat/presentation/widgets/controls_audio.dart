import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../core/global_var.dart';

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
    return StreamBuilder<PlayerState>(
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
            iconSize: screenSize.height * 0.04,
            color: Colors.white,
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
            iconSize: screenSize.height * 0.04,
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
            iconSize: screenSize.height * 0.04,
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
    );
  }
}
