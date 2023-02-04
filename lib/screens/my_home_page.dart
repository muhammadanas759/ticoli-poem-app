import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:horror_story/controllers/rating_controller.dart';
import 'package:horror_story/env.dart';
import 'package:horror_story/screens/catalog_page.dart';
import 'package:horror_story/screens/home_page.dart';
import 'package:horror_story/screens/menu_page.dart';
import 'package:horror_story/utils/app_utills.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  RatingController _ratingController = Get.find();

  @override
  void initState() {
    super.initState();

    final databaseReference = FirebaseDatabase.instance.reference();
    databaseReference
        .child("flutterDevsTeam1")
        .set({'name': 'Deepak Nishad', 'description': 'Team Lead'});
  }

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CatalogPage(),
    MenuPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Device pixel ratio: ${MediaQuery.of(context).devicePixelRatio}');
    print('Device size: ${MediaQuery.of(context).size}');
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          body: Container(
            child: _widgetOptions[_selectedIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: _onItemTapped,
            selectedItemColor: env.appTheme.bottomItemSelectedColor,
            items: [
              BottomNavigationBarItem(
                icon: getMenIcon(
                    svg: 'assets/icons/home.svg',
                    image: 'assets/images/kid_home.png',
                    index: 0),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: getMenIcon(
                    svg: 'assets/icons/catalog.svg',
                    image: 'assets/images/kid_catelog.png',
                    index: 1),
                label: 'Catalog',
              ),
              BottomNavigationBarItem(
                icon: getMenIcon(
                    svg: 'assets/icons/menu.svg',
                    image: 'assets/images/kidr_menu.png',
                    index: 2),
                label: 'Menu',
              ),
            ],
            backgroundColor: env.appTheme.bottomNavigationBarBackgroundColor,
          ),
        ));
  }

  getMenIcon({svg, image, index}) {
    return appTypes != AppType.horror
        ? Image.asset(image,
            width: 27,
            height: 27,
            color: _selectedIndex == index
                ? env.appTheme.bottomItemSelectedColor
                : env.appTheme.bottomItemNonSelectedColor)
        : SvgPicture.asset(
            svg,
            width: 27,
            height: 27,
            color: _selectedIndex == 0
                ? env.appTheme.bottomItemSelectedColor
                : env.appTheme.bottomItemNonSelectedColor,
          );
  }
}
