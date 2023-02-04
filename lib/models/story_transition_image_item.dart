import 'package:json_annotation/json_annotation.dart';

import 'story_item.dart';

part 'story_transition_image_item.g.dart';

@JsonSerializable()
class TransitionStoryImageItem extends StoryItem {
  final String initialAsset;
  final String finalAsset;
  final double horizontalGap;
  final double duration;

  @JsonKey(ignore: true)
  double startPosition;

  @JsonKey(ignore: true)
  double durationInPixels;

  @JsonKey(ignore: true)
  double position = 0.0;

  TransitionStoryImageItem({
    int id,
    double gap,
    this.initialAsset,
    this.finalAsset,
    this.horizontalGap,
    this.duration,
  }) : super(
          id: id,
          gap: gap,
        );

  factory TransitionStoryImageItem.fromJson(Map<String, dynamic> json) =>
      _$TransitionStoryImageItemFromJson(json);

  Map<String, dynamic> toJson() => _$TransitionStoryImageItemToJson(this);
}
