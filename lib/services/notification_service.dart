
import 'dart:convert';
import 'package:frontend/services/local_notification_service.dart';
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
      Uri.parse(NOTIFICATION_URL),
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


  Future<List<NotificationModel>> fetchNotifications() async {
    final response = await http.get(Uri.parse(NOTIFICATION_URL));

    if (response.statusCode == 200) {
      final List<dynamic> notifications = json.decode(response.body);
    
      // overheat and disconnected filament
      List<NotificationModel> machineNotifications = notifications
        .map((notification) => NotificationModel.fromJson(notification as Map<String, dynamic>))
        .where((notification) => notification.title == "Petamentor has been stopped due to some issues.")
        .toList();

      // machine has been initialized
      List<NotificationModel> startNotifications = notifications
        .map((notification) => NotificationModel.fromJson(notification as Map<String, dynamic>))
        .where((notification) => notification.title == "Petamentor has started.")
        .toList();
      
      List<NotificationModel> emergencyNotifications = notifications
        .map((notification) => NotificationModel.fromJson(notification as Map<String, dynamic>))
        .where((notification) => notification.title == "Petamentor's emergency stop has been activated.")
        .toList();


      if (machineNotifications.isNotEmpty) {
        Future.delayed(const Duration(seconds: 1), () {
          LocalNotificationService.showScheduledNotification(
            title: machineNotifications[0].title,
            body: machineNotifications[0].content,
            scheduleDate: DateTime.now().add(const Duration(seconds: 1)),
          );
        });
      }

      if (startNotifications.isNotEmpty) {
        Future.delayed(const Duration(seconds: 1), () {
          LocalNotificationService.showScheduledNotification(
            title: startNotifications[0].title,
            body: startNotifications[0].content,
            scheduleDate: DateTime.now().add(const Duration(seconds: 1)),
          );
        });
      }
      
      if (emergencyNotifications.isNotEmpty) {
        Future.delayed(const Duration(seconds: 1), () {
          LocalNotificationService.showScheduledNotification(
            title: emergencyNotifications[0].title,
            body: emergencyNotifications[0].content,
            scheduleDate: DateTime.now().add(const Duration(seconds: 1)),
          );
        });
      }


      return notifications.map((user) => NotificationModel.fromJson(user as Map<String, dynamic>)).toList();
    } else if (response.statusCode == 404) {
      throw Exception("Users not found.");
    } else if (response.statusCode == 500) {
      throw Exception("Internal Server Error.");
    } else {
      throw Exception("Failed to fetch users.");
    }
  }


  Future<NotificationModel> fetchNotification({
    required int notificationId
  }) async {
    final response = await http.get(Uri.parse("$NOTIFICATION_URL/$notificationId"));

    if (response.statusCode == 200) {
      return NotificationModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else if (response.statusCode == 404) {
      throw Exception("Users not found.");
    } else if (response.statusCode == 500) {
      throw Exception("Internal Server Error.");
    } else {
      throw Exception("Failed to fetch users.");
    }
  }

  
}