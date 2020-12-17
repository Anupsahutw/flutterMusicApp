import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:samplemusicapp/commons/audio_player.dart';
import 'package:samplemusicapp/commons/play_pause_song.dart';
import 'package:samplemusicapp/model/song_display_model.dart';
import 'package:samplemusicapp/viewmodel/handle_song_list_viewmodel.dart';

class SongListWidget extends StatefulWidget {
  final List<SongDisplayModel> songList;
  final Function(int currentPlayedAudioIndex, int previousPlayedAudioIndex,
      List<SongDisplayModel> songList) callback;
  SongListWidget({Key key, this.songList, this.callback}) : super(key: key);
  @override
  SongListWidgetState createState() => SongListWidgetState();
}

class SongListWidgetState extends State<SongListWidget> {
  int previousPlayedAudioIndex;
  var handleSongListViewModel = HandleSongListViewModel();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.black54,
        child: ListView.builder(
          itemCount: widget.songList.length,
          itemBuilder: (context, index) {
            SongDisplayModel model = widget.songList[index];
            return SongListItemWidget(model, (currentSongIndex) {
              callbackReceived(currentSongIndex);
            }, widget.songList, index, previousPlayedAudioIndex);
          },
        ),
      ),
    );
  }

  void callbackReceived(int currentSongIndex) {
    var handleSongPlayList = handleSongListViewModel.handlePlaySong(
        currentSongIndex, previousPlayedAudioIndex, widget.songList);

    var playPauseSong = PlayPauseSong(SingletonAudioPlayer());
    playPauseSong.playSong(handleSongPlayList[currentSongIndex],
        handleSongPlayList, previousPlayedAudioIndex);

    widget.callback(
        currentSongIndex, previousPlayedAudioIndex, handleSongPlayList);
    previousPlayedAudioIndex = currentSongIndex;

    setState(() {});
  }
}

class SongListItemWidget extends StatefulWidget {
  final SongDisplayModel model;
  final Function(int previousAudioIndex) callback;
  final List<SongDisplayModel> songList;
  final int currentSongIndex;
  final int previousPlayedAudioIndex;
  SongListItemWidget(this.model, this.callback, this.songList,
      this.currentSongIndex, this.previousPlayedAudioIndex);
  @override
  SongState createState() => SongState();
}

class SongState extends State<SongListItemWidget> {
  bool isPlaying = false;
  SingletonAudioPlayer playSongViewModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 44,
          minHeight: 44,
          maxWidth: 44,
          maxHeight: 44,
        ),
        child: Image.network(
          widget.model.artworkUrl100,
          fit: BoxFit.fill,
        ),
      ),
      title: Text(widget.model.trackName),
      subtitle:
          Text(widget.model.artistName + '\n${widget.model.collectionName}'),
      isThreeLine: true,
      trailing: ImageTrackWidget(widget.model.isPlaying),
      onTap: () {
        widget.callback(widget.currentSongIndex);
      },
    );
  }
}

class ImageTrackWidget extends StatelessWidget {
  final bool viewVisible;

  ImageTrackWidget(this.viewVisible);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: viewVisible,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 44,
          minHeight: 44,
          maxWidth: 60,
          maxHeight: 60,
        ),
        child: Image.asset(
          'images/music.gif',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
