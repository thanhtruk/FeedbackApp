import '../../../../models/feedback_model.dart';

class TopIssue {
  final String fieldDetail;
  final List<FeedbackModel> feedbacks;

  TopIssue({
    required this.fieldDetail,
    required this.feedbacks,
  });
}

class TopIssueGroup {
  final String category; // field
  final List<TopIssue> issues;

  TopIssueGroup({
    required this.category,
    required this.issues,
  });
}
