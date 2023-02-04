import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:horror_story/utils/story_prefs.dart';

var appTypes;

void showModal(context, {title, onPickFile, isVertical, initialRating}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2.5,
          color: Colors.black,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Container(
                    height: 4,
                    width: 50,
                    color: Colors.grey.shade200,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  title ?? "How was the tale?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                RatingBar.builder(
                  initialRating: initialRating,
                  minRating: 1,
                  direction: isVertical ? Axis.vertical : Axis.horizontal,
                  allowHalfRating: false,
                  unratedColor: Colors.amber.withAlpha(50),
                  itemCount: 5,
                  itemSize: 50.0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: onPickFile,
                  updateOnDrag: true,
                )
              ],
            ),
          ),
        );
      });
}

List<StoryPrefs> list = [
  StoryPrefs(
      id: "kid_story_001", color: Color(0xff038BD9), ageLimit: "0 - 3 YEARS"),
  StoryPrefs(
      id: "kid_story_002", color: Color(0xff000000), ageLimit: "4 - 6 YEARS"),
  StoryPrefs(
      id: "kid_story_003", color: Color(0xffC0AC5F), ageLimit: "4 - 6 YEARS"),
  StoryPrefs(
      id: "kid_story_007", color: Color(0xffD2E28B), ageLimit: "2 - 3 YEARS"),
];

getAgeLimit(String id) {
  for (int index = 0; index < list.length; index++) {
    if (list[index].id == id) {
      return list[index].ageLimit;
    }
  }
}

getColor(String id) {
  for (int index = 0; index < list.length; index++) {
    if (list[index].id == id) {
      Color color = list[index].color;
      return color;
    }
  }
}
