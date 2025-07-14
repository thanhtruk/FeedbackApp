import 'dart:async';
import 'dart:convert';

import 'package:feedback_app/app/models/question_model.dart';
import 'package:feedback_app/app/models/send_email_model.dart';
import 'package:feedback_app/app/modules/user/feedback_form/models/sarcasm_model.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/api.dart';
import '../../../../models/feedback_model.dart';
import '../models/clauses_model.dart';
import '../models/field_model.dart';
import '../models/sentiment_model.dart';

class FeedbackFormService {
  static Future<Field> detectFieldFromText(String text) async {
    final url = Uri.parse('${API.baseUrl}/field/detect');

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
    final url = Uri.parse('${API.baseUrl}/sarcasm/predict');

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
    final url = Uri.parse('${API.baseUrl}/clause/split');

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
    final url = Uri.parse('${API.baseUrl}/sentiment/predict');

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
    final url = Uri.parse('${API.baseUrl}/feedback/');

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
    final url = Uri.parse('${API.baseUrl}/question');

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
    final url = Uri.parse('${API.baseUrl}/send-email');

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

  static Future<String> cleanInput(String text) async {
    //ky tu đặc biệt
    final regex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    var apiKey =
        await rootBundle.loadString('lib/app/assets/secret/gpt_api_key.txt');

    var outputText = '';
    String input_text = text.toLowerCase().replaceAll(regex, '');

    final prompt = '''
Bạn là một trợ lý xử lý ngôn ngữ tiếng Việt.

Thực hiện các bước sau với dữ liệu đánh giá phía dưới:
1. Sửa lỗi chính tả, viết thường hoàn toàn (lowercase), loại bỏ các ký tự đặc biệt, icon.
3. Dịch sang tiếng Việt hoàn toàn, kể cả các từ mượn như teacher, lecturer, phòng lab...

Trả về kết quả là đánh giá đã xử lý (không giải thích gì thêm)

Dữ liệu:
$input_text
''';

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "gpt-4o-mini",
          "temperature": 0.2,
          "messages": [
            {"role": "user", "content": prompt}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        outputText = data['choices'][0]['message']['content'];
      } else {
        print("Error from API: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    return outputText;
  }
}
