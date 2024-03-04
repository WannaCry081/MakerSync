import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:frontend/providers/settings_provider.dart";
import "package:frontend/constants/light_theme_const.dart";
import "package:frontend/constants/dark_theme_const.dart";


void main(){
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
    return MaterialApp(
      title : "MakerSync",
      theme : lightTheme,
      darkTheme : darkTheme,
      debugShowCheckedModeBanner: false,
      home : Scaffold()
    );
  }
}