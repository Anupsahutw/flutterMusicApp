import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:samplemusicapp/model/songs_play.dart';
import 'package:samplemusicapp/viewmodel/songviewmodel.dart';

class PlaySongViewModel {
//  String currentSong;
//
//  PlaySongViewModel(SongsPlay songsPlay) {
//    currentSong = songsPlay.currentSong;
//  }

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
      //previousSong = model.previewUrl;
      //model.setPlayedAudioValue(model.previewUrl);
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
}
