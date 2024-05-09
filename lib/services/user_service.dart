import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/api_constants.dart';


class UserService {

  Future<UserModel> createUser({
    required String name,
    required String email
  }) async {

    final request = UserModel(
      name: name,
      email: email,
    );
    
    final response = await http.post(
      Uri.parse(USER_URL),
      body: jsonEncode(request.toJson()),
      headers: <String, String> {
        "Content-Type": "application/json; charset=UTF-8"
      }
    );

    if (response.statusCode == 201) {
        return UserModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else if (response.statusCode == 400) {
        throw Exception("User already exists.");
      } else if (response.statusCode == 500) {
        throw Exception("Internal Server Error.");
      } else {
        throw Exception("Failed to create user.");
      }
  }

  Future<List<UserModel>> fetchUsers() async {
    
    final response = await http.get(Uri.parse(USER_URL));

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

  Future<UserModel> fetchUser({
    required String email
  }) async {

    final response = await http.get(Uri.parse("$USER_URL/$email"));

    if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else if (response.statusCode == 400) {
        throw Exception("Invalid user email.");
      } else if (response.statusCode == 404) {
        throw Exception("User not found.");
      } else if (response.statusCode == 500) {
        throw Exception("Internal Server Error.");
      } else {
        throw Exception("Failed to fetch user.");
      }
  }

  
  Future<UserModel> updateUser({
    required String email,
    String? name
  }) async {
    final response = await http.get(Uri.parse("$USER_URL/$email"));

    if (response.statusCode != 200) { throw Exception("Failed to fetch user data."); }

    final userData = UserModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

    final updatedUserData = UserModel(
      email: email,
      name: name ?? userData.name
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


  Future<void> deleteUser({
    required String email
  }) async {

    final response = await http.delete(Uri.parse("$USER_URL/$email"));
    if (response.statusCode == 204) {
      return;
    } else if (response.statusCode == 404) {
      throw Exception("User not found.");
    } else if (response.statusCode == 500) {
      throw Exception("Internal Server Error.");
    } else {
      throw Exception("Failed to delete user.");
    }
  }
}