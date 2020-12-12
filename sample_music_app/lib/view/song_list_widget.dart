import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:samplemusicapp/viewmodel/playSongViewModel.dart';
import 'package:samplemusicapp/viewmodel/songviewmodel.dart';

class SongListWidget extends StatefulWidget {
  final List<SongViewModel> songList;
  final Function(String url) callback;
  SongListWidget({Key key, this.songList, this.callback}) : super(key: key);
  @override
  SongListWidgetState createState() => SongListWidgetState();
}

class SongListWidgetState extends State<SongListWidget> {
  int previousPlayedAudioIndex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.black54,
        child: ListView.builder(
          itemCount: widget.songList.length,
          itemBuilder: (context, index) {
            SongViewModel model = widget.songList[index];
            return SongListItemWidget(model, (currentSongIndex) {
              widget.callback(model.previewUrl);
              PlaySongViewModel playSongViewModel = PlaySongViewModel();
              playSongViewModel.handleSongPlay(
                  currentSongIndex, previousPlayedAudioIndex, widget.songList);
              previousPlayedAudioIndex = currentSongIndex;
              setState(() {});
            }, widget.songList, index, previousPlayedAudioIndex);
          },
        ),
      ),
    );
  }
}

class SongListItemWidget extends StatefulWidget {
  final SongViewModel model;
  final Function(int previousAudioIndex) callback;
  final List<SongViewModel> songList;
  final int currentSongIndex;
  final int previousPlayedAudioIndex;
  SongListItemWidget(this.model, this.callback, this.songList,
      this.currentSongIndex, this.previousPlayedAudioIndex);
  @override
  SongState createState() => SongState();
}

class SongState extends State<SongListItemWidget> {
  bool isPlaying = false;
  PlaySongViewModel playSongViewModel;

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
