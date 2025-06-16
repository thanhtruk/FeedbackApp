import 'package:get/get.dart';

import '../../../../models/feedback_model.dart';
import '../../home/controller/home_controller.dart';

class FeedbackDetailController extends GetxController {
  final Rx<FeedbackModel?> selectedFeedback = Rx<FeedbackModel?>(null);

  @override
  void onInit() {
    super.onInit();
    print("✅ FeedbackDetailController loaded");
  }

  // Khởi tạo với id hoặc truyền trực tiếp model
  void loadFeedbackById(String id) {
    final homeController = Get.find<HomeController>();
    final feedback =
        homeController.feedbackList.firstWhereOrNull((f) => f.id == id);
    selectedFeedback.value = feedback;
  }

  void markAsResolved() {
    selectedFeedback.value?.status.value = FeedbackStatus.resolved;
  }

  FeedbackStatus? get currentStatus => selectedFeedback.value?.status.value;
}
