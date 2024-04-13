import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:connectivity_plus/connectivity_plus.dart";


class SettingsProvider with ChangeNotifier {
  SharedPreferences? _pref;
  ConnectivityResult? _conn;

  SettingsProvider() {
    _initPreference();
  }

  Future<void> _initPreference() async {
    _pref = await SharedPreferences.getInstance();
    notifyListeners();
    return;
  }

  Future<void> _initConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    _conn = result;

    notifyListeners();
    return;
  }


  bool getBool(String key){
    return _pref?.getBool(key) ?? false; 
  }

  int getInt(String key){
    return _pref?.getInt(key) ?? -1;
  }

  double getDouble(String key){
    return _pref?.getDouble(key) ?? -1;
  }

  String getString(String key){
    return _pref?.getString(key) ?? "";
  }

  Future<void> setBool(String key, bool value) async{
    await _pref?.setBool(key, value);
    notifyListeners();
  }

  Future<void> setInt(String key, int value) async{
    await _pref?.setInt(key, value);
    notifyListeners();
  }

  Future<void> setDouble(String key, double value) async{
    await _pref?.setDouble(key, value);
    notifyListeners();
  }

  Future<void> setString(String key, String value) async{
    await _pref?.setString(key, value);
    notifyListeners();
  }

  bool getHasWifi() => _conn == ConnectivityResult.none;  
  Stream<ConnectivityResult> getConnectivityResult() => Connectivity().onConnectivityChanged;

}