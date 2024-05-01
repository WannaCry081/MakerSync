

import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  // final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
  //   StreamController<ReceivedNotification>.broadcast();

  // static final StreamController<String?> selectNotificationStream =
  //     StreamController<String?>.broadcast();

  // static final StreamController<NotificationResponse> selectNotificationStream =
  //   StreamController<NotificationResponse>.broadcast();

      

      
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
      
    // onDidReceiveNotificationResponse:
    //     (NotificationResponse notificationResponse) {
    //   switch (notificationResponse.notificationResponseType) {
    //     case NotificationResponseType.selectedNotification:
    //       selectNotificationStream.add(notificationResponse.payload);
    //       break;
    //     case NotificationResponseType.selectedNotificationAction:
    //       // if (notificationResponse.actionId == navigationActionId) {
    //       //   selectNotificationStream.add(notificationResponse.payload);
    //       // }
    //       break;
    //   }
    // },

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