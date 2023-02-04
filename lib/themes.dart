import 'package:flutter/material.dart';

Color yellow = Color(0xFFF7BD14);
Color purple = Color(0xFF7042c3);
Color darkGray = Color(0xFF383838);
Color red = Color(0xFFf13a5e);

abstract class BaseTheme {
  Color backgroundColor;
  Color backgroundDarkColor;
  ThemeData theme;
  Color bottomItemSelectedColor;
  Color bottomItemNonSelectedColor;
  Color bottomNavigationBarBackgroundColor;
  Color cardOverlayColor = Color.fromRGBO(41, 13, 12, 0.3);

  Color storyPrimaryTextColor;

  Color catalogButtonBackgroundColor;
  Color catalogButtonFontColor;
  Color catalogDetailsFontColor;

  Color catalogMainTextFontColor = Colors.white;
  Color catalogSecondaryTextFontColor = Colors.white.withOpacity(0.4);

  Color headerTitleColor = Colors.white;
  Color headerSubtitleColor = Colors.white.withOpacity(0.6);
  Color homeButtonBackgroundColor = Colors.white;
  Color homeButtonFontColor = Colors.black;
  Color homeDetailsFontColor = Color(0xFFf9f9f9);

  Color homeMainTextFontColor = Colors.white;
  Color homeSecondaryTextFontColor = Colors.white.withOpacity(0.4);

  Color listSeparatorColor;
  Color starColor = Color(0xFFffcd36);

  Color menuButtonBackgroundColor = Colors.white;
  Color menuButtonFontColor = Colors.black;
}

class HorrorTheme extends BaseTheme {
  HorrorTheme() {
    backgroundColor = darkGray;
    theme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      backgroundColor: Color(0xFFFF0000),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
    bottomItemSelectedColor = Colors.white;
    bottomItemNonSelectedColor = Color.fromRGBO(255, 255, 255, 0.4);
    bottomNavigationBarBackgroundColor = Color(0xff1e1e1e);
    storyPrimaryTextColor = Color(0xFF939394);
    backgroundDarkColor = Color(0xFF1d283b);

    catalogButtonBackgroundColor = Colors.white;
    catalogButtonFontColor = Colors.black;
    catalogDetailsFontColor = Color(0xFFf9f9f9);

    catalogMainTextFontColor = Colors.white;
    catalogSecondaryTextFontColor = catalogMainTextFontColor.withOpacity(0.4);

    listSeparatorColor = Color(0xFF979797).withOpacity(0.4);
  }
}

class KidsTheme extends BaseTheme {
  KidsTheme() {
    backgroundColor = Colors.white;
    theme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      backgroundColor: yellow,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
    bottomItemSelectedColor = Colors.white;
    bottomItemNonSelectedColor = Color.fromRGBO(255, 255, 255, 0.4);
    bottomNavigationBarBackgroundColor = purple;
    storyPrimaryTextColor = Color(0xFF939394);
    backgroundDarkColor = Color(0xFF1d283b);

    headerTitleColor = purple;
    headerSubtitleColor = Color(0xFF3d4056).withOpacity(0.6);

    catalogButtonBackgroundColor = red;
    catalogButtonFontColor = Colors.white;
    catalogDetailsFontColor = red;

    catalogMainTextFontColor = Color(0xFF3d4056);
    catalogSecondaryTextFontColor = catalogMainTextFontColor.withOpacity(0.4);

    listSeparatorColor = Color(0xFF3d4056).withOpacity(0.4);

    menuButtonBackgroundColor = catalogButtonBackgroundColor;
    menuButtonFontColor = Colors.white;
  }
}
