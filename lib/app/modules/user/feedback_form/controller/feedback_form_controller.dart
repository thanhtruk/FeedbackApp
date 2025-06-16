import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackFormController extends GetxController {
  final title = ''.obs;
  final content = ''.obs;
  final selectedField = RxnString();
  final agreeToTerms = false.obs;

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }

  void submitFeedback() {
    if (!agreeToTerms.value) {
      Get.snackbar("Lỗi", "Bạn cần đồng ý với điều khoản.");
      return;
    }

    if (titleController.text.isEmpty ||
        contentController.text.isEmpty ||
        selectedField.value == null) {
      Get.snackbar("Thiếu thông tin", "Vui lòng điền đầy đủ thông tin.");
      return;
    }

    // TODO: Gửi dữ liệu lên server hoặc xử lý logic khác
    Get.snackbar("Thành công", "Góp ý đã được gửi!");
  }
}
