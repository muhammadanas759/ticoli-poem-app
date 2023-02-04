import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horror_story/controllers/rating_controller.dart';
import 'package:horror_story/env.dart';
import 'package:horror_story/models/catalog_item.dart';
import 'package:horror_story/models/story.dart';
import 'package:horror_story/screens/kid/kid_story_page.dart';
import 'package:horror_story/screens/story_page.dart';
import 'package:horror_story/utils/app_utills.dart';
import 'package:horror_story/utils/size_manager.dart';
import 'package:horror_story/widgets/footer.dart';
import 'package:horror_story/widgets/header.dart';
import 'package:horror_story/widgets/item_button.dart';
import 'package:horror_story/widgets/rating_start.dart';
import 'package:horror_story/widgets/share.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RatingController _ratingController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ratingController.getAllRatings();
    _ratingController.getMostVisitedStories();
    _ratingController.getScreenTimeData();

    _ratingController.setAnalytics("Home Page");

    if (_ratingController.pageViewData == null) {
      _ratingController.setPageView(1, "HomePage");
    } else {
      _ratingController.updatePageView(
          _ratingController.pageViewData, "HomePage");
    }

    /* '${widget.story.assetPackageUrl}',
    '${widget.story.zipFileName}',
    _dir,*/

    Future.delayed(Duration.zero).then((value) async {
      var _dir = (await getApplicationDocumentsDirectory()).path;
      downloadAssets(-1, _dir);
    });
  }

  @override
  Widget build(BuildContext context) {
    creatStory();
    return Scaffold(
      backgroundColor: env.appTheme.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (storiesList.isEmpty)
            Header(
              subtitle: 'Tuesday, 11. August'.toUpperCase(),
              title: 'For this Night',
              titleColor: env.appTheme.headerTitleColor,
              subtitleColor: env.appTheme.headerSubtitleColor,
            ),
          _buildListView(context),
          if (storiesList.isEmpty)
            Expanded(
                flex: 1,
                child: SizedBox(
                  height: 10,
                )),
          if (storiesList.isEmpty) ShareWidget(),
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          for (int index = 0; index < storiesList.length; index++)
            _buildItem(context, storiesList[index], index),
          Footer(),
          // ListView.builder(
          //   itemBuilder: (BuildContext context, int index) {
          //     return ;
          //   },
          //   itemCount: storiesList.length,
          // )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, Story story, int index) {
    var onTap = () async {
      var storyRating = _ratingController.getUserRating(story.storyId);
      var total =
          _ratingController.getTotalVisitCount(story.storyId, needObject: true);
      var userStoryReadCount =
          await _ratingController.getUserStoryCount(story.storyId);
      var _dir = (await getApplicationDocumentsDirectory()).path;
      TextStyle fontsType = await getFonts();
      bool locked = story.catalogType == CatalogType.Locked;
      if (!locked) {
        if (appTypes != AppType.horror) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => StoryPage(
                story: story,
                storyRating: storyRating,
                userStoryReadCount: userStoryReadCount,
                total: total,
                fontsTyp: fontsType,
                dir: _dir,
              ),
            ),
          );
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => KidStoryPage(
              story: story,
              storyRating: storyRating,
              userStoryReadCount: userStoryReadCount,
              total: total,
              dir: _dir,
            ),
          ));
        }
      }
    };
    return story.catalogType == CatalogType.EarlyPhase
        ? getEarlyPhaseMessage(story, _ratingController.pageViews)
        : story.catalogType == CatalogType.Locked &&
                story.homeCoverAsset != null
            ? mainItem(story, index, onTap)
            : story.homeCoverAsset == null
                ? getWidget(story, _ratingController.pageViews)
                : Obx(() => mainItem(story, index, onTap));
  }

  void downloadAssets(int ind, dir) {
    int index = ind + 1;
    if (index < storiesList.length) {
      Story story = storiesList[index];
      String url = story.assetPackageUrl;
      String zipFile = story.zipFileName;
      var _dir = dir;

      print("$zipFile");
      var file = File('$dir/$zipFile');
      Future.delayed(Duration.zero).then((value) async {
        // bool exist = await file.exists();
        bool exist = await file.exists();
        // if (!exist) {
        //   print("");
        //   var bytes = file.readAsBytesSync();
        //   var archive = ZipDecoder().decodeBytes(bytes);
        //
        //   var storyLocalDir = story.localDir;
        //
        //   for (var file in archive) {
        //     var filename = '$_dir/$storyLocalDir/${file.name}';
        //     if ('$_dir/$storyLocalDir/${file.name}'
        //         .contains("/$storyLocalDir/$storyLocalDir")) {
        //       filename = filename.replaceAll(
        //           "/$storyLocalDir/$storyLocalDir", "/$storyLocalDir");
        //     }
        //     print("$filename");
        //     if (file.isFile) {
        //       var outFile = File(filename);
        //       outFile = await outFile.create(recursive: true);
        //       await outFile.writeAsBytes(file.content);
        //     }
        //   }
        //   downloadAssets(index, _dir);
        // } else {
        var files = await downloadFile(url, zipFile, dir);
        print("");
        var bytes = files.readAsBytesSync();
        var archive = ZipDecoder().decodeBytes(bytes);

        var storyLocalDir = story.localDir;

        for (var file in archive) {
          var filename = '$_dir/$storyLocalDir/${file.name}';
          if ('$_dir/$storyLocalDir/${file.name}'
              .contains("/$storyLocalDir/$storyLocalDir")) {
            filename = filename.replaceAll(
                "/$storyLocalDir/$storyLocalDir", "/$storyLocalDir");
          }
          print("$filename");
          if (file.isFile) {
            var outFile = File(filename);
            outFile = await outFile.create(recursive: true);
            await outFile.writeAsBytes(file.content);
          }
        }
        downloadAssets(index, _dir);
        // }
      });
    }
  }

  Future<File> downloadFile(String url, String filename, String dir) async {
    var req = await http.Client().get(Uri.parse(url));
    print("$url");
    var file = File('$dir/$filename');
    if (req.statusCode == 503) {
      var data = await downloadFile(url, filename, dir);
      return data;
    }
    return file.writeAsBytes(req.bodyBytes);
  }

  getWidget(Story story, RxList<dynamic> pageViews) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.only(
          left: SizeManager.of(context).transformX(50),
          right: SizeManager.of(context).transformX(50)),
      child: Column(
        children: [
          if (story.localDir == "break_line")
            Container(
              width: Get.width,
              height: 1,
              margin: EdgeInsets.only(top: 8, bottom: 8),
              color: Color(0xffD8D8D8),
            ),
          Row(
            children: [
              getThumImage(story.thumbnailAsset),
              SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${story.title}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "3 Min",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.normal),
                  )
                ],
              )),
              if (story.paddingTop != -1)
                ItemButton(
                  item: story,
                  color: env.appTheme.catalogButtonFontColor,
                  backgroundColor: env.appTheme.catalogButtonBackgroundColor,
                  detailsColor: env.appTheme.catalogDetailsFontColor,
                  onPressed: () {},
                ),
              if (story.paddingTop == -1)
                ItemButton(
                  item: story,
                  color: Colors.white,
                  backgroundColor: Color(0xffF13A5E),
                )
            ], //F13A5E
          ),
          if (story.localDir == "break_line")
            SizedBox(
              height: 12,
            )
        ],
      ),
    );
  }

  getThumImage(String thumbnailAsset) {
    thumbnailAsset = thumbnailAsset ?? "";
    bool svg = thumbnailAsset.contains(".svg");

    return thumbnailAsset.isEmpty
        ? Container()
        : SvgPicture.asset(
            thumbnailAsset,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          );
  }

  getEarlyPhaseMessage(Story story, RxList<dynamic> pageViews) {
    return Container(
      padding: EdgeInsets.only(top: 24, right: 24),
      width: Get.width,
      margin: EdgeInsets.only(
          bottom: 24,
          left: SizeManager.of(context).transformX(50),
          right: SizeManager.of(context).transformX(50)),
      decoration: BoxDecoration(
          color: Color(0xff7042C3),
          borderRadius: BorderRadius.all(
              Radius.circular(SizeManager.of(context).transformX(40)))),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        "We are in an early development phase.",
                        style: GoogleFonts.lato(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'The goal is to develop ',
                          style: GoogleFonts.lato(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'EDUCATIVE GAMES',
                                style: GoogleFonts.lato(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900)),
                            TextSpan(
                                text: ' and',
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  color: Colors.white,
                                )),
                            TextSpan(
                                text: ' STORIES',
                                style: GoogleFonts.lato(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900)),
                            TextSpan(
                                text:
                                    ' for the little ones having fun learning.',
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(top: 24, left: 40),
                ),
              ),
              Image.asset(
                'assets/images/early_phase_duck.png',
                height: 140,
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                top: 16,
                left: SizeManager.of(context).transformX(70),
                right: SizeManager.of(context).transformX(50),
                bottom: 20),
            width: Get.width,
            height: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              bottom: 40,
              left: SizeManager.of(context).transformX(60),
              right: SizeManager.of(context).transformX(0),
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Don\'t hesitate to write us and',
                style: GoogleFonts.lato(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
                    text: ' leave some feedback or ideas for improvement.',
                    style: GoogleFonts.lato(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

/*

 */
  mainItem(story, index, onTap) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index == 0)
              Container(
                height: SizeManager.of(context).transformX(260),
                child: Header(
                  subtitle: 'Tuesday, 11. August'.toUpperCase(),
                  title: 'For this Night',
                  titleColor: env.appTheme.headerTitleColor,
                  subtitleColor: env.appTheme.headerSubtitleColor,
                ),
              ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeManager.of(context).transformX(50),
              ),
              child: InkWell(
                onTap: onTap,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeManager.of(context).transformX(50)),
                  child: Stack(
                    children: <Widget>[
                      Material(
                        elevation: 0,
                        borderRadius: BorderRadius.circular(
                            SizeManager.of(context).transformX(40)),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                SizeManager.of(context).transformX(40)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                SizeManager.of(context).transformX(40)),
                            child: Image.asset(
                              story.homeCoverAsset,
                              width: SizeManager.of(context).transformX(630),
                              height: SizeManager.of(context).transformX(730),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      if (story.homeCoverAsset != null)
                        Positioned(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              color: env.appTheme.cardOverlayColor,
                              // color: Colors.orange,
                            ),
                            width: MediaQuery.of(context).size.width -
                                SizeManager.of(context).transformX(100),
                            height: SizeManager.of(context).transformX(142),
                            child: Row(
                              children: [
                                if (story.catalogType != CatalogType.Locked)
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: SizeManager.of(context)
                                            .transformX(46),
                                      ),
                                      RatingStar(
                                        size: 24,
                                        rating: _ratingController
                                            .getRating(story.storyId),
                                      ),
                                      SizedBox(
                                        width: SizeManager.of(context)
                                            .transformX(20),
                                      ),
                                      Text(
                                        "(${_ratingController.getRateCount(story.storyId)})",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                Expanded(
                                  child: SizedBox(
                                    width:
                                        SizeManager.of(context).transformX(46),
                                  ),
                                ),
                                ItemButton(
                                  item: story,
                                  color: env.appTheme.homeButtonFontColor,
                                  backgroundColor:
                                      env.appTheme.homeButtonBackgroundColor,
                                  detailsColor:
                                      env.appTheme.homeDetailsFontColor,
                                  onPressed: onTap,
                                ),
                                SizedBox(
                                  width: SizeManager.of(context).transformX(46),
                                ),
                              ],
                            ),
                          ),
                          bottom: 0,
                        ),
                      /* Positioned(
                        right: 0,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 12,
                              ),
                              Icon(Icons.remove_red_eye),
                              SizedBox(
                                width: 12,
                              ),
                              Text(_ratingController
                                  .getTotalVisitCount(story.storyId)),
                              SizedBox(
                                width: 12,
                              ),
                            ],
                          ),
                        ),
                      )*/
                    ],
                  ),
                ),
              ),
            ),
            // if (storiesList.length == 1) ShareWidget(),
            // if (storiesList.length > 1)
            //   if (index == storiesList.length - 2) ShareWidget(),
          ],
        ),
        if ((appTypes == AppType.kids))
          Container(
            decoration: BoxDecoration(
                color: getColor(story.storyId),
                borderRadius: BorderRadius.all(Radius.circular(40))),
            margin: EdgeInsets.only(
                top: index == 0
                    ? SizeManager.of(context).transformX(290)
                    : SizeManager.of(context).transformX(30),
                right: SizeManager.of(context).transformX(90)),
            padding: EdgeInsets.all(12),
            child: Text(
              "${getAgeLimit(story.storyId)}".toUpperCase(),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          )
      ],
    );
  }

  Future<TextStyle> getFonts() async {
    TextStyle fonts = GoogleFonts.comicNeue();
    return fonts;
  }
}
