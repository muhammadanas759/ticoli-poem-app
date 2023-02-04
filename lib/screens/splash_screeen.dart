import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horror_story/controllers/rating_controller.dart';
import 'package:horror_story/screens/my_home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  RatingController _ratingController = Get.find();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 4)).then((value) async {
      await _ratingController.getPageViewData();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => MyHomePage(title: 'Horror Story'),
          ),
          (route) => false);
    });
  }

  bool ticoli = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ticoli ? getKidStory() : horrorStory(),
    );
  }

  horrorStory() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.13),
            child: Image(
              image: AssetImage('assets/images/img_girl.png'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Image(
            image: AssetImage(
              'assets/images/img_splash_logo.png',
            ),
            width: MediaQuery.of(context).size.width * 0.6,
          ),
        )
      ],
    );
  }

  getKidStory() {
    return Image.asset(
      'assets/images/splash_image.png',
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
    );
  }
}
