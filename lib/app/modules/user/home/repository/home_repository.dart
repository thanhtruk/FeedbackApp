import '../../../../models/feedback_model.dart';
import '../../../../service/feedback_service.dart';

class HomeRepository {
  // This class can be used to interact with the data source for the home module.
  // It can include methods to fetch user data, update user preferences, etc.

  // Example method to fetch user data
  Future<List<FeedbackModel>> fetchUserData() async {
    return await FeedbackService.getAllFeedback();
  }
}
