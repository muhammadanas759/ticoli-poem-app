import 'package:horror_story/themes.dart';
import 'package:horror_story/utils/app_utills.dart';

enum AppType { horror, kids }

Environment get env => _env;
Environment _env;

class Environment {
  AppType appType;
  BaseTheme appTheme;

  String svgLogoAsset;

  List<String> storiesAssetList;

  Environment._init({
    this.appType,
    this.appTheme,
    this.storiesAssetList,
    this.svgLogoAsset,
  });

  static void init(AppType appType) async {
    appTypes = appType;
    if (appType == AppType.horror) {
      _env ??= Environment._init(
        appType: appType,
        appTheme: HorrorTheme(),
        storiesAssetList: [
          'assets/stories/story-01.json',
          'assets/stories/story-02.json',
          'assets/stories/story-03.json',
          'assets/stories/story-04.json',
        ],
        svgLogoAsset: 'assets/icons/logo_goodnighthorror.svg',
      );
    } else {
      _env ??= Environment._init(
        appType: appType,
        appTheme: KidsTheme(),
        storiesAssetList: [
          'assets/stories/kid-story-01.json',
          'assets/stories/kid-story-02.json',
          'assets/stories/kid-story-03.json',
          'assets/stories/mr_bee.json',
          'assets/stories/duck_ma_ma.json',
          'assets/stories/el_phant.json',
          'assets/stories/early_phase.json',
        ],
        svgLogoAsset: 'assets/icons/logo_ticoli.svg',
      );
    }
  }
}
