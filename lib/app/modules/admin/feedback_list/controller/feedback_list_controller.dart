import 'package:get/get.dart';

import '../../../../models/feedback_model.dart';

class FeedbackListController extends GetxController {
  // Danh sách các phản ánh
  late var feedbackList = <FeedbackModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as List<FeedbackModel>;
    feedbackList.assignAll(args);
  }
}
