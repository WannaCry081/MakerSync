

import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
     
      
  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name', 
        channelDescription: 'channel description',
        importance: Importance.max,
        icon: 'mipmap/ic_launcher',
      ),
    );
  }

  static Future initializeNotification({ bool initScheduled  = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(
      android: android
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        onNotifications.add(response.payload);
      },
    );
  }

  static Future showNotification({
    int id = 0,
    String? title, 
    String? body,
    String? payload,
  }) async =>
    _notifications.show(
      id, 
      title, 
      body, 
      await _notificationDetails(),
      payload: payload,
  );
}