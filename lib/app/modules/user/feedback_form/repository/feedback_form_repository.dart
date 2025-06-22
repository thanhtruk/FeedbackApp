import 'package:feedback_app/app/modules/user/feedback_form/models/send_email_model.dart';

import '../../../../models/feedback_model.dart';
import '../models/clauses_model.dart';
import '../models/field_model.dart';
import '../models/sarcasm_model.dart';
import '../models/sentiment_model.dart';
import '../service/feedback_form_service.dart';

class FeedbackFormRepository {
  final FeedbackFormService fieldFormService;

  FeedbackFormRepository({required this.fieldFormService});

  Future<Field> detectFieldFromText(String text) async {
    return await FeedbackFormService.detectFieldFromText(text);
  }

  Future<Sarcasm> detectSarcasmFromText(String text) async {
    return await FeedbackFormService.detectSarcasmFromText(text);
  }

  Future<Clauses> splitTextIntoClauses(String text) async {
    return await FeedbackFormService.splitTextIntoClauses(text);
  }

  Future<Sentiment> detectSentimentFromText(String text) async {
    return await FeedbackFormService.detectSentimentFromText(text);
  }

  Future<FeedbackModel> submitFeedback(FeedbackModel feedback) async {
    return await FeedbackFormService.submitFeedback(feedback);
  }

  //send email
  Future<List<String>> sendEmail(SendEmailModel infor) async {
    return await FeedbackFormService.sendEmail(infor);
  }
}
