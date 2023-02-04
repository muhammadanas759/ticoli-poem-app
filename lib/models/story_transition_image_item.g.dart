// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_transition_image_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransitionStoryImageItem _$TransitionStoryImageItemFromJson(
    Map<String, dynamic> json) {
  return TransitionStoryImageItem(
    id: json['id'] as int,
    gap: (json['gap'] as num)?.toDouble(),
    initialAsset: json['initialAsset'] as String,
    finalAsset: json['finalAsset'] as String,
    horizontalGap: (json['horizontalGap'] as num)?.toDouble(),
    duration: (json['duration'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$TransitionStoryImageItemToJson(
        TransitionStoryImageItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gap': instance.gap,
      'initialAsset': instance.initialAsset,
      'finalAsset': instance.finalAsset,
      'horizontalGap': instance.horizontalGap,
      'duration': instance.duration,
    };
