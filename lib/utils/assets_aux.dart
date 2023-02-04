import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:horror_story/models/story.dart';
import 'package:horror_story/models/story_model/storys.dart';
Future<Story> loadStoryFromAsset(String assetPath) async {
  String jsonString = await rootBundle.loadString(assetPath);
  var jsonData = jsonDecode(jsonString);
  Storys storys = Storys.fromJson(jsonData);

  return Story.fromJson(jsonData);
}

Future<List<Story>> loadStoryList(List<String> paths) async {
  List<Story> list = [];
  for (String assetPath in paths) {
    Story story = await loadStoryFromAsset(assetPath);
    list.add(story);
  }
  return list;
}
