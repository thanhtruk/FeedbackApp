import 'package:feedback_app/app/modules/user/home/repository/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../models/feedback_model.dart';

class HomeController extends GetxController {
  HomeRepository homeRepository = Get.find<HomeRepository>();
  final ScrollController scrollController = ScrollController();

  final isLoading = true.obs;

  // Danh sách các phản ánh
  final feedbackList = <FeedbackModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFeedbackData(); // Gọi async function bên trong
  }

  Future<void> loadFeedbackData() async {
    try {
      isLoading.value = true; // Bắt đầu tải dữ liệu
      final data = await homeRepository.fetchUserData();
      feedbackList.assignAll(data); // Cập nhật danh sách phản ánh
    } catch (e) {
      print('Error loading feedback data: $e');
    } finally {
      isLoading.value = false; // Kết thúc tải dữ liệu
    }
  }
}
