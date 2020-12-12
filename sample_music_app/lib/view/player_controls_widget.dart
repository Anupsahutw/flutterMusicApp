import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerControlWidget extends StatefulWidget {
  final String id;
  final String url;

  PlayerControlWidget({Key key, this.id, this.url}) : super(key: key);
  @override
  PlayControlState createState() => PlayControlState();
}

class PlayControlState extends State<PlayerControlWidget> {
  StreamSubscription<void> _playerSub;
  AssetsAudioPlayer _audio;

  bool _isPlaying = false;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _audio = AssetsAudioPlayer.withId(widget.id);
    _playerSub = _audio.playlistAudioFinished.listen((event) {
      _clearPlayer();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _playerSub.cancel();
    _audio.dispose();
  }

  void _clearPlayer() {
    setState(() {
      _isPlaying = false;
      _isPaused = false;
    });
  }

  Future play(String url) async {
    try {
      await _audio.open(
        Audio.network(url),
      );
      setState(() {
        _isPlaying = true;
      });
    } catch (t) {
      //mp3 unreachable
    }
//    if (result == 1) {
//      setState(() {
//        _isPlaying = true;
//      });
//    }
  }

  Future pause() async {
    await _audio.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  Future resume() async {
    await _audio.play();
    setState(() {
      _isPlaying = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.bottomCenter,
      child: IconButton(
        icon: (_isPlaying)
            ? Icon(Icons.pause_circle_filled)
            : Icon(Icons.play_circle_outline),
        iconSize: 60,
        onPressed: () =>
            _isPlaying ? pause() : _isPaused ? resume() : play(widget.url),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey.withOpacity(0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
    );
  }
}
