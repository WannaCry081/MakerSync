import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/views/Dashboard/Home/index.dart';
import 'package:frontend/views/Dashboard/Notifications/index.dart';
import 'package:frontend/views/Dashboard/Settings/index.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DashboardView extends StatelessWidget {
  DashboardView({Key? key}) : super(key:key);

  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

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