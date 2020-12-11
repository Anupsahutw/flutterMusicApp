import 'package:samplemusicapp/utilities/app_constants.dart';
import 'package:samplemusicapp/model/songs.dart';

class SongViewModel {
  String _trackName;
  String _primaryGenreName;
  String _artworkUrl100;
  String _previewUrl;
  String _playedAudio;

  SongViewModel(Results results) {
    _trackName = results.trackName;
    _primaryGenreName = results.primaryGenreName;
    _artworkUrl100 = results.artworkUrl100;
    _previewUrl = results.previewUrl;
    _playedAudio = "";
  }

  String get trackName {
    return _trackName != null ? _trackName : TextConstants.unKnown;
  }

  String get primaryGenreName {
    return _primaryGenreName != null
        ? _primaryGenreName
        : TextConstants.unKnown;
  }

  String get artworkUrl100 {
    return _artworkUrl100 != null ? _artworkUrl100 : TextConstants.unKnown;
  }

  String get previewUrl {
    return _previewUrl != null ? _previewUrl : TextConstants.unKnown;
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
}
