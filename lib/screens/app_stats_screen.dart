import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horror_story/controllers/rating_controller.dart';
import 'package:horror_story/models/most_visited/most_visited_response.dart';
import 'package:horror_story/models/page_view_labels.dart';
import 'package:horror_story/models/page_views.dart';
import 'package:horror_story/models/screen_time_model.dart';
import 'package:horror_story/models/story_rating/story_rating_response.dart';

class AppStatsScreen extends StatefulWidget {
  AppStatsScreen({Key key}) : super(key: key);

  @override
  _AppStatsScreenState createState() => _AppStatsScreenState();
}

class _AppStatsScreenState extends State<AppStatsScreen> {
  RatingController _ratingController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ratingController.getScreenTimeData(loop: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stats"),
        backgroundColor: Colors.purple, // status bar color
        brightness: Brightness.light,
      ),
      body: Obx(() => ListView(
            children: [
              screenWidget(
                  label: "Average Time Using APP",
                  child: Text(
                    "${getTime(_ratingController.screenTime.value)}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  )),
              screenWidget(
                  label: "Most Visited To Least Visited Tales",
                  child: getTaleList()),
              screenWidget(
                  label: "Story Drop",
                  child: getDropList(_ratingController.ratingList.value)),
              screenWidget(
                  label: "Audio/Animation Played",
                  child: getAnimationList(_ratingController.ratingList.value)),
              screenWidget(
                  label: "Page Views",
                  child: getPageViewsData(_ratingController.pageViews.value)),
            ],
          )),
    );
  }

