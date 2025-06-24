import 'package:get/get.dart';

import '../controller/feedback_list_controller.dart';

class FeedbackListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedbackListController>(() => FeedbackListController());
  }
}
