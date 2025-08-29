import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioTest extends StatelessWidget {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Play A'),
          onPressed: () {
            _audioPlayer.play(AssetSource('audio/A.mp3'));
          },
        ),
      ),
    );
  }
}