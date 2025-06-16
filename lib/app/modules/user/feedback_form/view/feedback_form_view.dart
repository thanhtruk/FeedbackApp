import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../controller/feedback_form_controller.dart';

class FeedbackFormView extends GetView<FeedbackFormController> {
  FeedbackFormView({super.key});

  final List<String> feedbackTypes = [
    'CSVC - Cơ sở vật chất',
    'HP - Học phí',
    'HT - Học tập',
    'TT - Thực tập',
    'KHAC - Khác',
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
        child: Obx(() => Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    items: feedbackTypes.map((label) {
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
                  Expanded(child: Container()),
                  // const Text('Hình ảnh/Minh chứng đính kèm'),
                  // const SizedBox(height: 4),
                  // ElevatedButton.icon(
                  //   onPressed: () {
                  //     // TODO: chọn file
                  //   },
                  //   icon: const Icon(Icons.attach_file),
                  //   label: const Text('Chọn file'),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.grey[200],
                  //     foregroundColor: Colors.black,
                  //     elevation: 0,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(4),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 8),
                  // const Text(
                  //   'Chấp nhận JPG/PNG, dung lượng tối đa 5MB',
                  //   style: TextStyle(fontSize: 12, color: Colors.grey),
                  // ),
                  // const SizedBox(height: 16),
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
                        if (controller.agreeToTerms.value) {
                          controller.submitFeedback();
                          showFeedbackSuccessDialog();
                        } else {
                          Get.snackbar("Lỗi", "Bạn cần đồng ý với điều khoản.");
                        }
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
            )),
      ),
    );
  }
}

void showFeedbackSuccessDialog() {
  showCupertinoDialog(
    context: Get.context!,
    builder: (_) => CupertinoAlertDialog(
      title: Text(
        'Góp ý đã được gửi',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          'Góp ý của bạn đã được gửi tới bộ phận liên quan, vui lòng theo dõi thông báo phản hồi. Cảm ơn bạn rất nhiều.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Get.back(),
          isDefaultAction: true,
          child: Text(
            'Đồng ý',
            style: TextStyle(
              fontSize: 16,
              color: CupertinoColors.activeBlue,
            ),
          ),
        ),
      ],
    ),
  );
}
