import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../controller/feedback_form_controller.dart';

class FeedbackFormView extends GetView<FeedbackFormController> {
  FeedbackFormView({super.key});

  final List<String> feedbackFields = [
    'Cơ sở vật chất',
    'Học phí',
    'Giáo vụ',
    'Thực tập',
    'Khác',
  ];

  final List<String> feedbackTypes = [
    'Đánh giá',
    'Câu hỏi',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bluePrimary,
        title: Text(
          'Sinh viên góp ý',
          style: TextStyle(color: AppColors.lightWhite),
        ),
        iconTheme: IconThemeData(color: AppColors.lightWhite),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Form(
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Loại phản hồi'),
                const SizedBox(height: 4),
                DropdownButtonFormField<String>(
                  value: controller.selectedType.value,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  hint: const Text('Chọn loại phản hồi'),
                  items: feedbackTypes.map((label) {
                    return DropdownMenuItem(
                      child: Text(label),
                      value: label,
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedType.value = value;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Tiêu đề góp ý'),
                const SizedBox(height: 4),
                TextFormField(
                  controller: controller.titleController,
                  decoration: const InputDecoration(
                    hintText: 'Nhập tiêu đề góp ý',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Lĩnh vực góp ý'),
                const SizedBox(height: 4),
                DropdownButtonFormField<String>(
                  value: controller.selectedField.value,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  hint: const Text('Chọn lĩnh vực góp ý'),
                  items: feedbackFields.map((label) {
                    return DropdownMenuItem(
                      child: Text(label),
                      value: label,
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedField.value = value;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Nội dung góp ý'),
                const SizedBox(height: 4),
                TextFormField(
                  controller: controller.contentController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Nhập tiêu đề góp ý',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height - 720),
                Row(
                  children: [
                    Checkbox(
                      value: controller.agreeToTerms.value,
                      onChanged: (val) =>
                          controller.agreeToTerms.value = val ?? false,
                    ),
                    Expanded(
                      child: Text(
                        'Tôi cam kết những góp ý trên là đúng sự thật và chịu mọi trách nhiệm về thông tin góp ý.',
                        style: TextStyle(fontSize: 13),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.submitFeedback();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.bluePrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Gửi góp ý',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
