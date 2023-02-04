import 'package:json_annotation/json_annotation.dart';

import 'story_item.dart';

part 'story_image_item.g.dart';

@JsonSerializable()
class StoryImageItem extends StoryItem {
  final String asset;
  final double horizontalGap;
  final bool playButton;

  StoryImageItem({
    int id,
    double gap,
    this.asset,
    this.playButton,
    this.horizontalGap,
  }) : super(
          id: id,
          gap: gap,
        );

  factory StoryImageItem.fromJson(Map<String, dynamic> json) =>
      _$StoryImageItemFromJson(json);

  Map<String, dynamic> toJson() => _$StoryImageItemToJson(this);
}
