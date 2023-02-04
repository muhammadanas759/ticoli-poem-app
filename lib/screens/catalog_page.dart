import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:horror_story/controllers/rating_controller.dart';
import 'package:horror_story/models/catalog_item.dart';
import 'package:horror_story/models/story.dart';
import 'package:horror_story/utils/size_manager.dart';
import 'package:horror_story/widgets/header.dart';
import 'package:horror_story/widgets/item_button.dart';
import 'package:horror_story/widgets/two_line.dart';

import '../env.dart';
import '../main.dart';

var fakeCatalogStories = [
  Story(
    storyId: "ddd",
    title: 'The night hunger dispair',
    duration: 5,
    thumbnailAsset: 'assets/images/thumb-night_hunger.png',
    date: DateTime(2021, 6, 1),
  ),
  Story(
    storyId: "ddd",
    title: 'The night hunger dispair',
    duration: 5,
    thumbnailAsset: 'assets/images/thumb-friendly_advice.png',
    date: DateTime(2021, 6, 1),
    catalogType: CatalogType.Future,
  ),
  Story(
    storyId: "ddd",
    title: 'The night hunger dispair',
    duration: 5,
    thumbnailAsset: 'assets/images/thumb-way_back_home_lady.png',
    date: DateTime(2021, 6, 1),
    catalogType: CatalogType.Future,
  )
];

var fakeKidsCatalogStories = [
  Story(
    storyId: "ddd",
    title: 'Girl with a Pink Shoe',
    duration: 4,
    thumbnailAsset: 'assets/images/kids-01.png',
    date: DateTime(2021, 6, 1),
  ),
  Story(
    storyId: "ddd",
    title: 'Good Night Owl',
    duration: 6,
    thumbnailAsset: 'assets/images/kids-02.png',
    date: DateTime(2021, 6, 1),
  ),
  Story(
    storyId: "ddd",
    title: 'Rogu’s Forest',
    duration: 7,
    thumbnailAsset: 'assets/images/kids-03.png',
    date: DateTime(2021, 6, 1),
  ),
  Story(
    storyId: "ddd",
    title: 'Ma ma Qua!',
    duration: 3,
    thumbnailAsset: 'assets/images/kids-04.png',
    date: DateTime(2021, 6, 1),
    catalogType: CatalogType.Future,
  ),
  Story(
    storyId: "ddd",
    title: 'Mr Bee',
    duration: 5,
    thumbnailAsset: 'assets/images/kids-05.png',
    date: DateTime(2021, 6, 1),
    catalogType: CatalogType.Locked,
  ),
  Story(
    storyId: "ddd",
    title: 'El Phant',
    duration: 5,
    thumbnailAsset: 'assets/images/kids-06.png',
    date: DateTime(2021, 6, 1),
    catalogType: CatalogType.Future,
  )
];

class CatalogPage extends StatefulWidget {
  CatalogPage({Key key}) : super(key: key);

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  RatingController _ratingController = Get.find();

  @override
  void initState() {
    super.initState();
    _ratingController.setAnalytics("Catalog Page");

    if (_ratingController.pageViewData == null) {
      _ratingController.setPageView(1, "CataLogPage");
    } else {
      _ratingController.updatePageView(
          _ratingController.pageViewData, "CataLogPage");
    }
  }

  @override
  Widget build(BuildContext context) {
    var list = getList();
    return Container(
      color: env.appTheme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (list.isEmpty)
            Header(
              subtitle: 'Tuesday, 11. August'.toUpperCase(),
              title: 'Catalog',
              titleColor: env.appTheme.headerTitleColor,
              subtitleColor: env.appTheme.headerSubtitleColor,
            ),
          _buildListView(context, list),
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context, List<Story> list) {
    // TODO: remove fake items in the future
    return Expanded(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(context, list[index], index);
        },
        separatorBuilder: (context, _) => Divider(
          color: env.appTheme.listSeparatorColor,
        ),
        itemCount: list.length,
      ),
    );
  }

  Widget _buildItem(BuildContext context, Story item, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (index == 0)
          Header(
            subtitle: 'Tuesday, 11. August'.toUpperCase(),
            title: 'Catalog',
            titleColor: env.appTheme.headerTitleColor,
            subtitleColor: env.appTheme.headerSubtitleColor,
          ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeManager.of(context).transformX(60),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                    SizeManager.of(context).transformX(20)),
                child: getThumbNail(item.thumbnailAsset),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: TwoLine(
                  first: item.title,
                  second: 'No rating',
                  hasRating: checkRating(
                      _ratingController.ratingList.value, item.storyId),
                  rating: _ratingController.getRating(item.storyId),
                  firstColor: env.appTheme.catalogMainTextFontColor,
                  secondColor: env.appTheme.catalogSecondaryTextFontColor,
                  width: 285,
                  fontSize: 34,
                ),
              ),
              ItemButton(
                item: item,
                color: env.appTheme.catalogButtonFontColor,
                backgroundColor: env.appTheme.catalogButtonBackgroundColor,
                detailsColor: env.appTheme.catalogDetailsFontColor,
                onPressed: () {},
              )
            ],
          ),
        ),
      ],
    );
  }

  checkRating(List<dynamic> value, String storyId) {
    for (int index = 0; index < value.length; index++) {
      print("");
      String valueX = value[index].storyName.toString();
      if (valueX.toLowerCase().contains("'")) {
        valueX = valueX.replaceAll("'", "");
      }
      if (value[index].storyId.toString().toLowerCase() ==
          storyId.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  getList() {
    List<Story> list = [];
    env.appType == AppType.horror
        ? [...storiesList, ...fakeCatalogStories]
        : fakeKidsCatalogStories;
    if (env.appType == AppType.horror) {
      if (storiesList.isEmpty) {
        list = fakeCatalogStories;
      }
      for (int index = 0; index < storiesList.length; index++) {
        if (storiesList[index].catalogType != CatalogType.EarlyPhase) {
          list.add(storiesList[index]);
        }
      }
    } else {
      if (storiesList.isEmpty) {
        list = fakeKidsCatalogStories;
      }
      for (int index = 0; index < storiesList.length; index++) {
        if (storiesList[index].catalogType != CatalogType.EarlyPhase) {
          list.add(storiesList[index]);
        }
      }
    }
    return list;
  }

  getThumbNail(String thumbnailAsset) {
    bool svg = thumbnailAsset.contains(".svg");
    return svg
        ? SvgPicture.asset(
            thumbnailAsset,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          )
        : Image.asset(
            thumbnailAsset,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          );
  }
}
