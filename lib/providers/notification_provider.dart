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
  }

}