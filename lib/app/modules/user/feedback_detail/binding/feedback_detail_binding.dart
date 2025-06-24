import 'package:feedback_app/app/modules/user/feedback_detail/repository/feedback_detail_repository.dart';
import 'package:get/get.dart';

import '../controller/feedback_detail_controller.dart';

class FeedbackDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy loading the FeedbackDetailController when it's needed
    Get.lazyPut<FeedbackDetailController>(() => FeedbackDetailController());
    Get.lazyPut<FeedbackDetailRepository>(
      () => FeedbackDetailRepository(),
    );
  }
}
