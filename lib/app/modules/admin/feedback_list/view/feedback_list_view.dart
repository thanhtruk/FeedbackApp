import 'package:feedback_app/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_widgets/feedback_card.dart';
import '../../../../routes/app_pages.dart';
import '../controller/feedback_list_controller.dart';

class FeedbackListView extends GetView<FeedbackListController> {
  const FeedbackListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Góp ý của sinh viên',
          style: TextStyle(
              color: AppColors.lightWhite,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        iconTheme: IconThemeData(color: AppColors.lightWhite),
        backgroundColor: AppColors.bluePrimary,
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: Obx(() {
              print(
                  'Selected Button Index: ${controller.selectedButtonIndex.value}');
              return Container(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                height: 48,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.keywords.length,
                  itemBuilder: (context, index) {
                    final keyword = controller.keywords.keys.toList()[index];
                    final isSelected =
                        index == controller.selectedButtonIndex.value;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: TextButton(
                        onPressed: () {
                          controller.selectedButtonIndex.value = index;
                          controller.updateFeedbackList();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: isSelected
                              ? AppColors.bluePrimary.withOpacity(0.2)
                              : Colors.transparent,
                          foregroundColor:
                              isSelected ? Colors.black : Colors.black87,
                          side: BorderSide(
                            color:
                                isSelected ? Colors.grey : Colors.grey.shade400,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                        ),
                        child: Text(
                          keyword,
                          style: TextStyle(
                            fontSize: isSelected ? 16 : 14,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            })),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => ListView.builder(
            itemCount: controller.feedbackList.length,
            itemBuilder: (context, index) {
              final feedback = controller.feedbackList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: GestureDetector(
                  child: FeedbackCard(feedback: feedback),
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.FEEDBACK_DETAIL,
                      arguments: {'id': feedback.id},
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
