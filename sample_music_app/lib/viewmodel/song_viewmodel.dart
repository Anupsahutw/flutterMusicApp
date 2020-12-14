import 'package:samplemusicapp/utilities/app_constants.dart';
import 'package:samplemusicapp/model/songs.dart';

class SongViewModel {
  String _trackName;
  String _artistName;
  String _artworkUrl100;
  String _previewUrl;
  //String _playedAudio;
  bool _isplaying;
  String _collectionName;

  SongViewModel(Results results) {
    _trackName = results.trackName;
    _artistName = results.artistName;
    _artworkUrl100 = results.artworkUrl100;
    _previewUrl = results.previewUrl;
    _collectionName = results.collectionName;
    _isplaying = false;
  }

  String get trackName {
    return _trackName != null ? _trackName : AppConstants.unKnown;
  }

  String get artistName {
    return _artistName != null ? _artistName : AppConstants.unKnown;
  }

  String get collectionName {
    return _collectionName != null ? _collectionName : AppConstants.unKnown;
  }

  String get artworkUrl100 {
    return _artworkUrl100 != null ? _artworkUrl100 : AppConstants.unKnown;
  }

  String get previewUrl {
    return _previewUrl != null ? _previewUrl : AppConstants.unKnown;
  }

  void setIsPlaying(bool value) {
    _isplaying = value;
  }

  bool get isPlaying {
    return _isplaying;
  }
}
