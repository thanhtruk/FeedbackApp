import 'package:feedback_app/app/models/feedback_model.dart';
import 'package:feedback_app/app/service/feedback_service.dart';

class DashboardRepository {
  // This class will handle the data fetching and manipulation for the dashboard.
  // It can interact with APIs, databases, or any other data sources.

  // Example method to fetch dashboard data
  Future<List<FeedbackModel>> fetchDashboardData() async {
    List<FeedbackModel> allData = [];
    String? lastId = 'f1-06-23';
    const int pageSize = 50;

    while (true) {
      try {
        final pageData = await FeedbackService.getAllFeedback(
          limit: pageSize,
          startAfterId: lastId,
        );

        if (pageData.isEmpty) break;

        allData.addAll(pageData);
        lastId =
            pageData.last.id; // dùng id cuối cùng làm start_after_id tiếp theo

        if (pageData.length < pageSize)
          break; // không đủ trang đầy, đã hết dữ liệu
        await Future.delayed(Duration(milliseconds: 100));
      } catch (e) {
        print('Error fetching feedback data for dashboard: $e');
        break; // Dừng vòng lặp nếu có lỗi
      }
    }

    return allData;
  }
}
