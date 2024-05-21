
import 'dart:convert';
import 'package:frontend/services/local_notification_service.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/models/notification_model.dart';
import 'package:frontend/services/api_constants.dart';

class NotificationService {

  DateTime? _latestNotificationTime;  
  
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
        print("created notification!!!!");
        return NotificationModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else if (response.statusCode == 400) {
        throw Exception("Notification with the same ID already exists.");
      } else if (response.statusCode == 500) {
        throw Exception("Internal Server Error.");
      } else {
        print("FAILED! : ${response.statusCode}");
        throw Exception("Failed to create notification.");
      }
    }


  Future<List<NotificationModel>> fetchNotifications() async {
    final response = await http.get(Uri.parse(NOTIFICATION_URL));

    print(response.statusCode);


    if (response.statusCode == 200) {
      final List<dynamic> notifications = json.decode(response.body);
      DateTime? latestTime = _latestNotificationTime;

      // Filter notifications based on the title and created time
      List<NotificationModel> filteredNotifications = notifications
          .map((notification) => NotificationModel.fromJson(notification as Map<String, dynamic>))
          .where((notification) {
            DateTime notificationTime = DateTime.parse(notification.created!);
            return latestTime == null || notificationTime.isAfter(latestTime);
          }).toList();

      // Update the latest notification time
      if (filteredNotifications.isNotEmpty) {
        _latestNotificationTime = filteredNotifications
            .map((notification) => DateTime.parse(notification.created!))
            .reduce((a, b) => a.isAfter(b) ? a : b);
      }

      // Trigger local notifications
      for (var notification in filteredNotifications) {
        LocalNotificationService.showScheduledNotification(
          title: notification.title,
          body: notification.content,
          scheduleDate: DateTime.now().add(const Duration(seconds: 2)),
        );
      }

      return notifications.map((notification) => NotificationModel.fromJson(notification as Map<String, dynamic>)).toList();

    } else if (response.statusCode == 404) {
       throw Exception("Notifications not found.");
    } else if (response.statusCode == 500) {
      throw Exception("Internal Server Error.");
    } else {
      print("FAILED!: ${response.statusCode}");
      throw Exception("Failed to fetch notifications.");
    }
  }


  Future<NotificationModel> fetchNotification({
    required int notificationId
  }) async {
    final response = await http.get(Uri.parse("$NOTIFICATION_URL/$notificationId"));

    if (response.statusCode == 200) {
      return NotificationModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else if (response.statusCode == 404) {
      throw Exception("Notifications not found.");
    } else if (response.statusCode == 500) {
      throw Exception("Internal Server Error.");
    } else {
      throw Exception("Failed to fetch notification.");
    }
  }

  
}