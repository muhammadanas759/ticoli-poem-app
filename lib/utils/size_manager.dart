import 'package:flutter/material.dart';

class SizeManager {
  final double prototypeWidth = 750;
  final double prototypeHeight = 1334;

  final double deviceWidth;
  final double deviceHeight;

  SizeManager._(this.deviceWidth, this.deviceHeight);

  static SizeManager of(BuildContext context) {
    assert(context != null);
    var mediaQuery = MediaQuery.of(context);

    return SizeManager._(mediaQuery.size.width, mediaQuery.size.height);
  }

  double transformX(double pixels){
    var ratio = deviceWidth / prototypeWidth;
    return pixels * ratio;
  }

  double transformY(double pixels){
    var ratio = deviceHeight / prototypeHeight;
    return pixels * ratio;
  }
}
