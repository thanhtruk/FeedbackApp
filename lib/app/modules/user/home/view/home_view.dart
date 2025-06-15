import 'package:feedback_app/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_widgets/feedback_card.dart';
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
        child: ListView.builder(
          itemCount: 4, // số lượng góp ý (giả định)
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: FeedbackCard(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Chuyển sang màn thêm góp ý mới
        },
        backgroundColor: AppColors.bluePrimary,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppColors.lightWhite),
      ),
    );
  }
}
