import 'package:flutter/material.dart';
import 'package:frontend/models/notification_model.dart';
import 'package:frontend/services/notification_service.dart';

class NotificationProvider with ChangeNotifier{
  final NotificationService _notificationService = NotificationService();
 
  NotificationModel? _notification;

  NotificationProvider() {
    _notification = null;
  }

  void setNotificationData(NotificationModel data) {
    _notification = data;
  }

  Future<void> fetchNotifications() async {
    await _notificationService.fetchNotifications();
    notifyListeners();
  }


  Future<void> fetchNotification({
    required int id
  }) async {
    final NotificationModel notification = await _notificationService.fetchNotification(
      notificationId: id
    );

    notifyListeners();
  }


  Future<void> createNotification({
    required String title,
    required String content
  }) async {

    await _notificationService.createNotification(
      title: title, 
      content: content
    );

    await fetchNotifications();
  }
  

}