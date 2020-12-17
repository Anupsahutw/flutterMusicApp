import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:samplemusicapp/commons/audio_player.dart';
import 'package:samplemusicapp/model/song_display_model.dart';

class PlayPauseSong {
  SingletonAudioPlayer _singletonAudioPlayer;
  PlayPauseSong(this._singletonAudioPlayer);

  Future<void> playSong(SongDisplayModel model, List<SongDisplayModel> songList,
      int previousPlayedAudioIndex) async {
    print(model.previewUrl);
    AssetsAudioPlayer _assetsAudioPlayer;
    _assetsAudioPlayer = _singletonAudioPlayer.assetsAudioPlayer;
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
}
