import 'package:feedback_app/app/models/feedback_model.dart';
import 'package:feedback_app/app/service/feedback_service.dart';

class FeedbackDetailRepository {
  Future<FeedbackModel> getFeedbackbyId(String id) async {
    return FeedbackService.getFeedbackById(id).then((feedback) {
      if (feedback != null) {
        return feedback;
      } else {
        throw Exception('Feedback not found');
      }
    }).catchError((error) {
      print('Error fetching feedback: $error');
      throw error;
    });
  }
}
