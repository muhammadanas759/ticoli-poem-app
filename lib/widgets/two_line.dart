import 'package:flutter/material.dart';
import 'package:horror_story/utils/size_manager.dart';
import 'package:horror_story/widgets/rating_start.dart';

class TwoLine extends StatelessWidget {
  final String first;
  final String second;
  final double width;
  final double fontSize;
  final Color firstColor;
  final Color secondColor;
  final hasRating;
  final rating;

  TwoLine(
      {Key key,
      this.first,
      this.second,
      this.width,
      this.fontSize,
      this.firstColor,
      this.secondColor,
      this.rating = 0.0,
      this.hasRating = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: SizeManager.of(context).transformX(width),
          child: Text(
            first,
            maxLines: 2,
            style: TextStyle(
              color: firstColor,
              fontFamily: 'Lato',
              fontSize: SizeManager.of(context).transformX(28),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        hasRating
            ? RatingStar(
                size: 24,
                rating: double.parse((rating ?? 0).toString()),
                color: secondColor,
              )
            : Text(
                second,
                style: TextStyle(
                  color: secondColor,
                  fontFamily: 'Lato',
                  fontSize: SizeManager.of(context).transformX(fontSize),
                  fontWeight: FontWeight.bold,
                ),
              ),
      ],
    );
  }
}
