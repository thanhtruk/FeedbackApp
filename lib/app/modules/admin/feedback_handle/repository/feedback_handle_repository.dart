import 'package:feedback_app/app/models/feedback_model.dart';
import 'package:feedback_app/app/modules/admin/feedback_handle/service/feedback_handle_service.dart';

class FeedbackHandleRepository {
  Future<void> submitResponse(FeedbackModel feedback) async {
    await FeedbackHandleService.submitResponse(feedback);
  }

  Future<void> submitFieldSelection(FeedbackModel feedback) async {
    await FeedbackHandleService.submitFieldSelection(feedback);
  }
}
