import 'package:feedback_app/app/modules/user/feedback_detail/repository/feedback_detail_repository.dart';
import 'package:get/get.dart';

import '../../../../models/feedback_model.dart';

class FeedbackDetailController extends GetxController {
  final Rx<FeedbackModel?> selectedFeedback = Rx<FeedbackModel?>(null);
  final FeedbackDetailRepository feedbackDetailRepository =
      Get.find<FeedbackDetailRepository>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      String id = Get.arguments['id'] as String;
      loadFeedback(id);
    }
  }

  void loadFeedback(String id) async {
    selectedFeedback.value = await feedbackDetailRepository.getFeedbackbyId(id);
  }
}
