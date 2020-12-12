import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samplemusicapp/utilities/app_constants.dart';
import 'package:samplemusicapp/services/api_response.dart';
import 'package:samplemusicapp/view/player_controls_widget.dart';
import 'package:samplemusicapp/view/song_list_widget.dart';
import 'package:samplemusicapp/blocs/songlist_blocs.dart';
import 'package:samplemusicapp/viewmodel/songviewmodel.dart';

import '../commons/loading.dart';
import '../commons/show_error.dart';
import '../commons/empty_results.dart';

class PlayListSearch extends StatefulWidget {
  @override
  ListSearchState createState() => ListSearchState();
}

class ListSearchState extends State<PlayListSearch> {
  SongBloc _bloc;
  String allSongs = "*";
  List<SongViewModel> songList;
  int currentPlayedAudioIndex;
  TextEditingController _textController = TextEditingController();
  GlobalKey<PlayControlState> _myKey = GlobalKey();
  GlobalKey<SongListWidgetState> _myKeySongList = GlobalKey();
  //List<SongsPlay> songPlayList = List();

  @override
  void initState() {
    super.initState();
    _textController.clear();
    _bloc = SongBloc(allSongs);
  }

  onItemChanged(String artistName) {
    setState(() {
      artistName.isNotEmpty
          ? _bloc.fetchSongList(artistName)
          : _bloc.fetchSongList(allSongs);
    });
  }

  onSongPlayed(int currentPlayedAudioIndex, int previousPlayedAudioIndex,
      List<SongViewModel> songList) {
    String currentSongUrl = "";
    currentSongUrl = songList[currentPlayedAudioIndex].previewUrl;
    print("...................");
    print(currentSongUrl);
    songList = songList;
    currentPlayedAudioIndex = currentPlayedAudioIndex;
    _myKey.currentState
        .setCurrentSongUrl(currentSongUrl, songList, currentPlayedAudioIndex);
    if (songList[currentPlayedAudioIndex].isPlaying) {
      _myKey.currentState.setStateOnPlay(true);
    } else {
      _myKey.currentState.setStateOnPlay(false);
    }

    //setState(() {});
  }

  onSongPaused(bool isPlaying) {
    /*print("//////////////////");
    print(songList);
    _myKeySongList.currentState.widget.songList[0].setIsPlaying(isPlaying);
    //songList[currentPlayedAudioIndex].setIsPlaying(isPlaying);
    setState(() {});*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Songs Mania',
            style: TextStyle(color: Colors.lightGreen, fontSize: 28)),
        backgroundColor: Colors.black54,
      ),
      backgroundColor: Colors.black54,
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchSongList(allSongs),
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Search By Artist...',
                  ),
                  onChanged: onItemChanged,
                ),
              ),
            ),
            StreamBuilder<ApiResponse<List<SongViewModel>>>(
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
                        errorMessage: AppConstants.wentWrong,
                        onRetryPressed: () => _bloc.fetchSongList(allSongs),
                      );
                      break;
                    case Status.EMPTY:
                      return EmptyResult(
                        message: AppConstants.noSongs,
                      );
                  }
                }
                return Container();
              },
            ),
            PlayerControlWidget(
              key: _myKey,
              callback: (isPlaying, songList, currentPlayedAudioIndex) {
                print(isPlaying);
                onSongPaused(isPlaying);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    _textController.dispose();
    super.dispose();
  }
}
