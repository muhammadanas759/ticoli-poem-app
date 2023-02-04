import 'package:flutter/material.dart';
import 'package:horror_story/env.dart';
import 'package:horror_story/utils/size_manager.dart';

class ShareWidget extends StatefulWidget {
  @override
  _ShareWidgetState createState() => _ShareWidgetState();
}

class _ShareWidgetState extends State<ShareWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: SizeManager.of(context).transformX(60),
        right: SizeManager.of(context).transformX(60),
      ),
      child: Column(
        children: [
          Divider(),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "Do you have some\nhorror tale to tell us?",
                  style: TextStyle(
                    color: env.appTheme.headerTitleColor,
                    fontFamily: 'Lato-Bold',
                    fontSize: SizeManager.of(context).transformX(42),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28)),
                child: Text(
                  "SHARE",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontSize: SizeManager.of(context).transformX(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Share your horrors tales, we would love to\nturn into a Good Night"
            " Horror tales.",
            style: TextStyle(
              color: env.appTheme.headerSubtitleColor,
              fontFamily: 'Lato',
              fontSize: SizeManager.of(context).transformX(34),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Divider(),
          SizedBox(
            height: 14,
          ),
        ],
      ),
    );
  }
}
