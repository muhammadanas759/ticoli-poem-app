// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_video_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryVideoItem _$StoryVideoItemFromJson(Map<String, dynamic> json) {
  return StoryVideoItem(
    id: json['id'] as int,
    gap: (json['gap'] as num)?.toDouble(),
    asset: json['asset'] as String,
    horizontalGap: (json['horizontalGap'] as num)?.toDouble(),
    video: json['video'] as bool,
  );
}

Map<String, dynamic> _$StoryVideoItemToJson(StoryVideoItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gap': instance.gap,
      'asset': instance.asset,
      'horizontalGap': instance.horizontalGap,
      'video': instance.video,
    };
