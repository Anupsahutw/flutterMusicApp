import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samplemusicapp/commons/audioPlayer.dart';
import 'package:samplemusicapp/viewmodel/songviewmodel.dart';

class PlayerControlWidget extends StatefulWidget {
  final Function(bool isPlaying, List<SongViewModel> songList,
      int currentPlayedAudioIndex) callback;

  PlayerControlWidget({Key key, this.callback}) : super(key: key);
  @override
  PlayControlState createState() => PlayControlState();
}

class PlayControlState extends State<PlayerControlWidget> {
  StreamSubscription<void> _playerSub;
  AssetsAudioPlayer _audio;

  bool _isPlaying = false;
  bool _visible = false;
  String currentSongUrl;
  List<SongViewModel> songList;
  int currentPlayedAudioIndex;

  @override
  void initState() {
    super.initState();
    var playSongViewModel = SingletonAudioPlayer();
    _audio = playSongViewModel.assetsAudioPlayer;
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
      _visible = false;
    });
    widget.callback(false, songList, currentPlayedAudioIndex);
  }

  Future play(String url) async {
    try {
      await _audio.open(
        Audio.network(url),
      );
      setStateOnPlay(true, true);
      widget.callback(true, songList, currentPlayedAudioIndex);
    } catch (t) {
      //mp3 unreachable
    }
  }

  void setStateOnPlay(bool playing, bool visible) {
    setState(() {
      _isPlaying = playing;
      _visible = visible;
    });
  }

  void setCurrentSongUrl(
      String url, List<SongViewModel> songList, int currentPlayedAudioIndex) {
    currentSongUrl = url;
    this.songList = songList;
    this.currentPlayedAudioIndex = currentPlayedAudioIndex;
  }

  Future pause() async {
    await _audio.pause();
    setStateOnPlay(false, true);
    widget.callback(false, songList, currentPlayedAudioIndex);
  }

  Future resume() async {
    await _audio.play();
    setStateOnPlay(true, true);
    widget.callback(true, songList, currentPlayedAudioIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible,
      child: Container(
        alignment: FractionalOffset.bottomCenter,
        child: IconButton(
          icon: (_isPlaying)
              ? Icon(Icons.pause_circle_filled)
              : Icon(Icons.play_circle_outline),
          iconSize: 60,
          onPressed: () => _isPlaying ? pause() : play(currentSongUrl),
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
      ),
    );
  }
}
