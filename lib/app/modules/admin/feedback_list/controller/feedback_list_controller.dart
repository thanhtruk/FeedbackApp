import 'package:feedback_app/app/modules/admin/feedback_list/models/ExtractKeywordsModel.dart';
import 'package:feedback_app/app/modules/admin/feedback_list/repository/feedback_list_repository.dart';
import 'package:get/get.dart';

import '../../../../models/feedback_model.dart';

class FeedbackListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  FeedbackListRepository feedbackListRepository;

  // Danh sách các phản ánh
  late var feedbackList = <FeedbackModel>[].obs;
  late var keywords = <String, int>{}.obs;
  final selectedButtonIndex = 0.obs;
  late var args = <FeedbackModel>[];

  FeedbackListController({
    required this.feedbackListRepository,
  });

  @override
  Future<void> onInit() async {
    super.onInit();
    args = Get.arguments as List<FeedbackModel>;
    feedbackList.assignAll(args);
    ExtractKeywordsModel extractKeywordsModel = await feedbackListRepository
        .extractKeywords(extractNegativeClauses(feedbackList));
    print(extractNegativeClauses(feedbackList));
    //add keywords "Tat ca" with count of 0
    final keywordsWithAll = {'Tất cả': 0, ...extractKeywordsModel.wordsCount!};
    keywords.assignAll(keywordsWithAll);
  }

  String extractNegativeClauses(List<FeedbackModel> feedbackList) {
    final negativeClauses = <String>[];

    for (var feedback in feedbackList) {
      final clauses = feedback.clausesSentiment;
      if (clauses == null) continue;

      for (var clause in clauses) {
        if (clause.values.any((value) => value == 'Tiêu cực')) {
          final text = clause['clause'];
          if (text != null && text.trim().isNotEmpty) {
            negativeClauses.add(text.trim().replaceAll("_", " "));
          }
        }
      }
    }

    return negativeClauses.join('. ') + (negativeClauses.isNotEmpty ? '.' : '');
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updateFeedbackList() {
    final index = selectedButtonIndex.value;
    final keywordKeys = keywords.keys.toList();

    if (index == 0) {
      // Tab đầu tiên: hiển thị toàn bộ
      feedbackList.assignAll(args);
    } else if (index < keywordKeys.length) {
      final keyword = keywordKeys[index].toLowerCase();
      feedbackList.assignAll(
        args
            .where(
              (feedback) =>
                  feedback.content?.toLowerCase().contains(keyword) ?? false,
            )
            .toList(),
      );
    } else {
      // Trường hợp index vượt giới hạn
      feedbackList.clear();
    }
  }
}
