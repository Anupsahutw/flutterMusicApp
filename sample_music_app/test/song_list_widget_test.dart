// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';

import 'package:samplemusicapp/main.dart';
import 'package:samplemusicapp/model/songs.dart';
import 'package:samplemusicapp/view/song_list.dart';
import 'package:samplemusicapp/viewmodel/songviewmodel.dart';

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

  testWidgets('my image test', (WidgetTester tester) async {
    provideMockedNetworkImages(() async {
      // Now we can pump NetworkImages without crashing our tests. Yay!
      MaterialApp app = _materialapp(SongList(
        songList: [SongViewModel(Results(trackName: 'anup_track'))],
      ));
      await tester.pumpWidget(app);

      // Verify that our counter starts at 0.
      expect(find.text('anup_track'), findsOneWidget);
      // No crashes.
    });
  });
}
