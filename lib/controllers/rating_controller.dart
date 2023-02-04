import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:horror_story/models/most_visited/most_visited_response.dart';
import 'package:horror_story/models/page_views.dart';
import 'package:horror_story/models/screen_time_model.dart';
import 'package:horror_story/models/story_rating/app_rating_response.dart';
import 'package:horror_story/models/story_rating/story_rating_response.dart';

class RatingController extends GetxController {
  var deviceId = "".obs;
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  var firestore = FirebaseFirestore.instance;
  var ratingList = [].obs;
  var appRatingList = [].obs;
  var mostVisitedStories = [].obs;
  var pageViewData;
  var screenTime = [].obs;
  var pageViews = [].obs;

  FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;

  getAppRating() async {
    var _collectionRef = FirebaseFirestore.instance.collection('app_rating');
    var querySnapshot = _collectionRef.snapshots();

    querySnapshot.listen((event) {
      List<AppRatingResponse> appRatings = [];
      for (int index = 0; index < event.docs.length; index++) {
        AppRatingResponse appRatingResponse =
            AppRatingResponse.fromJson(event.docs[index].data());
        appRatings.add(appRatingResponse);
      }
      print("event");
      appRatingList(appRatings);
    });

    print("");
  }

  setAppRating(rating, {onAppRating}) async {
    Map body = <String, dynamic>{
      "app_rating": rating,
      "user_id": deviceId.value
    };
    var firestore = FirebaseFirestore.instance;
    await firestore
        .collection("app_rating")
        .doc(deviceId.value)
        .set(body)
        .then((value) {
      if (onAppRating != null) {
        onAppRating();
      }
    }).catchError((error) {
      print("Failed to add user: $error");
    });
  }

  getAllRatings() async {
    var _collectionRef = FirebaseFirestore.instance.collection('rating');
    var querySnapshot = _collectionRef.snapshots();
    querySnapshot.listen((event) {
      // var data = json.encode(event.docs.first.data());
      // data.replaceAll("\"", "");
      List<StoryRatingResponse> list = [];
      for (int index = 0; index < event.docs.length; index++) {
        StoryRatingResponse obj =
            StoryRatingResponse.fromJson(event.docs[index].data());
        list.add(obj);
      }
      ratingList(list);
      getAppRating();
      print("event");
    });
    print("");
  }

