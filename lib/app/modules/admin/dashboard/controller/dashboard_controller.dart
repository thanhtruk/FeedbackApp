import 'package:feedback_app/app/models/feedback_model.dart';
import 'package:feedback_app/app/modules/admin/dashboard/repository/dashboard_repository.dart';
import 'package:get/get.dart';

import '../model/feedback_issue.dart';
import '../model/yearly_feedback_stats.dart';

class DashboardController extends GetxController {
  final DashboardRepository dashboardRepository =
      Get.find<DashboardRepository>();

  RxList<FeedbackModel> feedbackList = <FeedbackModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    dashboardRepository.fetchDashboardData().then((data) {
      feedbackList.assignAll(data);
      update(); // Cập nhật giao diện sau khi dữ liệu được tải
    });
  }

  List<TopIssueGroup> get topIssueGroups {
    final Map<String, Map<String, List<FeedbackModel>>> grouped = {};

    for (var issue in feedbackList) {
      if (issue.status != 'Đã xử lý' &&
          issue.field != null &&
          issue.fieldDetails != null) {
        for (var detail in issue.fieldDetails!) {
          grouped.putIfAbsent(issue.field!, () => {});
          grouped[issue.field!]!.putIfAbsent(detail, () => []);
          grouped[issue.field!]![detail]!.add(issue);
        }
      }
    }

    // Lọc các detail có nhiều hơn 15 góp ý
    final List<TopIssueGroup> result = [];

    for (var entry in grouped.entries) {
      final category = entry.key;
      final issuesMap = entry.value;

      final filteredIssues = issuesMap.entries
          .where((e) => e.value.length > 15)
          .map((e) => TopIssue(fieldDetail: e.key, feedbacks: e.value))
          .toList();

      if (filteredIssues.isNotEmpty) {
        result.add(TopIssueGroup(category: category, issues: filteredIssues));
      }
    }

    return result;
  }

  List<YearlyFeedbackStats> get yearlyFeedbackStats {
    final Map<String, Map<String, int>> statsMap =
        {}; // year -> sentiment -> count

    for (var issue in feedbackList) {
      final dateStr = issue.createdAt ?? '';
      final year = DateTime.tryParse(dateStr)?.year.toString() ?? 'Khác';
      if (year == 'Khác') {
        print(issue.id);
        continue; // Bỏ qua nếu không có năm hợp lệ
      }
      statsMap.putIfAbsent(
          year,
          () => {
                'Tích cực': 0,
                'Tiêu cực': 0,
                'Trung lập': 0,
              });

      final sentiments = issue.clausesSentiment ?? [];
      for (var clause in sentiments) {
        for (var value in clause.values) {
          if (statsMap[year]!.containsKey(value)) {
            statsMap[year]![value] = statsMap[year]![value]! + 1;
          }
        }
      }
    }

    // Chuyển thành list để đưa vào biểu đồ
    final statsList = statsMap.entries.map((entry) {
      final year = entry.key;
      final counts = entry.value;

      return YearlyFeedbackStats(
        year: year,
        positive: counts['Tích cực'] ?? 0,
        negative: counts['Tiêu cực'] ?? 0,
        neutral: counts['Trung lập'] ?? 0,
      );
    }).toList();

    // Sắp xếp theo năm tăng dần
    statsList.sort((a, b) => a.year.compareTo(b.year));

    return statsList;
  }
}
