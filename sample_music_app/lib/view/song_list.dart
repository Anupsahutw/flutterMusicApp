import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samplemusicapp/viewmodel/songviewmodel.dart';

// ignore: must_be_immutable
class SongList extends StatelessWidget {
  final List<SongViewModel> songList;
  SongList({Key key, this.songList}) : super(key: key);
  //var playedAudio = "";

  Future<void> playSong(SongViewModel model) async {
    print(model.previewUrl);
    final assetsAudioPlayer = AssetsAudioPlayer.withId(model.previewUrl);
    // ignore: unrelated_type_equality_checks
    if (model.audioPlaying) {
      final alreadyPlayedAudio = AssetsAudioPlayer.withId(model.playedAudio);
      alreadyPlayedAudio.stop();
      //playedAudio = model.previewUrl;
      model.setPlayedAudioValue(model.previewUrl);

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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.black54,
        child: ListView.builder(
          itemCount: songList.length,
          itemBuilder: (context, index) {
            SongViewModel model = songList[index];
            return ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 44,
                  maxHeight: 44,
                ),
                child: Image.network(
                  '${model.artworkUrl100}',
                  fit: BoxFit.fill,
                ),
              ),
              title: Text(model.trackName),
              subtitle: Text(model.primaryGenreName),
              onTap: () => playSong(model),
            );
          },
        ),
      ),
    );
  }
}
