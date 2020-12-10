import 'package:samplemusicapp/model/songs.dart';

class SongViewModel {
  String _trackName;

  SongViewModel(Results results) {
    _trackName = results.trackName;
  }

  String get songName {
    return _trackName != null ? _trackName : 'UnKnown';
  }

  String get primaryGenreName {
    return 'test';
  }

  String get artworkUrl100 {
    return 'https://is4-ssl.mzstatic.com/image/thumb/Video/v4/a5/65/f6/a565f6d1-e5ce-11a1-b216-68cade0673d4/source/100x100bb.jpg';
  }
}
