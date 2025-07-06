import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void showFeedbackSuccessDialog(String text) {
  showCupertinoDialog(
    context: Get.context!,
    builder: (_) => CupertinoAlertDialog(
      title: Text(
        'Thành công',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Get.back();
            Get.back();
          },
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
