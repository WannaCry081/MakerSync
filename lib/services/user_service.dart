import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/api_constants.dart';


class UserService {

  Future<List<UserModel>> fetchUsers() async {
    
    final response = await http.get(Uri.parse("$USER_URL/$MACHINE_CODE"));

    if (response.statusCode == 200) {
        final List<dynamic> users = json.decode(response.body);
        return users.map((user) => UserModel.fromJson(user as Map<String, dynamic>)).toList();
      } else if (response.statusCode == 404) {
        throw Exception("Users not found.");
      } else if (response.statusCode == 500) {
        throw Exception("Internal Server Error.");
      } else {
        throw Exception("Failed to fetch users.");
      }

  }
}