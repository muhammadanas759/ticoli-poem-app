import 'package:flutter/material.dart';

class RatingStar extends StatefulWidget {
  RatingStar({Key key, this.rating, this.size, this.color}) : super(key: key);
  final double rating;
  final double size;
  final color;

  @override
  _RatingStarState createState() => _RatingStarState();
}

class _RatingStarState extends State<RatingStar> {
  Widget _start(int index) {
    bool halfStar = false;
    if ((widget.rating * 2) % 2 != 0) {
      if (index < widget.rating && index == widget.rating - .5) {
        halfStar = true;
      }
    }

    return Icon(
      halfStar ? Icons.star_half : Icons.star,
      color: index < widget.rating
          ? widget.color ?? Colors.white
          : Colors.grey[300].withOpacity(0.6),
      size: widget.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 5),
        duration: Duration(milliseconds: 0),
        builder: (context, value, child) {
          return Wrap(
              children:
                  Iterable.generate(value.toInt(), (index) => _start(index))
                      .toList());
        },
      ),
    );
  }
}
