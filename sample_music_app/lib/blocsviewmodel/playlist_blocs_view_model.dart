import 'dart:async';

import 'package:samplemusicapp/model/songs.dart';
import 'package:samplemusicapp/repository/playlist_repository.dart';
import 'package:samplemusicapp/services/api_response.dart';
import 'package:samplemusicapp/viewmodel/songviewmodel.dart';

class MovieBloc {
  PlayListRepository _movieRepository;

  StreamController _movieListController;

  StreamSink<ApiResponse<List<SongViewModel>>> get movieListSink =>
      _movieListController.sink;

  Stream<ApiResponse<List<SongViewModel>>> get movieListStream =>
      _movieListController.stream;

  MovieBloc(String artist) {
    _movieListController = StreamController<ApiResponse<List<Results>>>();
    _movieRepository = PlayListRepository();
    fetchSongList(artist);
  }

  fetchSongList(String artist) async {
    movieListSink.add(ApiResponse.loading('Fetching Popular Songs'));
    try {
      List<Results> songs = await _movieRepository.fetchSongList(artist);
      List<SongViewModel> songsUI =
          songs.map((results) => SongViewModel(results)).toList();
      movieListSink.add(ApiResponse.completed(songsUI));
    } catch (e) {
      movieListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _movieListController?.close();
  }
}
