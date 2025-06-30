import '../models/ExtractKeywordsModel.dart';
import '../service/feedback_list_service.dart';

class FeedbackListRepository {
  Future<ExtractKeywordsModel> extractKeywords(String text) async {
    return await FeedbackListService().extractKeywords(text);
  }
}
