import 'package:flutter/material.dart';
import 'package:horror_story/models/story_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'story_text_item.g.dart';

@JsonSerializable()
class StoryTextItem extends StoryItem {
  final String content;
  final String color;
  final double width;
  final TextAlign align;

  StoryTextItem({
    int id,
    double gap,
    this.content,
    this.color,
    this.width,
    this.align,
  }) : super(
          id: id,
          gap: gap,
        );

  factory StoryTextItem.fromJson(Map<String, dynamic> json) =>
      _$StoryTextItemFromJson(json);

  Map<String, dynamic> toJson() => _$StoryTextItemToJson(this);
}
