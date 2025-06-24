import 'package:feedback_app/app/modules/user/home/repository/home_repository.dart';
import 'package:get/get.dart';

import '../../../../models/feedback_model.dart';

class HomeController extends GetxController {
  HomeRepository homeRepository = Get.find<HomeRepository>();

  // Danh sách các phản ánh
  final feedbackList = <FeedbackModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFeedbackData(); // Gọi async function bên trong
  }

  Future<void> loadFeedbackData() async {
    try {
      final data = await homeRepository.fetchUserData();
      feedbackList.assignAll(data); // data phải là Iterable<FeedbackModel>
    } catch (e) {
      print('Lỗi khi tải dữ liệu: $e');
    }
  }
}
