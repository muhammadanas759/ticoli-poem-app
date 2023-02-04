// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) {
  return Story(
    storyId: json['storyId'] as String,
    coverTitleAsset: json['coverTitleAsset'] as String,
    coverImageAsset: json['coverImageAsset'] as String,
    paddingTop: (json['paddingTop'] as num)?.toDouble(),
    paddingBottom: (json['paddingBottom'] as num)?.toDouble(),
    fontFamily: json['fontFamily'] as String,
    fontSize: (json['fontSize'] as num)?.toDouble(),
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : StoryItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    backgroundTransitions: (json['backgroundTransitions'] as List)
        ?.map((e) => e == null
            ? null
            : BackgroundTransition.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    audioItems: (json['audioItems'] as List)
        ?.map((e) =>
            e == null ? null : AudioItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    title: json['title'] as String,
    homeCoverAsset: json['homeCoverAsset'] as String,
    thumbnailAsset: json['thumbnailAsset'] as String,
    catalogType:
        _$enumDecodeNullable(_$CatalogTypeEnumMap, json['catalogType']),
    duration: json['duration'] as int,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    assetPackageUrl: json['assetPackageUrl'] as String,
    localDir: json['localDir'] as String,
    zipFileName: json['zipFileName'] as String,
  );
}

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'storyId': instance.storyId,
      'coverTitleAsset': instance.coverTitleAsset,
      'coverImageAsset': instance.coverImageAsset,
      'paddingTop': instance.paddingTop,
      'paddingBottom': instance.paddingBottom,
      'fontFamily': instance.fontFamily,
      'fontSize': instance.fontSize,
      'items': instance.items,
      'audioItems': instance.audioItems,
      'backgroundTransitions': instance.backgroundTransitions,
      'title': instance.title,
      'homeCoverAsset': instance.homeCoverAsset,
      'thumbnailAsset': instance.thumbnailAsset,
      'duration': instance.duration,
      'date': instance.date?.toIso8601String(),
      'catalogType': _$CatalogTypeEnumMap[instance.catalogType],
      'zipFileName': instance.zipFileName,
      'assetPackageUrl': instance.assetPackageUrl,
      'localDir': instance.localDir,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$CatalogTypeEnumMap = {
  CatalogType.Ready: 'Ready',
  CatalogType.Locked: 'Locked',
  CatalogType.Future: 'Future',
  CatalogType.NotReady: 'Not Ready',
  CatalogType.EarlyPhase: 'early_phase',
};
