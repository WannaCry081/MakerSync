import "package:flutter/material.dart";
import "package:frontend/providers/settings_provider.dart";
import "package:provider/provider.dart";


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
      debugShowCheckedModeBanner: false,
      home : Scaffold()
    );
  }
}