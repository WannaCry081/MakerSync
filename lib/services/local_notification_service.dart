import 'dart:async';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import "package:timezone/data/latest.dart" as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class LocalNotificationService {
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
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(
      android: android
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        onNotifications.add(response.payload);
      },
    );

    if(initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
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

  static Future showScheduledNotification({
    int id = 0,
    String? title, 
    String? body,
    String? payload,
    required DateTime scheduleDate
  }) async {
    await _notifications.zonedSchedule(
      id, 
      title, 
      body, 
      tz.TZDateTime.from(scheduleDate, tz.local),
      await _notificationDetails(),
      payload: payload, 
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: 
        UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  
}