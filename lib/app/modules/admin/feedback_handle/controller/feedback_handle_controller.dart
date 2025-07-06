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
    if (Get.arguments != null) {
      selectedFeedback.value = Get.arguments['feedback'] as FeedbackModel?;
    }
  }

  Future<void> submitFieldSelection() async {
    if (selectedFeedback.value != null) {
      await feedbackHandleRepository
          .submitFieldSelection(
        selectedField.value,
        selectedFeedback.value!.id!,
      )
          .then((_) async {
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
        Get.back();
        showFeedbackSuccessDialog(
            'Cập nhật lĩnh vực xử lý thành công. Hệ thống đã gửi email thông báo đến bộ phận liên quan.');
      }).catchError((error) {
        Get.snackbar('Error', 'Failed to submit field selection: $error');
      });

      Get.back();
    } else {
      Get.snackbar('Error', 'No feedback selected');
    }
  }

  Future<void> submitResponse() async {
    if (selectedFeedback.value != null) {
      await feedbackHandleRepository.submitResponse(
        responseController.text,
        selectedFeedback.value!.id!,
      );
      Get.back();
    } else {
      Get.snackbar('Error', 'No feedback selected');
    }
  }
}
