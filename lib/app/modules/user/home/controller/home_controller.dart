import 'package:get/get.dart';

import '../../../../models/feedback_model.dart';

class HomeController extends GetxController {
  // Danh sách các phản ánh
  final feedbackList = <FeedbackModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Ví dụ dữ liệu ban đầu
    feedbackList.addAll([
      FeedbackModel(
        id: '1',
        title: 'Máy chiếu Phòng 015 TT bị mờ',
        field: 'Phòng Quản lý Cơ sở vật chất',
        requestCode: '161-06/25',
        status: FeedbackStatus.processing,
      ),
      FeedbackModel(
        id: '2',
        title: 'Quạt hỏng phòng học A204',
        field: 'Phòng CSVC',
        requestCode: '161-06/20',
        status: FeedbackStatus.resolved,
      ),
    ]);
  }

  void updateFeedbackStatus(String id, FeedbackStatus newStatus) {
    final feedback = feedbackList.firstWhereOrNull((f) => f.id == id);
    if (feedback != null) {
      feedback.status.value = newStatus;
    }
  }
}
