// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:samplemusicapp/main.dart';
import 'package:samplemusicapp/model/songs.dart';
import 'package:samplemusicapp/repository/playlist_repository.dart';
import 'package:samplemusicapp/viewmodel/songviewmodel.dart';

void main() {
  PlayListRepository repo;

  setUp(() {});

  test("song name null excpetion", () {
    SongViewModel model = SongViewModel(Results(trackName: 'anup'));
    expect(model.songName, 'anup');

    SongViewModel model2 = SongViewModel(Results(trackName: null));
    expect(model2.songName, 'UnKnown');
  });
}
