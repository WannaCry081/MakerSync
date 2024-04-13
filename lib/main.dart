import "package:flutter/material.dart";
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
          create :(context) => SettingsProvider(),
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
            home : getCurrentView()
          )
        );
      },
    );
  }

  Widget getCurrentView(){
    return const OnboardingView();
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
}