import 'package:get/get.dart';

import '../../../../models/feedback_model.dart';

class FeedbackDetailController extends GetxController {
  final Rx<FeedbackModel?> selectedFeedback = Rx<FeedbackModel?>(null);

  @override
  void onInit() {
    super.onInit();
    print("✅ FeedbackDetailController loaded");
  }

// Khởi tạo với id hoặc truyền trực tiếp model
}
