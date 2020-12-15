import 'package:flutter_test/flutter_test.dart';
import 'package:samplemusicapp/model/song_display_model.dart';
import 'package:samplemusicapp/model/songs.dart';
import 'package:samplemusicapp/viewmodel/handle_song_list_viewmodel.dart';

void main() {
  HandleSongListViewModel handleSongListViewModel;
  List<SongDisplayModel> songList;
  setUp(() {
    handleSongListViewModel = HandleSongListViewModel();
    songList = [
      SongDisplayModel(
        Results(),
      ),
      SongDisplayModel(
        Results(),
      ),
    ];
  });

  test("is clicked song start play", () {
    handleSongListViewModel.handlePlaySong(1, null, songList);
    expect(songList[1].isPlaying, true);
  });

  test("is same clicked song pause", () {
    songList[1].setIsPlaying(true);
    handleSongListViewModel.handlePlaySong(1, 1, songList);
    expect(songList[1].isPlaying, false);
  });

  test("is previous song stopped", () {
    songList[0].setIsPlaying(true);
    handleSongListViewModel.handlePlaySong(1, 0, songList);
    expect(songList[0].isPlaying, false);
  });
}
