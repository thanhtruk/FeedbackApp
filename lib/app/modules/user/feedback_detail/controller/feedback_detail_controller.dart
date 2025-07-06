import 'package:feedback_app/app/modules/user/feedback_detail/repository/feedback_detail_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../models/feedback_model.dart';

class FeedbackDetailController extends GetxController {
  final Rx<FeedbackModel?> selectedFeedback = Rx<FeedbackModel?>(null);
  final FeedbackDetailRepository feedbackDetailRepository =
      Get.find<FeedbackDetailRepository>();

  final responseController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      selectedFeedback.value = Get.arguments['feedback'] as FeedbackModel?;
    }
  }
}
