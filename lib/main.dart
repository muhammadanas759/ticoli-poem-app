import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:horror_story/controllers/controller_init.dart';
import 'package:horror_story/env.dart';
import 'package:horror_story/utils/assets_aux.dart';

import 'models/story.dart';
import 'screens/splash_screeen.dart';

List<Story> storiesList;

void main() async {
  Environment.init(AppType.kids);
  startup();
}

void startup() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  await Firebase.initializeApp();
  // Loads stories from JSON files
  storiesList = await loadStoryList(env.storiesAssetList);
  ControllerInit().initControllers();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: env.appTheme.theme,
      home: SplashScreen(),
    );
  }
}
