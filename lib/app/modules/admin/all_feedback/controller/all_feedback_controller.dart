import 'package:feedback_app/app/modules/admin/feedback_list/repository/feedback_list_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/feedback_model.dart';

class AllFeedbackController extends GetxController
    with GetSingleTickerProviderStateMixin {
  FeedbackListRepository feedbackListRepository;
  late TabController tabController;

  List<String> statusList = [
    'Tất cả',
    'Đã xử lý',
    'Đang chờ duyệt',
    'Đang xử lý',
  ];

  // Danh sách các phản ánh
  late var feedbackList = <FeedbackModel>[].obs;
  final selectedButtonIndex = 0.obs;
  late var args = <FeedbackModel>[];

  AllFeedbackController({
    required this.feedbackListRepository,
  });

  @override
  Future<void> onInit() async {
    super.onInit();
    tabController = TabController(length: statusList.length, vsync: this);
    args = Get.arguments as List<FeedbackModel>;
    feedbackList.assignAll(args);
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  List<FeedbackModel> getFilteredList(String status) {
    if (status == 'Tất cả') return feedbackList;
    return feedbackList.where((fb) => fb.status == status).toList();
  }
}
