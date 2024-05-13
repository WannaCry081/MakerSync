import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/models/notification_model.dart';
import 'package:frontend/services/notification_service.dart';

class NotificationProvider with ChangeNotifier{
  final NotificationService _notificationService = NotificationService();
 
  NotificationModel? _notification;
  late Timer? _timer;

  NotificationProvider() {
    _notification = null;
  }

  void setNotificationData(NotificationModel data) {
    _notification = data;
  }

  Future<List<NotificationModel>> fetchNotifications() async {
    List<NotificationModel> notifications = await _notificationService.fetchNotifications();
    notifyListeners();

    return notifications;
  }


  Future<void> fetchNotification({
    required int id
  }) async {
    final NotificationModel notification = await _notificationService.fetchNotification(
      notificationId: id
    );

    setNotificationData(notification);
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

   Future<void> startFetchingNotifications() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await fetchNotifications();
    });
  }

  NotificationModel? getNotificationData() {
    return _notification;
  }


}