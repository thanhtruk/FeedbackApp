import 'package:feedback_app/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_widgets/feedback_card.dart';
import '../../../../routes/app_pages.dart';
import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

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
        backgroundColor: AppColors.bluePrimary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.bluePrimary,
              ),
            );
          }
          if (controller.feedbackList.isEmpty) {
            return Center(
              child: Text(
                'Không có phản ánh nào',
                style: TextStyle(
                  color: AppColors.lightGrey,
                  fontSize: 16,
                ),
              ),
            );
          }
          return ListView.builder(
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
                      arguments: {'feedback': feedback},
                    );
                  },
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.FEEDBACK_FORM);
        },
        backgroundColor: AppColors.bluePrimary,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppColors.lightWhite),
      ),
    );
  }
}
