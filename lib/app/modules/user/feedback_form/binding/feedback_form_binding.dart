import 'package:get/get.dart';

import '../controller/feedback_form_controller.dart';

class FeedbackFormBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy loading the FeedbackCreationController when it's needed
    Get.lazyPut<FeedbackFormController>(() => FeedbackFormController());
  }
}
