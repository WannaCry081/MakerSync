import "package:flutter/material.dart";


ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor : const Color.fromARGB(255, 104, 110, 198),
  colorScheme: const ColorScheme.dark(
    primary: Color.fromARGB(255, 104, 110, 198),
    secondary: Color.fromARGB(255, 234, 233, 249),
    tertiary: Color.fromARGB(255, 59, 60, 63),
    background: Color.fromARGB(255, 33, 33, 33),
    onBackground: Colors.white
  )
);