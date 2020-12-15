import 'dart:async';
import 'package:samplemusicapp/model/songs.dart';
import 'package:samplemusicapp/repository/playlist_repository.dart';
import 'package:samplemusicapp/services/api_response.dart';
import 'package:samplemusicapp/services/network.dart';
import 'package:samplemusicapp/utilities/app_constants.dart';
import 'package:samplemusicapp/model/song_display_model.dart';

class SongBloc {
  PlayListRepository _playListRepository;

  StreamController _songListController;

  StreamSink<ApiResponse<List<SongDisplayModel>>> get songListSink =>
      _songListController.sink;

  Stream<ApiResponse<List<SongDisplayModel>>> get songListStream =>
      _songListController.stream;

  ApiBaseHelper _helper = ApiBaseHelper();

  SongBloc(String artist) {
    _songListController =
        StreamController<ApiResponse<List<SongDisplayModel>>>();
    _playListRepository = PlayListRepository(_helper);
    fetchSongList(artist);
  }

  fetchSongList(String artist) async {
    songListSink.add(ApiResponse.loading(AppConstants.fetchingPopularSongs));
    try {
      List<Results> songs = await _playListRepository.fetchSongList(artist);
      List<SongDisplayModel> songsUI =
          songs.map((results) => SongDisplayModel(results)).toList();
      if (songsUI.length == 0)
        songListSink.add(ApiResponse.emptyResult(AppConstants.noSongs));
      else
        songListSink.add(ApiResponse.completed(songsUI));
    } catch (e) {
      songListSink.add(ApiResponse.error(AppConstants.wentWrong));
      print(e);
    }
  }

  dispose() {
    _songListController?.close();
  }
}
