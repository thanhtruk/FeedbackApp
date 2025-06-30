import 'dart:convert';

import 'package:feedback_app/app/models/feedback_model.dart';
import 'package:http/http.dart' as http;

class FeedbackService {
  // Example method to retrieve feedback
  static Future<List<FeedbackModel>> getAllFeedback({
    int limit = 10,
    String? startAfterId = 'f1-06-23',
  }) async {
    // Gắn query parameters vào URI
    final uri = Uri.http(
      '10.0.2.2:5000',
      '/feedback',
      {
        'limit': limit.toString(),
        'start_after_id': startAfterId,
      },
    );

    try {
      final response = await http.get(uri).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((item) => FeedbackModel.fromJson(item)).toList();
      } else {
        print(
            '[getAllFeedback 1] Error: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (e) {
      print('[getAllFeedback 2] Exception: $e');
      rethrow;
    }
  }

  // Example method to retrieve feedback by ID
  static Future<FeedbackModel?> getFeedbackById(String id) async {
    final url = Uri.parse('http://10.0.2.2:5000/feedback/$id');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return FeedbackModel.fromJson(jsonDecode(response.body));
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
