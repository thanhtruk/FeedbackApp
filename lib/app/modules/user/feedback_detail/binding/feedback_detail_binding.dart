import 'package:get/get.dart';

import '../controller/feedback_detail_controller.dart';

class FeedbackDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy loading the FeedbackDetailController when it's needed
    Get.lazyPut<FeedbackDetailController>(() => FeedbackDetailController());
  }
}
