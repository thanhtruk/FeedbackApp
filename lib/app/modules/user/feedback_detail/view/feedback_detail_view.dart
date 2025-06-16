import 'package:feedback_app/app/global_widgets/feedback_card.dart';
import 'package:feedback_app/app/modules/user/feedback_detail/controller/feedback_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';

class FeedbackDetailView extends GetView<FeedbackDetailController> {
  const FeedbackDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Góp ý số 161-06/25-HS',
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
            FeedbackCard(),
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
                  child: const Text(
                    'Máy chiếu bị mờ, khó nhìn rõ nội dung khi học.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            //Phản hồi từ nhà trường (màu xanh)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.bluePrimary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Thiết bị đã được kiểm tra và thay thế mới.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Đánh giá
            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     color: Colors.grey[100],
            //     borderRadius: BorderRadius.circular(12),
            //     border: Border.all(color: Colors.grey[300]!),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Text(
            //         'Bạn cảm thấy thế nào với phản hồi này ?',
            //         style: TextStyle(fontWeight: FontWeight.w500),
            //       ),
            //       const SizedBox(height: 12),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: List.generate(5, (index) {
            //           return Icon(Icons.star_border, color: Colors.grey[600]);
            //         }),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
