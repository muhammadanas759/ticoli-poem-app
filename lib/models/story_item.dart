import 'package:horror_story/models/story_transition_image_item.dart';
import 'package:horror_story/models/story_video_item.dart';
import 'package:json_annotation/json_annotation.dart';

import 'story_image_item.dart';
import 'story_text_item.dart';

@JsonSerializable()
abstract class StoryItem {
  final int id;
  final double gap;
  final playButton;

  StoryItem({this.id, this.gap, this.playButton});

  factory StoryItem.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      return StoryTextItem.fromJson(json);
    } else if (json['video'] != null) {
      return StoryVideoItem.fromJson(json);
    } else if (json['asset'] != null) {
      return StoryImageItem.fromJson(json);
    } else {
      return TransitionStoryImageItem.fromJson(json);
    }
  }
}
