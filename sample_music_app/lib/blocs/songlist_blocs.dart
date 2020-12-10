import 'dart:async';

import 'package:samplemusicapp/constants/app_constants.dart';
import 'package:samplemusicapp/model/songs.dart';
import 'package:samplemusicapp/repository/playlist_repository.dart';
import 'package:samplemusicapp/services/api_response.dart';
import 'package:samplemusicapp/viewmodel/songviewmodel.dart';

class SongBloc {
  PlayListRepository _playListRepository;

  StreamController _songListController;

  StreamSink<ApiResponse<List<SongViewModel>>> get songListSink =>
      _songListController.sink;

  Stream<ApiResponse<List<SongViewModel>>> get songListStream =>
      _songListController.stream;

  SongBloc(String artist) {
    _songListController = StreamController<ApiResponse<List<SongViewModel>>>();
    _playListRepository = PlayListRepository();
    fetchSongList(artist);
  }

  fetchSongList(String artist) async {
    songListSink.add(ApiResponse.loading(TextConstants.fetchingPopularSongs));
    try {
      List<Results> songs = await _playListRepository.fetchSongList(artist);
      List<SongViewModel> songsUI =
          songs.map((results) => SongViewModel(results)).toList();
      songListSink.add(ApiResponse.completed(songsUI));
    } catch (e) {
      songListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _songListController?.close();
  }
}