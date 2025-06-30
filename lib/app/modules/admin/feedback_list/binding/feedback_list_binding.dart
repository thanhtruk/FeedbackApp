import 'package:feedback_app/app/modules/admin/feedback_list/repository/feedback_list_repository.dart';
import 'package:get/get.dart';

import '../controller/feedback_list_controller.dart';

class FeedbackListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedbackListRepository>(() => FeedbackListRepository());
    //repository
    Get.lazyPut<FeedbackListController>(() => FeedbackListController(
        feedbackListRepository: Get.find<FeedbackListRepository>()));
  }
}
