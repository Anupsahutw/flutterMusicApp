import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:samplemusicapp/viewmodel/songviewmodel.dart';

class PlaySongViewModel {
  Future<void> playSong(SongViewModel model, List<SongViewModel> songList,
      int previousPlayedAudioIndex) async {
    print(model.previewUrl);
    final assetsAudioPlayer = AssetsAudioPlayer.withId(model.previewUrl);
    if (model.isPlaying) {
      if (previousPlayedAudioIndex != null) {
        final alreadyPlayedAudio = AssetsAudioPlayer.withId(
            songList[previousPlayedAudioIndex].previewUrl);
        alreadyPlayedAudio.stop();
      }
      try {
        await assetsAudioPlayer.open(
          Audio.network(model.previewUrl),
        );
      } catch (t) {
        //mp3 unreachable
      }
    } else {
      assetsAudioPlayer.playOrPause();
    }
  }

  void handleSongPlay(int currentSongIndex, int previousPlayedAudioIndex,
      List<SongViewModel> songList) {
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
    playSong(songList[currentSongIndex], songList, previousPlayedAudioIndex);
  }
}
