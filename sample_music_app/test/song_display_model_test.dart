import 'package:flutter_test/flutter_test.dart';
import 'package:samplemusicapp/model/songs.dart';
import 'package:samplemusicapp/model/song_display_model.dart';

void main() {
  setUp(() {});

  test("track name null exception", () {
    var track = 'Jon_snow_track';
    SongDisplayModel model = SongDisplayModel(Results(trackName: track));
    expect(model.trackName, track);

    SongDisplayModel model2 = SongDisplayModel(Results(trackName: null));
    expect(model2.trackName, 'UnKnown');
  });

  test("Artist Name null exception", () {
    var artistName = 'Jackson';
    SongDisplayModel model = SongDisplayModel(Results(artistName: artistName));
    expect(model.artistName, artistName);

    SongDisplayModel model2 = SongDisplayModel(Results(artistName: null));
    expect(model2.artistName, 'UnKnown');
  });

  test("artwork null exception", () {
    var artworkUrl =
        'https://is2-ssl.mzstatic.com/image/thumb/Music118/v4/24/46/97/24469731-f56f-29f6-67bd-53438f59ebcb/source/100x100bb.jpg';
    SongDisplayModel model =
        SongDisplayModel(Results(artworkUrl100: artworkUrl));
    expect(model.artworkUrl100, artworkUrl);

    SongDisplayModel model2 = SongDisplayModel(Results(artworkUrl100: null));
    expect(model2.artworkUrl100, 'UnKnown');
  });

  test("collection name null exception", () {
    var collectionName = 'B-Boy';
    SongDisplayModel model =
        SongDisplayModel(Results(collectionName: collectionName));
    expect(model.collectionName, collectionName);

    SongDisplayModel model2 = SongDisplayModel(Results(collectionName: null));
    expect(model2.collectionName, 'UnKnown');
  });

  test("previewUrl null exception", () {
    var previewUrl =
        'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview128/v4/fd/aa/20/fdaa201e-c18b-9c3d-fc47-145bb02500bd/mzaf_7872772912930380204.plus.aac.p.m4a';
    SongDisplayModel model = SongDisplayModel(Results(previewUrl: previewUrl));
    expect(model.previewUrl, previewUrl);

    SongDisplayModel model2 = SongDisplayModel(Results(previewUrl: null));
    expect(model2.previewUrl, 'UnKnown');
  });

  test("is Playing set to true", () {
    var isPlaying = true;
    SongDisplayModel model = SongDisplayModel(Results());
    model.setIsPlaying(isPlaying);
    expect(model.isPlaying, true);
  });
}
