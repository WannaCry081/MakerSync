import "package:flutter/material.dart";
import "package:frontend/models/user_model.dart";
import "package:frontend/services/user_service.dart";

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();

  UserModel? _user;

  UserProvider() {
    _user = null;
  }
  
}