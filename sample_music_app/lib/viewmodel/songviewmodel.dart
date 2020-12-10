import 'package:samplemusicapp/constants/app_constants.dart';
import 'package:samplemusicapp/model/songs.dart';

class SongViewModel {
  String _trackName;
  String _primaryGenreName;
  String _artworkUrl100;

  SongViewModel(Results results) {
    _trackName = results.trackName;
    _primaryGenreName = results.primaryGenreName;
    _artworkUrl100 = results.artworkUrl100;
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
}
