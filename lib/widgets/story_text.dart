import 'package:flutter/material.dart';
import 'package:horror_story/utils/size_manager.dart';

class StoryText extends StatelessWidget {
  final String content;
  final double gap;
  final Color color;
  final TextAlign align;
  final String fontFamily;
  final double fontSize;
  final double width;
  final Key textKey;

  const StoryText({
    Key key,
    this.content,
    this.gap = 0.0,
    this.color = Colors.white,
    this.align,
    this.fontFamily,
    this.width = 360,
    this.fontSize = 36,
    this.textKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: gap,
      ),
      child: Center(
        child: Container(
          width: SizeManager.of(context).transformX(width),
          child: Text(
            content,
            key: textKey,
            textAlign: align ?? TextAlign.start,
            style: TextStyle(
              color: color,
              height: 1.5,
              fontFamily: fontFamily,
              fontSize: SizeManager.of(context).transformX(fontSize),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
