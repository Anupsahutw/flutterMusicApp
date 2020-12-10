import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samplemusicapp/constants/app_constants.dart';
import 'package:samplemusicapp/model/songs.dart';
import 'package:samplemusicapp/services/api_response.dart';
import 'package:samplemusicapp/view/song_list.dart';
import 'package:samplemusicapp/blocsViewModel/playlist_blocs_view_model.dart';
import 'package:samplemusicapp/viewmodel/songviewmodel.dart';

import '../commons/loading.dart';
import '../commons/show_error.dart';
import '../commons/empty_results.dart';

class PlayListSearch extends StatefulWidget {
  @override
  ListSearchState createState() => ListSearchState();
}

class ListSearchState extends State<PlayListSearch> {
  MovieBloc _bloc;
  String songs = "*";
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.clear();
    _bloc = MovieBloc(songs);
  }

  onItemChanged(String value) {
    setState(() {
      value.isNotEmpty
          ? _bloc.fetchSongList(value)
          : _bloc.fetchSongList(songs);
    });
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
        onRefresh: () => _bloc.fetchSongList(songs),
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
              stream: _bloc.movieListStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Loading(loadingMessage: snapshot.data.message);
                      break;
                    case Status.COMPLETED:
                      return snapshot.data.data != null
                          ? SongList(songList: snapshot.data.data)
                          : EmptyResult(
                              message: TextConstants.noSongs,
                            );
                      break;
                    case Status.ERROR:
                      return Error(
                        errorMessage: TextConstants.wentWrong,
                        onRetryPressed: () => _bloc.fetchSongList(songs),
                      );
                      break;
                  }
                }
                return Container();
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
    super.dispose();
  }
}
