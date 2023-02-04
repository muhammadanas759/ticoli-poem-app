// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background_transition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackgroundTransition _$BackgroundTransitionFromJson(Map<String, dynamic> json) {
  return BackgroundTransition(
    startColor: json['startColor'] as String,
    endColor: json['endColor'] as String,
    itemRefId: json['itemRefId'] as int,
    location:
        _$enumDecodeNullable(_$ReferenceLocationEnumMap, json['location']),
    duration: (json['duration'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$BackgroundTransitionToJson(
        BackgroundTransition instance) =>
    <String, dynamic>{
      'startColor': instance.startColor,
      'endColor': instance.endColor,
      'itemRefId': instance.itemRefId,
      'location': _$ReferenceLocationEnumMap[instance.location],
      'duration': instance.duration,
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

const _$ReferenceLocationEnumMap = {
  ReferenceLocation.Top: 'Top',
  ReferenceLocation.Center: 'Center',
  ReferenceLocation.Bottom: 'Bottom',
};
