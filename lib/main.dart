import "package:connectivity_plus/connectivity_plus.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:frontend/providers/user_provider.dart";
import "package:frontend/views/Dashboard/index.dart";
import "package:frontend/views/Loading/index.dart";
import "package:frontend/views/NoConnection/index.dart";
import "package:provider/provider.dart";
import "package:frontend/providers/settings_provider.dart";
import "package:frontend/constants/light_theme_const.dart";
import "package:frontend/constants/dark_theme_const.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:frontend/views/Onboarding/index.dart";

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

   runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(),
        ),

        ChangeNotifierProvider(
          create: (context) => UserProvider()
        )
      ],
      child : const MyApp()
    )
  );
}


class MyApp extends StatelessWidget {
  const MyApp({ super.key });

  @override
  Widget build(BuildContext context){
    return Builder(
      builder: (context) {
        final SettingsProvider settings = Provider.of<SettingsProvider>(context);
        final String theme = settings.getString("theme");

        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder : (context, child) {
            return child!;
          },

          child : MaterialApp(
            title : "MakerSync",
            debugShowCheckedModeBanner: false,
            theme : lightTheme,
            darkTheme : darkTheme,
            themeMode: getCurrentTheme(theme),
            home : (settings.getHasWifi())
              ? const NoConnectionView()
              : _homeBuilder(settings: settings)
          )
        );
      },
    );
  }

  ThemeMode? getCurrentTheme(String theme){
    switch (theme){
      case "light" : 
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default: 
        return ThemeMode.system;
    }
  }

  Widget _homeBuilder({
    required SettingsProvider settings
  }) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: settings.getConnectivityResult(),
      builder: (context, snapshot){

        if (snapshot.data!.contains(ConnectivityResult.none)) {
          return const NoConnectionView();
        }

        else if (snapshot.hasData){
          if (FirebaseAuth.instance.currentUser != null) {
            return DashboardView();
          } else {
            return const OnboardingView();
          }
        }

        else {
          return const LoadingView();
        }
      }
    );
  }
}