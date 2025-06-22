import 'package:feedback_app/app/modules/user/feedback_form/service/feedback_form_service.dart';
import 'package:get/get.dart';

import '../controller/feedback_form_controller.dart';
import '../repository/feedback_form_repository.dart';

class FeedbackFormBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy loading the FeedbackCreationController when it's needed
    Get.lazyPut<FeedbackFormController>(() => FeedbackFormController());
    Get.lazyPut<FeedbackFormService>(() => FeedbackFormService());
    Get.lazyPut<FeedbackFormRepository>(
      () => FeedbackFormRepository(
          fieldFormService: Get.find<FeedbackFormService>()),
    );
  }
}
