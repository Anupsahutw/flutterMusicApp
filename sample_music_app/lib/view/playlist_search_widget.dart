import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:samplemusicapp/commons/debounce.dart';
import 'package:samplemusicapp/utilities/app_constants.dart';
import 'package:samplemusicapp/services/api_response.dart';
import 'package:samplemusicapp/view/player_controls_widget.dart';
import 'package:samplemusicapp/view/song_list_widget.dart';
import 'package:samplemusicapp/blocs/songlist_blocs.dart';
import 'package:samplemusicapp/model/song_display_model.dart';

import '../commons/loading.dart';
import '../commons/show_error.dart';
import '../commons/empty_results.dart';

class PlayListSearch extends StatefulWidget {
  @override
  ListSearchState createState() => ListSearchState();
}

class ListSearchState extends State<PlayListSearch> {
  SongBloc _bloc;
  String _allSongs = "*";
  TextEditingController _textController = TextEditingController();
  GlobalKey<PlayControlState> _myKey = GlobalKey();
  GlobalKey<SongListWidgetState> _myKeySongList = GlobalKey();
  final _debounce = Debounce(milliseconds: 2000);

  @override
  void initState() {
    super.initState();
    _textController.clear();
    _bloc = SongBloc();
    _bloc.fetchSongList(_allSongs);
  }

  onItemChanged(String artistName) {
    _debounce.run(() {
      artistName.isNotEmpty
          ? _bloc.fetchSongList(artistName)
          : _bloc.fetchSongList(_allSongs);
    });
  }

  onSongPlayed(int currentPlayedAudioIndex, int previousPlayedAudioIndex,
      List<SongDisplayModel> songList) {
    String currentSongUrl = "";
    currentSongUrl = songList[currentPlayedAudioIndex].previewUrl;
    _myKey.currentState
        .setCurrentSongUrl(currentSongUrl, songList, currentPlayedAudioIndex);
    if (songList[currentPlayedAudioIndex].isPlaying) {
      _myKey.currentState.setStateOnPlay(true, true);
    } else {
      _myKey.currentState.setStateOnPlay(false, false);
    }
  }

  onSongPaused() {
    _myKeySongList.currentState.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(AppConstants.navTitle,
            style: TextStyle(color: Colors.lightGreen, fontSize: 28)),
        backgroundColor: Colors.black54,
      ),
      backgroundColor: Colors.black54,
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchSongList(_allSongs),
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: AppConstants.searchBy,
                  ),
                  onChanged: onItemChanged,
                ),
              ),
            ),
            StreamBuilder<ApiResponse<List<SongDisplayModel>>>(
              stream: _bloc.songListStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Loading(loadingMessage: snapshot.data.message);
                      break;
                    case Status.COMPLETED:
                      return SongListWidget(
                        key: _myKeySongList,
                        songList: snapshot.data.data,
                        callback: (currentSongIndex, previousPlayedAudioIndex,
                            songList) {
                          onSongPlayed(currentSongIndex,
                              previousPlayedAudioIndex, songList);
                        },
                      );
                      break;
                    case Status.ERROR:
                      return Error(
                        errorMessage: snapshot.data.message,
                        onRetryPressed: () => _bloc.fetchSongList(_allSongs),
                      );
                      break;
                    case Status.EMPTY:
                      return EmptyResult(
                        message: snapshot.data.message,
                      );
                  }
                }
                return Container();
              },
            ),
            PlayerControlWidget(
              key: _myKey,
              callback: (isPlaying, songList, currentPlayedAudioIndex) {
                callBackReceivedOnPlayPauseClicked(
                    songList, currentPlayedAudioIndex, isPlaying);
              },
            ),
          ],
        ),
      ),
    );
  }

  void callBackReceivedOnPlayPauseClicked(List<SongDisplayModel> songList,
      int currentPlayedAudioIndex, bool isPlaying) {
    if (listEquals(songList, _myKeySongList.currentState.widget.songList)) {
      _myKeySongList.currentState.widget.songList[currentPlayedAudioIndex]
          .setIsPlaying(isPlaying);
      onSongPaused();
    }
  }

  @override
  void dispose() {
    _bloc.dispose();
    _textController.dispose();
    _debounce.cancelTimer();
    super.dispose();
  }
}
