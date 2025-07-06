import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../constants/api.dart';
import '../../../../models/feedback_model.dart';

class FeedbackHandleService {
  static Future<void> submitResponse(FeedbackModel feedback) async {
    // Logic to handle feedback submission
    final url = Uri.parse('${API.baseUrl}/feedback/${feedback.id}');
    final headers = {'Content-Type': 'application/json'};

    final body = {
      'response': feedback.response,
      'status':
          feedback.status, // Assuming status is set to 'handled' after response
    };

    try {
      http
          .put(
        url,
        headers: headers,
        body: jsonEncode(body),
      )
          .then((http.Response response) {
        if (response.statusCode == 200) {
          print('Feedback response submitted successfully.');
        } else {
          print('Failed to submit feedback response: ${response.statusCode}');
        }
      }).catchError((error) {
        print('Error submitting feedback response: $error');
      });
    } catch (e) {
      print('Exception occurred while submitting feedback response: $e');
    }
  }

  static Future<void> submitFieldSelection(FeedbackModel feedback) async {
    // Logic to handle feedback submission
    final url = Uri.parse('${API.baseUrl}/feedback/${feedback.id}');
    final headers = {'Content-Type': 'application/json'};

    final body = {
      'field': feedback.field,
      'status':
          feedback.status, // Assuming status is set to 'handled' after response
    };

    try {
      http
          .put(
        url,
        headers: headers,
        body: jsonEncode(body),
      )
          .then((http.Response response) {
        if (response.statusCode == 200) {
          print('Feedback field submitted successfully.');
        } else {
          print('Failed to submit feedback field: ${response.statusCode}');
        }
      }).catchError((error) {
        print('Error submitting feedback field: $error');
      });
    } catch (e) {
      print('Exception occurred while submitting feedback field: $e');
    }
  }
}
