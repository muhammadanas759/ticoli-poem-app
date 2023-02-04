import 'package:flutter/material.dart';
import 'package:horror_story/utils/size_manager.dart';

class Header extends StatelessWidget {
  final String subtitle;
  final String title;
  final Color titleColor;
  final Color subtitleColor;

  const Header({
    Key key,
    this.subtitle,
    this.title,
    this.titleColor,
    this.subtitleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: SizeManager.of(context).transformX(90),
        bottom: SizeManager.of(context).transformX(30),
        left: SizeManager.of(context).transformX(60),
        right: SizeManager.of(context).transformX(60),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.subtitle,
            style: TextStyle(
              color: subtitleColor,
              fontFamily: 'Lato',
              fontSize: SizeManager.of(context).transformX(30),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: SizeManager.of(context).transformX(24),
          ),
          Text(
            this.title,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: titleColor,
              fontFamily: 'Lato',
              fontSize: SizeManager.of(context).transformX(60),
              fontWeight: FontWeight.w900,
            ),
          )
        ],
      ),
    );
  }
}
