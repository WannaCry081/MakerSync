import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";


class SettingsProvider with ChangeNotifier {
  SharedPreferences? _pref;

  SettingsProvider() {
    _init();
  }

  Future<void> _init() async {
    _pref = await SharedPreferences.getInstance();
  }

  bool getBool(String key) {
    return _pref?.getBool(key) ?? false; 
  }

}