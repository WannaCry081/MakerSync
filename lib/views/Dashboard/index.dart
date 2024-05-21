import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/services/local_notification_service.dart';
import 'package:frontend/views/Dashboard/Home/index.dart';
import 'package:frontend/views/Dashboard/Notifications/index.dart';
import 'package:frontend/views/Dashboard/Settings/index.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
class DashboardView extends StatefulWidget {
  DashboardView({Key? key}) : super(key:key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override 
  void initState() {
    super.initState();
    LocalNotificationService.initializeNotification(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() {
    LocalNotificationService.onNotifications.stream.listen(
      onClickedNotification
    );
  }

  void onClickedNotification(String? response) {
    print("Response: $response" );

    if (response != null) {
      String? payload = response;
      String title = "";
      String body = "";

      Map<String, dynamic> data = json.decode(payload);
      title = data['title'] ?? "";
      body = data['body'] ?? "";

      print("Payload: $payload" );
      print("Title: $title" );
      print("Body: $body" );

      print("Payload: $payload" );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NotificationsView()
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PersistentTabView(
        context, 
        controller: _controller,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        navBarStyle: NavBarStyle.style12,
        navBarHeight: 60,
        confineInSafeArea: true,
        screens: const [
          HomeView(),
          NotificationsView(),
          SettingsView(),
        ],
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(FeatherIcons.home),
            iconSize: 24.0,
            contentPadding: 3.0,
            title: "Home",
            activeColorPrimary: Theme.of(context).colorScheme.primary,
            inactiveColorPrimary: Colors.grey
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(FeatherIcons.bell),
            iconSize: 24.0,
            contentPadding: 3.0,
            title: "Notifications",
            activeColorPrimary: Theme.of(context).colorScheme.primary,
            inactiveColorPrimary: Colors.grey
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(FeatherIcons.settings),
            iconSize: 24.0,
            contentPadding: 3.0,
            title: "Settings",
            activeColorPrimary: Theme.of(context).colorScheme.primary,
            inactiveColorPrimary: Colors.grey
          ),
        ]
      )
    );
  }
}