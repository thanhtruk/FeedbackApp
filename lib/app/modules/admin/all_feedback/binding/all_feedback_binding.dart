import 'package:feedback_app/app/modules/admin/feedback_list/repository/feedback_list_repository.dart';
import 'package:get/get.dart';

import '../controller/all_feedback_controller.dart';

class AllFeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedbackListRepository>(() => FeedbackListRepository());
    //repository
    Get.lazyPut<AllFeedbackController>(() => AllFeedbackController(
        feedbackListRepository: Get.find<FeedbackListRepository>()));
  }
}
