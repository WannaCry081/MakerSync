import "dart:async";

import "package:flutter/material.dart";
import "package:frontend/models/user_model.dart";
import "package:frontend/services/authentication_service.dart";
import "package:frontend/services/user_service.dart";

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();

  final _email = MakerSyncAuthentication().getUserEmail;

  UserModel? _user;
  

  UserProvider() {
    _user = null;
    fetchUserCredential().then((_) {
      notifyListeners();
    });
  }


  void setUserData(UserModel data) {
    _user = data;
    return;
  }

  Future<void> fetchUserCredential() async {
    try {
      
      final UserModel user = await _userService.fetchUser(
        email: _email
      );

      setUserData(user);

      notifyListeners();
    } catch (error) {
      print('Failed to fetch user: $error');
    }
  }


  Future<void> addUserCredential({
    required String email,
    required String name
  }) async {

    await _userService.createUser(
      name: name, 
      email: email
    );

    await fetchUserCredential();
  }


  Future<void> updateUserCredential({
    required String email,
    String? name,
    bool? isConnected
  }) async {

    await _userService.updateUser(
      email: _email
    );

    await fetchUserCredential();
  }
  
  UserModel? getUserData() {
    return _user;
  }
}