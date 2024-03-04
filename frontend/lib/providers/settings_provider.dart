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

  int getInt(String key){
    return _pref?.getInt(key) ?? -1;
  }

  String getString(String key){
    return _pref?.getString(key) ?? "";
  }

  Future<void> setBool(String key, bool value) async{
    await _pref?.setBool(key, value);
  }

  Future<void> setInt(String key, int value) async{
    await _pref?.setInt(key, value);
  }
}