  getMostVisitedStories() async {
    var _collectionRef = FirebaseFirestore.instance.collection('most_visited');
    var querySnapshot = _collectionRef.snapshots();
    querySnapshot.listen((event) {
      // var data = json.encode(event.docs.first.data());
      // data.replaceAll("\"", "");

      List<MostVisitedResponse> list = [];
      for (int index = 0; index < event.docs.length; index++) {
        MostVisitedResponse obj =
            MostVisitedResponse.fromJson(event.docs[index].data());
        list.add(obj);
      }
      mostVisitedStories(list);
      print("event");
    });
    print("");
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      print(platformVersion);
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceId(build.androidId);
        print(deviceId.value); //UUID for Android
        await setUserProperties(deviceId.value);
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceId(data.identifierForVendor); //UUID for iOS
        print(deviceId.value);
        await setUserProperties(deviceId.value);
      }
    } on PlatformException {
      platformVersion = 'Failed to get Device MAC Address.';
    }
  }

  Future setUserProperties(String userId) async {
    await _firebaseAnalytics.setUserId(id: userId);
  }

  Future<void> rateStory({body, onAdd, docId}) async {
    var firestore = FirebaseFirestore.instance;
    var data = await firestore
        .collection("rating")
        .doc(docId)
        // .collection(_ratingController.deviceId.value)
        // .doc("dev_" + _ratingController.deviceId.value)
        .set(body)
        .then((value) {
      print("User Added");
      if (onAdd != null) {
        onAdd();
      }
    }).catchError((error) {
      print("Failed to add user: $error");
    });
  }

  double getRating(id) {
    double count = 0;
    double total = 0;
    double result = 0.0;
    for (int index = 0; index < ratingList.length; index++) {
      StoryRatingResponse value = ratingList.value[index];
      if (value.storyId == id) {
        total = total + 1;
        count = count + (value.rating ?? 0.0);
      }
    }
    if (total != 0) {
      result = count / total;
    }
    return result;
  }

  getRateCount(String storyId) {
    int total = 0;
    for (int index = 0; index < ratingList.length; index++) {
      StoryRatingResponse value = ratingList.value[index];
      if (value.storyId == storyId) {
        total = total + 1;
      }
    }

    return total;
  }

  getUserRating(String storyId) {
    var total = 0;
    for (int index = 0; index < ratingList.length; index++) {
      StoryRatingResponse value = ratingList.value[index];
      if (value.storyId == storyId) {
        if (value.userId == deviceId.value) {
          return value.rating;
        }
      }
    }

    return 0;
  }

  Future setStoryDrop({Map<dynamic, dynamic> body, String docId}) async {
    var firestore = FirebaseFirestore.instance;
    var data = await firestore
        .collection("story_dropped")
        .doc(docId)
        // .collection(_ratingController.deviceId.value)
        // .doc("dev_" + _ratingController.deviceId.value)
        .set(body)
        .then((value) {
      print("Story Dropped");
    }).catchError((error) {
      print("Failed to Story Dropped: $error");
    });
  }

  void setMostVisits({Map<dynamic, dynamic> body, String docId}) async {
    var firestore = FirebaseFirestore.instance;
    var data = await firestore
        .collection("most_visited")
        .doc(docId)
        // .collection(_ratingController.deviceId.value)
        // .doc("dev_" + _ratingController.deviceId.value)
        .set(body)
        .then((value) {
      print("Story Dropped");
    }).catchError((error) {
      print("Failed to Story Dropped: $error");
    });
  }

  getTotalVisitCount(String storyId, {needObject}) {
    bool nedObject = needObject ?? false;
    var total = 0;
    for (int index = 0; index < mostVisitedStories.length; index++) {
      MostVisitedResponse value = mostVisitedStories.value[index];
      if (value.storyId == storyId) {
        if (value.storyId == storyId) {
          if (nedObject) {
            return value;
          } else {
            return value.totalVisits.toString();
          }
        }
      }
    }
    if (nedObject) {
      return MostVisitedResponse();
    }
    return 0.toString();
  }

  getUserStoryCount(String storyId) async {
    var firestore = FirebaseFirestore.instance;
    var data = await firestore
        .collection("most_visited_user_stories")
        .doc(deviceId.value)
        .get();

    return data.data();
  }

  void setUserStoryCount(String storyId, int count) async {
    var firestore = FirebaseFirestore.instance;
    Map data = <String, dynamic>{
      storyId: count,
    };
    await firestore
        .collection("most_visited_user_stories")
        .doc(deviceId.value)
        .set(data);
  }

  void setUserStoryCountUpdate(String storyId, userStoryReadCount) async {
    var count = userStoryReadCount[storyId];
    if (count == null) {
      count = 1;
    } else {
      count = count + 1;
    }
    userStoryReadCount[storyId] = count;

    var firestore = FirebaseFirestore.instance;

    await firestore
        .collection("most_visited_user_stories")
        .doc(deviceId.value)
        .update(userStoryReadCount);
  }

  getAppRatingCount() {
    var count = 0.0;
    for (int index = 0; index < appRatingList.length; index++) {
      AppRatingResponse value = appRatingList.value[index];
      count = count + value.appRating;
    }
    count = count / appRatingList.length;
    return count;
  }

  getPageViewData() async {
    var firestore = FirebaseFirestore.instance;

    DocumentSnapshot loadData =
        await firestore.collection("page_view_data").doc(deviceId.value).get();
    pageViewData = loadData.data();

    var data = await firestore.collection("page_view_data").get();

    List<PageViews> views = [];
    for (int index = 0; index < data.docs.length; index++) {
      PageViews _page = PageViews.fromJson(data.docs[index].data());
      views.add(_page);
    }

    pageViews(views);
    print("${pageViewData == null ? "yes null" : "not null"}");
  }

  setPageView(count, pageName) async {
    Map body = <String, dynamic>{pageName: count};
    var firestore = FirebaseFirestore.instance;
    await firestore
        .collection("page_view_data")
        .doc(deviceId.value)
        .set(body)
        .then((value) {
      getPageViewData();
    }).onError((error, stackTrace) {
      print("$error");
    });
  }

  void updatePageView(pageCont, String pageName) async {
    int count = pageCont[pageName];
    if (count == null) {
      count = 1;
    } else {
      count = count + 1;
    }

    pageCont[pageName] = count;
    var firestore = FirebaseFirestore.instance;
    var loadData = await firestore
        .collection("page_view_data")
        .doc(deviceId.value)
        .set(pageCont)
        .then((value) {
      getPageViewData();
    }).onError((error, stackTrace) {
      print("$error");
    });
  }

 Future<void> getScreenTimeData({loop}) async {
    bool lop = loop ?? false;
    var firestore = FirebaseFirestore.instance;
    var data = await firestore.collection("screen_time").get().then((value) {
      print("${value.docs}");
      List<ScreenTimeModel> timeList = [];
      for (int index = 0; index < value.docs.length; index++) {
        ScreenTimeModel parseData =
            ScreenTimeModel.fromJson(value.docs[index].data());
        timeList.add(parseData);
      }
      screenTime(timeList);
      screenTime.refresh();
      if (!lop) {
        recordTime();
      }
    }).catchError((onError){

    });
  }

  recordTime() async {
    ScreenTimeModel exist = isExist(deviceId.value, screenTime.value);
    var firestore = FirebaseFirestore.instance;
    if (exist.userId != null) {
      var time = int.parse(exist.time);
      time = time + 60;
      exist.time = time.toString();
      var map = exist.toJson();
      await firestore
          .collection("screen_time")
          .doc(deviceId.value)
          .update(map)
          .then((valuex) {
        print("valuex");
      }).catchError((error) {
        print("Failed to add user: $error");
      });
      print("exist");
    } else {
      exist.userId = deviceId.value;
      exist.time = "60";
      var map = exist.toJson();

      await firestore
          .collection("screen_time")
          .doc(deviceId.value)
          .set(map)
          .then((valuex) {
        print("valuex");
      }).catchError((error) {
        print("Failed to add user: $error");
      });
      print("not exist");
    }
    Future.delayed(Duration(seconds: 60)).then((value) async {
      recordTime();
    });
  }

  isExist(String value, List<dynamic> timeList) {
    for (int index = 0; index < timeList.length; index++) {
      ScreenTimeModel data = timeList[index];
      if (data.userId == value) {
        return data;
      }
    }

    return ScreenTimeModel();
  }

  setAnalytics(pageName) {
    FirebaseAnalytics.instance.logEvent(
        name: "page_visit", parameters: {"page_name": pageName}).then((value) {
      print("abc");
    });
  }

  storyVisit(pageName) {
    FirebaseAnalytics.instance.logEvent(
        name: "page_visit", parameters: {"story_name": pageName}).then((value) {
      print("abc");
    });
  }
}
