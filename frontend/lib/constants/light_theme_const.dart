import "package:flutter/material.dart";


ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor : const Color.fromARGB(255, 54, 48, 98),
  colorScheme: const ColorScheme.light(
    primary: Color.fromARGB(255, 54, 48, 98),
    secondary: Color.fromARGB(255, 166, 177, 225),
    tertiary: Color.fromARGB(255, 244, 238, 255),
    background : Colors.white,
    onBackground:  Color.fromARGB(255, 33, 33, 33)
  ),
);