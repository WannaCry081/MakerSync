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
  }

  Future<void> fetchUserCredential() async {
    final UserModel user = await _userService.fetchUser(
      email: _email
    );

    setUserData(user);
    notifyListeners();
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

  Future<void> deleteUserCredential({
    required String email
  }) async {

    await _userService.deleteUser(
      email: _email
    );
  }
  
  UserModel? getUserData() {
    return _user;
  }
}