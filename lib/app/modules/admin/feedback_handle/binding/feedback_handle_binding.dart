import 'package:get/get.dart';

import '../controller/feedback_handle_controller.dart';
import '../repository/feedback_handle_repository.dart';

class FeedbackHandleBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy loading the FeedbackDetailController when it's needed
    Get.lazyPut<FeedbackHandleController>(() => FeedbackHandleController());
    Get.lazyPut<FeedbackHandleRepository>(
      () => FeedbackHandleRepository(),
    );
  }
}
