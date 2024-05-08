
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/models/notification_model.dart';
import 'package:frontend/services/api_constants.dart';

class NotificationService {
  
  Future<NotificationModel> createNotification({
    required String title,
    required String content
  }) async {

    final request = NotificationModel(
      title: title,
      content: content
    );

    final response = await http.post(
      Uri.parse("$NOTIFICATION_URL/$MACHINE_CODE"),
      body: jsonEncode(request.toJson()),
      headers: <String, String> {
        "Content-Type": "application/json; charset=UTF-8"
      }
    );

    if (response.statusCode == 201) {
      return NotificationModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else if (response.statusCode == 400) {
      throw Exception("User already exists.");
    } else if (response.statusCode == 500) {
      throw Exception("Internal Server Error.");
    } else {
      throw Exception("Failed to create user.");
    }
  }
}