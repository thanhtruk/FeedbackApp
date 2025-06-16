import 'package:get/get.dart';

enum FeedbackStatus { processing, resolved }

class FeedbackModel {
  final String id;
  final String title;
  final String field;
  final String requestCode;
  final Rx<FeedbackStatus> status;

  FeedbackModel({
    required this.id,
    required this.title,
    required this.field,
    required this.requestCode,
    required FeedbackStatus status,
  }) : status = Rx(status); // để status có thể được quan sát
}
