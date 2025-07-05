import 'dart:convert';

import 'package:feedback_app/app/modules/admin/feedback_list/models/ExtractKeywordsModel.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/api.dart';

class FeedbackListService {
  // This class can be used to implement methods related to feedback list operations
  // such as fetching, adding, updating, or deleting feedback entries.

  // Example method to fetch feedbacks
  Future<ExtractKeywordsModel> extractKeywords(String text) async {
    // Simulate a network call or database query
    final url = Uri.parse('${API.baseUrl}/extract/keyword');

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'text': text});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return ExtractKeywordsModel.fromJson(jsonDecode(response.body));
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return ExtractKeywordsModel();
      }
    } catch (e) {
      print('Exception: $e');
      return ExtractKeywordsModel();
    }
  }
}
