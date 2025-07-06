import 'dart:async';
import 'dart:convert';

import 'package:feedback_app/app/models/send_email_model.dart';
import 'package:http/http.dart' as http;

import '../constants/api.dart';

class EmailService {
  static Future<void> sendEmail(SendEmailModel infor) async {
    final url = Uri.parse('${API.baseUrl}/send-email');

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(infor.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print('[Send Email] Success: ${response.body}');
      } else {
        print('[Send Email] Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('[Send Email] Exception: $e');
    }
  }
}
