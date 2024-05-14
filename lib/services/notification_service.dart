
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


      // overheat and disconnected filament
      List<NotificationModel> machineNotifications = notifications
        .map((notification) => NotificationModel.fromJson(notification as Map<String, dynamic>))
        .where((notification) => notification.title == "Petamentor has been stopped due to some issues.")
        .toList();

      // machine has been initialized, process is starting
      List<NotificationModel> startNotifications = notifications
        .map((notification) => NotificationModel.fromJson(notification as Map<String, dynamic>))
        .where((notification) => notification.title == "Petamentor has started.")
        .toList();
      
      // emergency button has been clicked
      List<NotificationModel> emergencyNotifications = notifications
        .map((notification) => NotificationModel.fromJson(notification as Map<String, dynamic>))
        .where((notification) => notification.title == "Petamentor's emergency stop has been activated.")
        .toList();

      // process has finished 
      List<NotificationModel> finishNotifications = notifications
        .map((notification) => NotificationModel.fromJson(notification as Map<String, dynamic>))
        .where((notification) => notification.title == "Petamentor has successfully completed the process.")
        .toList();



      if (machineNotifications.isNotEmpty) {
        LocalNotificationService.showScheduledNotification(
          title: machineNotifications[0].title,
          body: machineNotifications[0].content,
          scheduleDate: DateTime.now().add(const Duration(seconds: 2)),
        );
      }

      if (startNotifications.isNotEmpty) {
        LocalNotificationService.showScheduledNotification(
          title: startNotifications[0].title,
          body: startNotifications[0].content,
          scheduleDate: DateTime.now().add(const Duration(seconds: 2)),
        );
      }
      
      if (emergencyNotifications.isNotEmpty) {
        LocalNotificationService.showScheduledNotification(
          title: emergencyNotifications[0].title,
          body: emergencyNotifications[0].content,
          scheduleDate: DateTime.now().add(const Duration(seconds: 2)),
        );
      }

      if (finishNotifications.isNotEmpty) {
        LocalNotificationService.showScheduledNotification(
          title: finishNotifications[0].title,
          body: finishNotifications[0].content,
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