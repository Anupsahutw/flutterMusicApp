import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:samplemusicapp/commons/audioPlayer.dart';
import 'package:samplemusicapp/viewmodel/song_viewmodel.dart';

class HandleSongViewModel {
  Future<void> playSong(SongViewModel model, List<SongViewModel> songList,
      int previousPlayedAudioIndex) async {
    print(model.previewUrl);
    var playSongViewModel = SingletonAudioPlayer();
    AssetsAudioPlayer _assetsAudioPlayer;
    _assetsAudioPlayer = playSongViewModel.assetsAudioPlayer;
    if (model.isPlaying) {
      if (previousPlayedAudioIndex != null) {
        final alreadyPlayedAudio = AssetsAudioPlayer.withId(
            songList[previousPlayedAudioIndex].previewUrl);
        alreadyPlayedAudio.stop();
      }
      try {
        await _assetsAudioPlayer.open(
          Audio.network(model.previewUrl),
        );
      } catch (t) {
        //mp3 unreachable
      }
    } else {
      _assetsAudioPlayer.playOrPause();
    }
  }

  List<SongViewModel> handlePlaySong(int currentSongIndex,
      int previousPlayedAudioIndex, List<SongViewModel> songList) {
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
    return songList;
  }
}
