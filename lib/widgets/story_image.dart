import 'package:flutter/material.dart';

class StoryImage extends StatelessWidget {
  final image;
  final double gap;
  final double horizontalGap;

  const StoryImage({
    Key key,
    this.image,
    this.gap = 0.0,
    this.horizontalGap = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: gap,
        left: horizontalGap,
        right: horizontalGap,
      ),
      child: image,
    );
  }
}
