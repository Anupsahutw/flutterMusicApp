import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samplemusicapp/model/songs.dart';
import 'package:samplemusicapp/viewmodel/songviewmodel.dart';

class SongList extends StatelessWidget {
  final List<SongViewModel> songList;

  SongList({Key key, this.songList}) : super(key: key);

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
              title: Text(model.songName),
              subtitle: Text(model.primaryGenreName != null
                  ? model.primaryGenreName
                  : 'Unknown'),
              onTap: () => print(model.songName),
            );
          },
        ),
      ),
    );
  }
}
