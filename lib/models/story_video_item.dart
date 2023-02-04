import 'package:json_annotation/json_annotation.dart';

import 'story_item.dart';

part 'story_video_item.g.dart';

@JsonSerializable()
class StoryVideoItem extends StoryItem {
  final String asset;
  final double horizontalGap;
  final bool video;

  @JsonKey(ignore: true)
  double startPosition;

  StoryVideoItem({
    int id,
    double gap,
    this.asset,
    this.horizontalGap,
    this.video,
  }) : super(
          id: id,
          gap: gap,
        );

  factory StoryVideoItem.fromJson(Map<String, dynamic> json) =>
      _$StoryVideoItemFromJson(json);

  Map<String, dynamic> toJson() => _$StoryVideoItemToJson(this);
}
