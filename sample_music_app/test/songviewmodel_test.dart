import 'package:flutter_test/flutter_test.dart';
import 'package:samplemusicapp/model/songs.dart';
import 'package:samplemusicapp/viewmodel/song_viewmodel.dart';

void main() {
  setUp(() {});

  test("track name null exception", () {
    var track = 'Jon_snow_track';
    SongViewModel model = SongViewModel(Results(trackName: track));
    expect(model.trackName, track);

    SongViewModel model2 = SongViewModel(Results(trackName: null));
    expect(model2.trackName, 'UnKnown');
  });

  test("primary Genre Name null exception", () {
    var genreName = 'bollywood';
    SongViewModel model = SongViewModel(Results(primaryGenreName: genreName));
    expect(model.artistName, genreName);

    SongViewModel model2 = SongViewModel(Results(primaryGenreName: null));
    expect(model2.artistName, 'UnKnown');
  });

  test("artwork null exception", () {
    var artworkUrl =
        'https://is2-ssl.mzstatic.com/image/thumb/Music118/v4/24/46/97/24469731-f56f-29f6-67bd-53438f59ebcb/source/100x100bb.jpg';
    SongViewModel model = SongViewModel(Results(artworkUrl100: artworkUrl));
    expect(model.artworkUrl100, artworkUrl);

    SongViewModel model2 = SongViewModel(Results(artworkUrl100: null));
    expect(model2.artworkUrl100, 'UnKnown');
  });
}