  screenWidget({label, child}) {
    return Column(
      children: [
        Container(
          width: Get.width,
          margin: EdgeInsets.only(left: 24, top: 18),
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 6,
                    spreadRadius: 4,
                    offset: Offset(3, 3),
                    color: Colors.black.withOpacity(0.5))
              ]),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(left: 24, top: 7, right: 24),
          child: child,
        )
      ],
    );
  }

  getTime(List<dynamic> value) {
    int count = 0;
    for (int index = 0; index < value.length; index++) {
      ScreenTimeModel model = value[index];
      int time = int.parse(model.time);
      count = count + time;
    }
    var countResult = count ~/ 3;
    var hoursResult = countResult ~/ 3600;
    var minuteResult = (countResult - (hoursResult * 3600)) ~/ 60;
    var secondsResult =
        countResult - ((minuteResult * 60) + (hoursResult * 3600));
    String time = "";
    String hours = hoursResult.toString().padLeft(2, "0");
    String minutes = minuteResult.toString().padLeft(2, "0");
    String seconds = secondsResult.toString().padLeft(2, "0");
    if (hours == "0" && minutes == "0") {
      return "Second: $seconds";
    }
    if (hours == "0") {
      return "Minutes: $minutes,Second: $seconds";
    }

    return "Hours: $hours, Minutes: $minutes, Second: $seconds";
  }

  getTaleList() {
    return Column(
      children: [
        for (int index = 0;
            index < _ratingController.mostVisitedStories.value.length;
            index++)
          storyItem(_ratingController.mostVisitedStories.value, index),
      ],
    );
  }

  storyItem(List<dynamic> value, int index) {
    value.sort((b, a) => a.totalVisits.compareTo(b.totalVisits));
    MostVisitedResponse data = value[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${data.storyName}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
        Spacer(),
        Text(
          "${data.totalVisits}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
        SizedBox(
          width: 12,
        )
      ],
    );
  }

  getDropList(List<dynamic> value) {
    List<StoryRatingResponse> list = getList(value);
    return Column(
      children: [
        for (int index = 0; index < list.length; index++) dropItem(list, index),
      ],
    );
  }

  getAnimationList(List<dynamic> value) {
    List<StoryRatingResponse> list = animationList(value);
    return Column(
      children: [
        for (int index = 0; index < list.length; index++)
          animationItem(list, index),
      ],
    );
  }

  List<StoryRatingResponse> getList(List<dynamic> value) {
    List<StoryRatingResponse> dropList = [];
    for (int index = 0; index < value.length; index++) {
      StoryRatingResponse model = value[index];
      bool exist = isExist(model, dropList);
      if (!exist) {
        var drops = getDropCount(model.storyId, value);
        model.dropPercent = drops;
        dropList.add(model);
      }
    }

    return dropList;
  }

  List<StoryRatingResponse> animationList(List<dynamic> value) {
    List<StoryRatingResponse> dropList = [];
    for (int index = 0; index < value.length; index++) {
      StoryRatingResponse model = value[index];
      bool exist = isExist(model, dropList);
      if (!exist) {
        var drops = getAnimationCount(model.storyId, value);
        model.audioPlayed = drops;
        if (drops != "0") {
          dropList.add(model);
        }
      }
    }

    return dropList;
  }

  bool isExist(StoryRatingResponse model, List value) {
    for (int index = 0; index < value.length; index++) {
      StoryRatingResponse modelx = value[index];
      if (model.storyId == modelx.storyId) {
        return true;
      }
    }
    return false;
  }

  getDropCount(String storyId, List<dynamic> value) {
    int drop = 0;
    int count = 0;
    for (int index = 0; index < value.length; index++) {
      StoryRatingResponse modelx = value[index];
      if (storyId == modelx.storyId) {
        int drp = int.parse((modelx.dropPercent ?? 0).toString());
        drop = drop + drp;
        count = count + 1;
      }
    }
    if (count == 0) {
      count = 1;
    }
    var result = drop ~/ count;
    return result.toString();
  }

  getAnimationCount(String storyId, List<dynamic> value) {
    int drop = 0;
    int count = 0;
    for (int index = 0; index < value.length; index++) {
      StoryRatingResponse modelx = value[index];
      if (storyId == modelx.storyId) {
        int drp = int.parse((modelx.audioPlayed ?? 0).toString());
        drop = drop + drp;
        count = count + 1;
      }
    }
    if (count == 0) {
      count = 1;
    }
    var result = drop ~/ count;
    return result.toString();
  }

  dropItem(List<StoryRatingResponse> list, int index) {
    list.sort((b, a) => a.dropPercent.compareTo(b.dropPercent));
    StoryRatingResponse data = list[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${data.storyName}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
        Spacer(),
        Text(
          "${data.dropPercent}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
        SizedBox(
          width: 12,
        )
      ],
    );
  }

  animationItem(List<StoryRatingResponse> list, int index) {
    list.sort((b, a) => a.audioPlayed.compareTo(b.audioPlayed));
    StoryRatingResponse data = list[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${data.storyName}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
        Spacer(),
        Text(
          "${data.audioPlayed}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
        SizedBox(
          width: 12,
        )
      ],
    );
  }

  getPageViewsData(List<dynamic> value) {
    List<PageViewsLabel> _pageViews = getPageViews(value);

    return Column(
      children: [
        for (int index = 0; index < _pageViews.length; index++)
          pageViewsItem(_pageViews, index)
      ],
    );
  }

  List<PageViewsLabel> getPageViews(List<dynamic> value) {
    List<PageViews> newList = [];
    var pageExist = isPageExist(value);

    return pageExist;
  }

  isPageExist(List<PageViews> newList) {
    List<PageViewsLabel> listLabels = [];
    List<PageViewsLabel> crackList = [];
    int aboutUs = 0;
    int cataLogPage = 0;
    int contact = 0;
    int homePage = 0;
    int menuPage = 0;
    int settings = 0;
    int support = 0;
    int aboutUsVisit = 0;
    int cataLogPageVisit = 0;
    int contactVisit = 0;
    int homePageVisit = 0;
    int menuPageVisit = 0;
    int settingsVisit = 0;
    int supportVisit = 0;

    for (int index = 0; index < newList.length; index++) {
      PageViews modelx = newList[index];
      int aboutUsCon = int.parse((modelx.about ?? 0).toString());
      int cataLogPageCon = int.parse((modelx.cataLogPage ?? 0).toString());
      int contactCon = int.parse((modelx.contact ?? 0).toString());
      int homePageCon = int.parse((modelx.homePage ?? 0).toString());
      int menuPageCon = int.parse((modelx.menuPage ?? 0).toString());
      int settingsCon = int.parse((modelx.settings ?? 0).toString());
      int supportCon = int.parse((modelx.support ?? 0).toString());
      aboutUs = aboutUs + aboutUsCon;
      cataLogPage = cataLogPage + cataLogPageCon;
      homePage = homePage + homePageCon;
      contact = contact + contactCon;
      menuPage = menuPage + menuPageCon;
      settings = settings + settingsCon;
      support = support + supportCon;
      if (modelx.about != null) {
        aboutUsVisit = aboutUsVisit + 1;
      }
      if (modelx.cataLogPage != null) {
        cataLogPageVisit = cataLogPageVisit + 1;
      }
      if (modelx.homePage != null) {
        homePageVisit = homePageVisit + 1;
      }
      if (modelx.contact != null) {
        contactVisit = contactVisit + 1;
      }
      if (modelx.menuPage != null) {
        menuPageVisit = menuPageVisit + 1;
      }
      if (modelx.settings != null) {
        settingsVisit = settingsVisit + 1;
      }
      if (modelx.support != null) {
        support = support + 1;
      }

      PageViewsLabel pageModel = PageViewsLabel(
        about: "About Us",
        aboutCount: aboutUs,
        cataLogPage: "Catalog Page",
        cataLogPageCount: cataLogPage,
        contact: "Contact",
        contactCount: contact,
        homePage: "Home page",
        homePageCount: homePage,
        menuPage: "Menu Page",
        menuPageCount: menuPage,
        settings: "Settings",
        settingsCount: settings,
        support: "Support",
        supportCount: support,
      );
      listLabels.add(pageModel);
    }
    if (listLabels.isNotEmpty) {
      PageViewsLabel lastObj = listLabels.last;
      int aboutResult =
          lastObj.aboutCount ~/ (aboutUsVisit == 0 ? 1 : aboutUsVisit);
      int catalogResult = lastObj.cataLogPageCount ~/
          (cataLogPageVisit == 0 ? 1 : cataLogPageVisit);
      int contactResult =
          lastObj.contactCount ~/ (contactVisit == 0 ? 1 : contactVisit);
      int homeResult =
          lastObj.homePageCount ~/ (homePageVisit == 0 ? 1 : homePageVisit);
      int settingResult =
          lastObj.settingsCount ~/ (settingsVisit == 0 ? 1 : settingsVisit);
      int menuResult =
          lastObj.menuPageCount ~/ (menuPageVisit == 0 ? 1 : menuPageVisit);
      int supportResult =
          lastObj.supportCount ~/ (supportVisit == 0 ? 1 : supportVisit);
      PageViewsLabel model1 =
          PageViewsLabel(label: "About Us Page", count: aboutResult);
      PageViewsLabel model2 =
          PageViewsLabel(label: "Catalog Page", count: catalogResult);
      PageViewsLabel model3 =
          PageViewsLabel(label: "Contact Page", count: contactResult);
      PageViewsLabel model4 =
          PageViewsLabel(label: "Home Page", count: homeResult);
      PageViewsLabel model5 =
          PageViewsLabel(label: "Menu Page", count: menuResult);
      PageViewsLabel model6 =
          PageViewsLabel(label: "Settings Page", count: settingResult);
      PageViewsLabel model7 =
          PageViewsLabel(label: "Support Page", count: supportResult);
      crackList.add(model1);
      crackList.add(model2);
      crackList.add(model3);
      crackList.add(model4);
      crackList.add(model5);
      crackList.add(model6);
      crackList.add(model7);
    }

    return crackList;
  }

  pageViewsItem(List<PageViewsLabel> pageViews, int index) {
    pageViews.sort((b, a) => a.count.compareTo(b.count));
    PageViewsLabel data = pageViews[index];
    return data.count == 0
        ? Container()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${data.label}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              Spacer(),
              Text(
                "${data.count}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                width: 12,
              )
            ],
          );
  }
}
