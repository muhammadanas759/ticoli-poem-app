import 'package:horror_story/models/reference_location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'background_transition.g.dart';

@JsonSerializable()
class BackgroundTransition {
  final String startColor;
  final String endColor;
  final int itemRefId;
  final ReferenceLocation location;
  final double duration;

  @JsonKey(ignore: true)
  double startPosition;

  @JsonKey(ignore: true)
  double durationInPixels;

  BackgroundTransition({
    this.startColor,
    this.endColor,
    this.itemRefId,
    this.location = ReferenceLocation.Top,
    this.duration = 0.2,
  });

  factory BackgroundTransition.fromJson(Map<String, dynamic> json) =>
      _$BackgroundTransitionFromJson(json);

  Map<String, dynamic> toJson() => _$BackgroundTransitionToJson(this);

  configure(double pos, double deviceHeight, double itemRefHeight) {
    switch (location) {
      case ReferenceLocation.Center:
        startPosition = pos - deviceHeight / 2 + itemRefHeight / 2;
        break;
      case ReferenceLocation.Bottom:
        startPosition = pos - deviceHeight + itemRefHeight;
        break;
      default:
        startPosition = pos;
        break;
    }
    durationInPixels = duration * deviceHeight;
    print('setStartPosition location=$location [$pos => $startPosition]');
  }
}
