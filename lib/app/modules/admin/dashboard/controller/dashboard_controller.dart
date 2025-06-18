import 'package:get/get.dart';

import '../model/feedback_issue.dart';

class DashboardController extends GetxController {
  final totalFeedback = 430.obs;
  final positiveFeedback = 218.obs;
  final negativeFeedback = 212.obs;

  final issues = <FeedbackIssue>[
    FeedbackIssue(
        title: 'Phòng học xuống cấp',
        category: 'Về cơ sở vật chất',
        count: 120),
    FeedbackIssue(title: 'Đèn hư', category: 'Về cơ sở vật chất', count: 95),
    FeedbackIssue(
        title: 'WiFi yếu', category: 'Về công nghệ thông tin', count: 70),
    FeedbackIssue(
        title: 'Hệ thống lỗi', category: 'Về công nghệ thông tin', count: 65),
    FeedbackIssue(
        title: 'Ghế hư',
        category: 'Về cơ sở vật chất',
        count: 40), // không được hiển thị
  ].obs;

  List<FeedbackIssue> get topIssues =>
      issues.where((i) => i.count >= 50).toList();
}
