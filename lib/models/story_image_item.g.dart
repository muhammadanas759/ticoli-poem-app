// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_image_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryImageItem _$StoryImageItemFromJson(Map<String, dynamic> json) {
  return StoryImageItem(
    id: json['id'] as int,
    gap: (json['gap'] as num)?.toDouble(),
    asset: json['asset'] as String,
    playButton: json['play_button'] as bool,
    horizontalGap: (json['horizontalGap'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$StoryImageItemToJson(StoryImageItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gap': instance.gap,
      'asset': instance.asset,
      'horizontalGap': instance.horizontalGap,
      'play_button': instance.playButton,
    };
