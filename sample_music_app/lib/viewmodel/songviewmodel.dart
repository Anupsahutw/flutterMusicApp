import 'package:samplemusicapp/utilities/app_constants.dart';
import 'package:samplemusicapp/model/songs.dart';

class SongViewModel {
  String _trackName;
  String _primaryGenreName;
  String _artworkUrl100;
  String _previewUrl;
  String _playedAudio;
  bool _isplaying;

  SongViewModel(Results results) {
    _trackName = results.trackName;
    _primaryGenreName = results.primaryGenreName;
    _artworkUrl100 = results.artworkUrl100;
    _previewUrl = results.previewUrl;
    _playedAudio = "";
    _isplaying = false;
  }

  String get trackName {
    return _trackName != null ? _trackName : AppConstants.unKnown;
  }

  String get primaryGenreName {
    return _primaryGenreName != null ? _primaryGenreName : AppConstants.unKnown;
  }

  String get artworkUrl100 {
    return _artworkUrl100 != null ? _artworkUrl100 : AppConstants.unKnown;
  }

  String get previewUrl {
    return _previewUrl != null ? _previewUrl : AppConstants.unKnown;
  }

  bool get audioPlaying {
    return _playedAudio != _previewUrl ? true : false;
  }

  void setPlayedAudioValue(String value) {
    _playedAudio = value;
  }

  String get playedAudio {
    return _playedAudio;
  }

  void setIsPlaying(bool value) {
    _isplaying = value;
  }

  bool get isPlaying {
    return _isplaying;
  }
}
