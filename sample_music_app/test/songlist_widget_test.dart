import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:samplemusicapp/model/songs.dart';
import 'package:samplemusicapp/view/song_list_widget.dart';
import 'package:samplemusicapp/model/song_display_model.dart';

void main() {
  MaterialApp _materialapp(Widget widget) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        children: <Widget>[
          widget,
        ],
      )),
    );
  }

  testWidgets('track name displayed test', (WidgetTester tester) async {
    provideMockedNetworkImages(() async {
      // Now we can pump NetworkImages without crashing our tests. Yay!
      MaterialApp app = _materialapp(SongListWidget(
        songList: [SongDisplayModel(Results(trackName: 'Jon_snow_track'))],
      ));
      await tester.pumpWidget(app);

      // Verify that our counter starts at 0.
      expect(find.text('Jon_snow_track'), findsOneWidget);
      // No crashes.
    });
  });
}
