import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../core/global_var.dart';

class Controls extends StatefulWidget {
  const Controls({Key? key, required this.audioPlayer}) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  _ControlsState createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  late StreamSubscription<PlayerState> _playerStateSubscription;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = widget.audioPlayer;
    _playerStateSubscription =
        _audioPlayer.playerStateStream.listen((playerState) {
      setState(() {
        // Handle player state changes here
      });
    });
  }

  @override
  void dispose() {
    _playerStateSubscription.cancel();
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
