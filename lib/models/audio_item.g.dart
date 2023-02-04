// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioItem _$AudioItemFromJson(Map<String, dynamic> json) {
  return AudioItem(
    asset: json['asset'] as String,
    loop: json['loop'] as bool ?? true,
    startItemRefId: json['startItemRefId'] as int,
    endItemRefId: json['endItemRefId'] as int,
  );
}

Map<String, dynamic> _$AudioItemToJson(AudioItem instance) => <String, dynamic>{
      'asset': instance.asset,
      'loop': instance.loop,
      'startItemRefId': instance.startItemRefId,
      'endItemRefId': instance.endItemRefId,
    };
