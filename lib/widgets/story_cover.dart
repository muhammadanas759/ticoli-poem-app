import 'package:flutter/material.dart';
import 'package:horror_story/utils/size_manager.dart';
import 'package:lottie/lottie.dart';

class StoryCover extends StatelessWidget {
  final Widget image;
  final Widget title;
  final bool isLoading;
  final Function onClose;
  final story;

  const StoryCover(
    this.story, {
    Key key,
    this.image,
    this.title,
    this.isLoading,
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        image,
        Positioned(
          top: SizeManager.of(context).transformX(80),
          right: SizeManager.of(context).transformY(40),
          child: Container(
            padding: const EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              color: getColor(story),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(
                minWidth: SizeManager.of(context).transformX(64),
                minHeight: SizeManager.of(context).transformY(64),
              ),
              icon: getIcon(story, context),
              onPressed: onClose,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Lottie.asset(
            'assets/animated/storycover-loading.json',
            width: deviceSize.width,
            repeat: false,
          ),
        ),
        Visibility(
          visible: !isLoading,
          child: Positioned(
            bottom: SizeManager.of(context).transformX(40),
            child: Container(
              child: getDownArrow(story, context),
            ),
          ),
        ),
        title != null
            ? Positioned(
                top: deviceSize.height / 4,
                child: title,
              )
            : Container(),
      ],
    );
  }

  getIcon(story, BuildContext context) {
    if (story.storyId == "kid_story_001") {
      return Image.asset(
        "assets/icons/close_story_one.png",
        height: SizeManager.of(context).transformX(48),
      );
    }
    if (story.storyId == "kid_story_002") {
      return Image.asset(
        "assets/icons/img_story_two_close.png",
        height: SizeManager.of(context).transformX(48),
      );
    }
    if (story.storyId == "kid_story_003") {
      return Image.asset(
        "assets/icons/close_story_three.png",
        height: SizeManager.of(context).transformX(68),
      );
    }
    return Icon(
      Icons.close,
      color: Colors.white,
      size: SizeManager.of(context).transformX(64),
    );
  }

  getColor(story) {
    if (story.storyId == "kid_story_003" ||
        story.storyId == "kid_story_002" ||
        story.storyId == "kid_story_001") {
      return Colors.transparent;
    }
    return Colors.redAccent.withOpacity(0.5);
  }

  getDownArrow(story, BuildContext context) {
    if (story.storyId == "kid_story_001") {
      return Image.asset(
        "assets/icons/arrow_down_story_one.png",
        height: SizeManager.of(context).transformX(68),
      );
    }
    if (story.storyId == "kid_story_002") {
      return Image.asset(
        "assets/icons/img_arrow_down.png",
        height: SizeManager.of(context).transformX(68),
      );
    }
    if (story.storyId == "kid_story_003") {
      return Image.asset(
        "assets/icons/arrow_down_story_three.png",
        height: SizeManager.of(context).transformX(68),
      );
    }
    return Lottie.asset(
      'assets/animated/arrow-down.json',
      width: SizeManager.of(context).transformX(100),
    );
  }
}
