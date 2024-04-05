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

  
  Future<UserModel> updateUser({
    required String email,
    String? name,
    bool? isConnected
  }) async {
    final response = await http.get(Uri.parse("$USER_URL/$MACHINE_CODE"));

    if (response.statusCode != 200) { throw Exception("Failed to fetch user data."); }

    final userData = UserModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

    final updatedUserData = UserModel(
      email: email,
      name: name ?? userData.name,
      isConnected: isConnected ?? userData.isConnected
    );

    final updatedResponse = await http.put(
      Uri.parse("$USER_URL/$MACHINE_CODE/$email"),
      body: jsonEncode(updatedUserData.toJson()),
      headers: <String, String> {
        "Content-Type" : "application/json; charset=UTF-8"
      }
    );

    if (updatedResponse.statusCode == 200) {
      return updatedUserData;
    } else if (updatedResponse.statusCode == 400) {
      throw Exception("Invalid user update request.");
    } else if (updatedResponse.statusCode == 404) {
      throw Exception("User not found.");
    } else if (updatedResponse.statusCode == 500) {
      throw Exception("Internal Server Error.");
    } else {
      throw Exception("Failed to update user.");
    }

  }
}