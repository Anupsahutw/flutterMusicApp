import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:samplemusicapp/model/songs.dart';
import 'package:samplemusicapp/repository/playlist_repository.dart';
import 'package:samplemusicapp/services/network.dart';

void main() {
  PlayListRepository repo;
  ApiBaseHelper _helper;

  setUp(() {
    _helper = MockApiBaseHelper();
    repo = PlayListRepository(_helper);
  });

  test("response null exception", () async {
    when(_helper.get('/search?types=${"artists"}&term=*'))
        .thenAnswer((realInvocation) => Future<dynamic>.value(response));
    var expectedResults = List<Results>();
    var actual = await repo.fetchSongList("*");
    expectLater(actual.length, expectedResults.length);
  });
}

class MockApiBaseHelper extends Mock implements ApiBaseHelper {
  MockApiBaseHelper();
}

Map<String, dynamic> response = <String, dynamic>{
  "resultCount": 50,
  "results": []
};
