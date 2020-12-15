import 'package:samplemusicapp/commons/audio_player.dart';
import 'package:samplemusicapp/commons/play_pause_song.dart';
import 'package:samplemusicapp/model/song_display_model.dart';

class HandleSongListViewModel {
  List<SongDisplayModel> handlePlaySong(int currentSongIndex,
      int previousPlayedAudioIndex, List<SongDisplayModel> songList) {
    if (previousPlayedAudioIndex == currentSongIndex) {
      songList[currentSongIndex]
          .setIsPlaying(!songList[currentSongIndex].isPlaying);
    } else {
      if (previousPlayedAudioIndex != null) {
        songList[previousPlayedAudioIndex].setIsPlaying(false);
      }
      songList[currentSongIndex]
          .setIsPlaying(!songList[currentSongIndex].isPlaying);
    }
    var handleSongViewModel = PlayPauseSong(SingletonAudioPlayer());
    handleSongViewModel.playSong(
        songList[currentSongIndex], songList, previousPlayedAudioIndex);
    return songList;
  }
}
