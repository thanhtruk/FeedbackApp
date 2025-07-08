import 'package:feedback_app/app/modules/admin/all_feedback/controller/all_feedback_controller.dart';
import 'package:feedback_app/app/modules/admin/feedback_handle/repository/feedback_handle_repository.dart';
import 'package:feedback_app/app/utils/send_email.dart';
import 'package:feedback_app/app/utils/show_success_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../models/feedback_model.dart';

class FeedbackHandleController extends GetxController {
  final Rx<FeedbackModel?> selectedFeedback = Rx<FeedbackModel?>(null);
  final FeedbackHandleRepository feedbackHandleRepository =
      Get.find<FeedbackHandleRepository>();
  AllFeedbackController? allFeedbackController;

  final responseController = TextEditingController();

  var selectedField = ''.obs;

  final fieldList = [
    'Cơ sở vật chất',
    "Thủ tục",
    "Khảo thí",
    "Xét tốt nghiệp",
    "Giáo vụ",
    "Kế hoạch",
    "Dịch vụ sinh viên",
    "Thực tập",
    "Học phí",
    "Công nghệ thông tin",
    "Hỗ trợ Học viên Sau đại học",
    "Đào tạo trực tuyến"
  ]; // ví dụ

  @override
  void onInit() {
    super.onInit();
    if (Get.isRegistered<AllFeedbackController>()) {
      allFeedbackController = Get.find<AllFeedbackController>();
    }
    if (Get.arguments != null) {
      selectedFeedback.value = Get.arguments['feedback'] as FeedbackModel?;
    }
  }

  Future<void> submitFieldSelection() async {
    if (selectedField.value.isEmpty) {
      Get.snackbar('Error', 'Please select a field');
      return;
    }
    selectedFeedback.value!.field = selectedField.value;
    final hasNegative = selectedFeedback.value!.clausesSentiment!
        .any((map) => map.containsValue("Tiêu cực"));
    print('Selected field: ${selectedField.value}, hasNegative: $hasNegative');
    if (hasNegative) {
      selectedFeedback.value!.status = 'Đang xử lý';

      if (selectedFeedback.value!.id![0] == 'f') {
        await sendEmail(
          selectedField.value,
          formatClausesAsNumberedListFromListMap(
              selectedFeedback.value!.clausesSentiment!,
              selectedFeedback.value!.content!),
          selectedFeedback.value!.title!,
          selectedFeedback.value!.id!,
        );
      } else if (selectedFeedback.value!.id![0] == 'q') {
        await sendEmail(
          selectedField.value,
          selectedFeedback.value!.content!,
          selectedFeedback.value!.title!,
          selectedFeedback.value!.id!,
        );
      }
    } else {
      selectedFeedback.value!.status = 'Đã xử lý';
    }
    if (allFeedbackController != null) {
      allFeedbackController!.feedbackList.refresh();
    }
    try {
      await feedbackHandleRepository.submitFieldSelection(
        selectedFeedback.value!,
      );
      showFeedbackSuccessDialog(
          'Cập nhật lĩnh vực xử lý thành công. Hệ thống đã gửi email thông báo đến bộ phận liên quan.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update field selection: $e');
    }
  }

  Future<void> submitResponse() async {
    if (responseController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a response');
      return;
    }
    selectedFeedback.value!.response = responseController.text;
    selectedFeedback.value!.status = 'Đã xử lý';
    if (allFeedbackController != null) {
      allFeedbackController!.feedbackList.refresh();
    }
    await feedbackHandleRepository.submitResponse(selectedFeedback.value!);
    showFeedbackSuccessDialog('Cập nhật phản hồi thành công.');
  }
}
