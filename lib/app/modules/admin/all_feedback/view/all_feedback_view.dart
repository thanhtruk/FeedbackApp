import 'package:feedback_app/app/constants/app_colors.dart';
import 'package:feedback_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_widgets/feedback_card.dart';
import '../controller/all_feedback_controller.dart';

class AllFeedbackView extends GetView<AllFeedbackController> {
  const AllFeedbackView({super.key});

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
        bottom: TabBar(
          controller: controller.tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.center,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: controller.statusList.map((label) => Tab(text: label)).toList(),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TabBarView(
            controller: controller.tabController,
            children: controller.statusList.map((status) {
              return Obx(() {
                final filtered = controller.getFilteredList(status);
                if (filtered.isEmpty) {
                  return Center(child: Text('Không có góp ý nào.'));
                }
                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (_, index) {
                    final item = filtered[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: FeedbackCard(feedback: item),
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.ADMIN_FEEDBACK_HANDLE,
                            arguments: {'feedback': item},
                          );
                        },
                      ),
                    );
                  },
                );
              });
            }).toList(),
          )),
    );
  }
}
