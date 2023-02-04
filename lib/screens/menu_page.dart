import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:horror_story/controllers/rating_controller.dart';
import 'package:horror_story/env.dart';
import 'package:horror_story/models/story_rating/app_rating_response.dart';
import 'package:horror_story/screens/app_stats_screen.dart';
import 'package:horror_story/utils/app_utills.dart';
import 'package:horror_story/utils/size_manager.dart';
import 'package:horror_story/widgets/rating_start.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  RatingController _ratingController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ratingController.getAppRating();
    _ratingController.setAnalytics("Menu Page");
    if (_ratingController.pageViewData == null) {
      _ratingController.setPageView(1, "MenuPage");
    } else {
      _ratingController.updatePageView(
          _ratingController.pageViewData, "MenuPage");
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width,
      height: deviceSize.height,
      padding: EdgeInsets.only(
        top: SizeManager.of(context).transformX(40),
        left: SizeManager.of(context).transformX(67),
        right: SizeManager.of(context).transformX(67),
      ),
      color: env.appTheme.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: SizeManager.of(context).transformX(40),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeManager.of(context).transformX(103)),
            child: SvgPicture.asset(
              env.svgLogoAsset,
              height: SizeManager.of(context).transformX(190),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: SizeManager.of(context).transformX(40),
            ),
          ),
          _buildItems([
            'About Us',
            'Settings',
            'Support',
            'Stats',
            'Contact',
          ]),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: SizeManager.of(context).transformX(40),
            ),
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingStar(
                    size: 18,
                    rating: _ratingController.getAppRatingCount(),
                    color: env.appTheme.starColor,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text("(${_ratingController.appRatingList.length})")
                ],
              )),
          SizedBox(
            height: SizeManager.of(context).transformX(8),
          ),
          Center(
            child: TextButton(
              child: Text(
                'RATE OUR APP',
                style: TextStyle(
                  color: env.appTheme.menuButtonFontColor,
                  fontFamily: 'Montserrat',
                  fontSize: SizeManager.of(context).transformX(24),
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: env.appTheme.menuButtonBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(
                  SizeManager.of(context).transformX(354),
                  SizeManager.of(context).transformX(77),
                ),
              ),
              autofocus: false,
              clipBehavior: Clip.none,
              onPressed: () {
                showModal(context,
                    title: "Rate the APP",
                    initialRating: getInitialRating(_ratingController.deviceId,
                        _ratingController.appRatingList.value),
                    isVertical: false, onPickFile: (rating) async {
                  print("$rating");
                  _ratingController.setAppRating(rating, onAppRating: () {
                    Get.back();
                  });
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: SizeManager.of(context).transformX(95),
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(bottom: SizeManager.of(context).transformX(80)),
            child: Text(
              'The copyright of this content belongs to the author or the provider, and any unauthorized use may be liable according to copyright laws.',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: SizeManager.of(context).transformX(24),
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  _buildItems(List<String> items) {
    return Center(
      child: Column(
        children: items
            .map(
              (e) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  onTap: () {
                    if (e.toString().toLowerCase() == "stats") {
                      Get.to(() => AppStatsScreen());
                    } else {
                      _launchURL(e);
                    }
                  },
                  child: Text(
                    e,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: SizeManager.of(context).transformX(44),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  _buildStar() {
    return Icon(
      Icons.star,
      size: 18,
      color: env.appTheme.starColor,
    );
  }

  _launchURL(String value) async {
    if (_ratingController.pageViewData == null) {
      _ratingController.setPageView(1, value);
    } else {
      _ratingController.updatePageView(_ratingController.pageViewData, value);
    }
    _ratingController.setAnalytics("$value Page");
    const url = 'https://www.goodnighthorror.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getInitialRating(RxString deviceId, List<dynamic> values) {
    for (int index = 0; index < values.length; index++) {
      AppRatingResponse value = values[index];
      if (value.userId.toString() == deviceId.value.toString()) {
        return double.parse(value.appRating.toString());
      }
    }

    return 1.0;
  }
}
