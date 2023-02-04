// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_text_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryTextItem _$StoryTextItemFromJson(Map<String, dynamic> json) {
  return StoryTextItem(
    id: json['id'] as int,
    gap: (json['gap'] as num)?.toDouble(),
    content: json['content'] as String,
    color: json['color'] as String,
    width: (json['width'] as num)?.toDouble(),
    align: _$enumDecodeNullable(_$TextAlignEnumMap, json['align']),
  );
}

Map<String, dynamic> _$StoryTextItemToJson(StoryTextItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gap': instance.gap,
      'content': instance.content,
      'color': instance.color,
      'width': instance.width,
      'align': _$TextAlignEnumMap[instance.align],
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

const _$TextAlignEnumMap = {
  TextAlign.left: 'left',
  TextAlign.right: 'right',
  TextAlign.center: 'center',
  TextAlign.justify: 'justify',
  TextAlign.start: 'start',
  TextAlign.end: 'end',
};
