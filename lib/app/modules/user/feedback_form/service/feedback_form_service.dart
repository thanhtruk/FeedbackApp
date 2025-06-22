import 'dart:async';
import 'dart:convert';

import 'package:feedback_app/app/models/question_model.dart';
import 'package:feedback_app/app/modules/user/feedback_form/models/sarcasm_model.dart';
import 'package:feedback_app/app/modules/user/feedback_form/models/send_email_model.dart';
import 'package:http/http.dart' as http;

import '../../../../models/feedback_model.dart';
import '../models/clauses_model.dart';
import '../models/field_model.dart';
import '../models/sentiment_model.dart';

class FeedbackFormService {
  static Future<Field> detectFieldFromText(String text) async {
    final url = Uri.parse('http://10.0.2.2:8000/field/detect');

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'text': text});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return Field.fromJson(jsonDecode(response.body));
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return Field(lable: 'Khác', fieldDetails: []);
      }
    } catch (e) {
      print('Exception: $e');
      return Field(lable: 'Khác', fieldDetails: []);
    }
  }

  static Future<Sarcasm> detectSarcasmFromText(String text) async {
    final url = Uri.parse('http://10.0.2.2:8000/sarcasm/predict');

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'text': text});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return Sarcasm.fromJson(jsonDecode(response.body));
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return Sarcasm(isSarcasm: false, probability: 0.0);
      }
    } catch (e) {
      print('Exception: $e');
      return Sarcasm(isSarcasm: false, probability: 0.0);
    }
  }

  static Future<Clauses> splitTextIntoClauses(String text) async {
    final url = Uri.parse('http://10.0.2.2:8000/clause/split');

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'text': text});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return Clauses.fromJson(jsonDecode(response.body));
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return Clauses(all_clauses: []);
      }
    } catch (e) {
      print('Exception: $e');
      return Clauses(all_clauses: []);
    }
  }

  static Future<Sentiment> detectSentimentFromText(String text) async {
    final url = Uri.parse('http://10.0.2.2:8000/sentiment/predict');

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'text': text});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return Sentiment.fromJson(jsonDecode(response.body));
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return Sentiment(lable: 'neutral', probability: 0.0);
      }
    } catch (e) {
      print('Exception: $e');
      return Sentiment(lable: 'neutral', probability: 0.0);
    }
  }

  static Future<String> submitFeedback(FeedbackModel feedback) async {
    final url = Uri.parse('http://10.0.2.2:5000/feedback');

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(feedback.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        return jsonDecode(response.body)['id'] as String;
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return '';
      }
    } catch (e) {
      print('Exception: $e');
      return '';
    }
  }

  static Future<String> submitQuestion(QuestionModel question) async {
    final url = Uri.parse('http://10.0.2.2:5000/question');

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(question.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        return jsonDecode(response.body)['id'] as String;
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return '';
      }
    } catch (e) {
      print('Exception: $e');
      return '';
    }
  }

  static Future<List<String>> sendEmail(SendEmailModel infor) async {
    final url = Uri.parse('http://10.0.2.2:8000/send-email');

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(infor.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return List<String>.from(jsonDecode(response.body));
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (e) {
      print('Exception: $e');
      return [];
    }
  }
}
