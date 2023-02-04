import 'package:json_annotation/json_annotation.dart';

part 'audio_item.g.dart';

@JsonSerializable()
class AudioItem {
  final String asset;

  @JsonKey(defaultValue: true)
  final bool loop;

  // reference items to the start and end position
  final int startItemRefId;
  // TODO: Shall we use a duration variable instead of a reference to the end?
  // Maybe some double value relative to the device's height
  final int endItemRefId;

  @JsonKey(ignore: true)
  double startPosition;

  @JsonKey(ignore: true)
  double endPosition;

  AudioItem({
    this.asset,
    this.loop = true,
    this.startItemRefId,
    this.endItemRefId,
  });

  factory AudioItem.fromJson(Map<String, dynamic> json) =>
      _$AudioItemFromJson(json);

  Map<String, dynamic> toJson() => _$AudioItemToJson(this);
}
