import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:feedback_app/app/global_widgets/feedback_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../controller/feedback_handle_controller.dart';

class FeedbackHandleView extends GetView<FeedbackHandleController> {
  const FeedbackHandleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Góp ý số ${controller.selectedFeedback.value?.id ?? ''}',
          style: TextStyle(
            color: AppColors.lightWhite,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColors.bluePrimary,
        iconTheme: IconThemeData(color: AppColors.lightWhite),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //Thông tin phản ánh + trạng thái
            Obx(() {
              final feedback = controller.selectedFeedback.value;
              if (feedback == null) {
                return const CircularProgressIndicator(); // hoặc SizedBox.shrink()
              } else {
                return FeedbackCard(feedback: feedback);
              }
            }),

            const SizedBox(height: 24),
            // Tiêu đề phản ánh
            Text(
              'Nội dung phản ánh',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.bluePrimary,
              ),
            ),

            const SizedBox(height: 12),

            //Nội dung phản ánh từ sinh viên (màu xám)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Obx(() => Text(
                        controller.selectedFeedback.value?.content ??
                            'Nội dung phản ánh từ sinh viên sẽ được hiển thị ở đây.',
                        style: const TextStyle(fontSize: 14),
                      )),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Obx(() {
              final feedback = controller.selectedFeedback.value;
              if (feedback == null) return const SizedBox();

              final status = feedback.status ?? '';

              if (status == 'Đã xử lý' || status == 'Đang xử lý') {
                final hasResponse =
                    feedback.response != null && feedback.response!.isNotEmpty;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (hasResponse)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.bluePrimary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            feedback.response!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Phản hồi góp ý:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: controller.responseController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: "Nhập phản hồi...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.bluePrimary,
                              minimumSize: Size(double.infinity, 48),
                            ),
                            onPressed: () => controller.submitResponse(),
                            child: Text(
                              "Gửi phản hồi",
                              style: TextStyle(
                                  color: AppColors.lightWhite,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      )
                  ],
                );
              }

              if (status == 'Đang chờ duyệt') {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Chọn lĩnh vực:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          value: controller.fieldList
                                  .contains(controller.selectedField.value)
                              ? controller.selectedField.value
                              : null,
                          items: controller.fieldList.map((f) {
                            return DropdownMenuItem<String>(
                              value: f,
                              child: Text(
                                f,
                                style: const TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null)
                              controller.selectedField.value = value;
                          },
                          buttonStyleData: ButtonStyleData(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 48,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            elevation: 4,
                            offset: const Offset(0, -4),
                            scrollbarTheme: ScrollbarThemeData(
                              thumbColor: MaterialStateProperty.all(
                                  Colors.grey.shade400),
                              radius: const Radius.circular(12),
                              thickness: MaterialStateProperty.all(6),
                            ),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(Icons.arrow_drop_down),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 48,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.bluePrimary,
                          minimumSize: Size(double.infinity, 48),
                        ),
                        onPressed: controller.submitFieldSelection,
                        child: Text(
                          "Lưu chỉnh sửa",
                          style: TextStyle(
                              color: AppColors.lightWhite,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox(); // Trạng thái khác
            }),
          ],
        ),
      ),
    );
  }
}
