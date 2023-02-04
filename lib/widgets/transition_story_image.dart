import 'package:flutter/material.dart';

class TransitionStoryImage extends StatelessWidget {
  final Image firstImage;
  final Image secondImage;
  final double position;

  final double gap;
  final double horizontalGap;

  const TransitionStoryImage({
    Key key,
    this.firstImage,
    this.secondImage,
    this.position,
    this.gap,
    this.horizontalGap,
  })  : assert(
            position >= 0 && position <= 1, 'Value should be between 0 and 1'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: gap,
        left: horizontalGap,
        right: horizontalGap,
      ),
      child: Stack(
        children: [
          Positioned(
            child: Opacity(
              opacity: 1 - position,
              child: firstImage,
            ),
          ),
          Positioned(
            child: Opacity(
              opacity: position,
              child: secondImage,
            ),
          )
        ],
      ),
    );
  }
}
