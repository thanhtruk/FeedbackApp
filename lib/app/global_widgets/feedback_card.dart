import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Máy chiếu Phòng 015 TT bị mờ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Mã yêu cầu: 161-06/25'),
            Text('Phòng/ban xử lý: Phòng Quản lý Cơ sở vật chất'),
            SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20), // Bo tròn
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 2), // Đổ bóng xuống dưới
                    blurRadius: 6,
                    spreadRadius: 0,
                  ),
                ],
                border: Border.all(color: AppColors.black.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Để container ôm sát nội dung
                children: [
                  Icon(Icons.circle, size: 12, color: AppColors.bluePrimary),
                  const SizedBox(width: 8),
                  Text(
                    'Đang xử lý',
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
