import 'package:get/get.dart';

import '../../../../models/feedback_model.dart';

class HomeController extends GetxController {
  // Danh sách các phản ánh
  final feedbackList = <FeedbackModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Ví dụ dữ liệu ban đầu
    feedbackList.addAll([]);
  }
}
