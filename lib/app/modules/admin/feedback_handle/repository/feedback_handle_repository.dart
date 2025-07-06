import 'package:feedback_app/app/modules/admin/feedback_handle/service/feedback_handle_service.dart';

class FeedbackHandleRepository {
  Future<void> submitResponse(String response, String id) async {
    await FeedbackHandleService.submitResponse(response, id);
  }

  Future<void> submitFieldSelection(String field, String id) async {
    await FeedbackHandleService.submitFieldSelection(field, id);
  }
}
