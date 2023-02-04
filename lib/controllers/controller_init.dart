import 'package:get/get.dart';
import 'package:horror_story/controllers/rating_controller.dart';

class ControllerInit {
  void initControllers() {
    RatingController ratingController = Get.put(RatingController());
    ratingController.initPlatformState();
  }
}
