import 'package:samplemusicapp/model/songs.dart';
import 'package:samplemusicapp/services/networking.dart';

class PlayListRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Results>> fetchSongList(String query) async {
    final response =
        await _helper.get("/search?types=${"artists"}&term=$query");
    return Songs.fromJson(response).results;
  }
}
