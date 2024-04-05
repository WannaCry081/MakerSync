import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/api_constants.dart';


class UserService {

  Future<UserModel> fetchUsers() async {
    
    final response = await http.get(Uri.parse("$USER_URL/$MACHINE_CODE"));

    if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else if (response.statusCode == 400) {
        throw Exception("Invalid sensor request.");
      } else if (response.statusCode == 404) {
        throw Exception("Sensor not found.");
      } else if (response.statusCode == 500) {
        throw Exception("Internal Server Error.");
      } else {
        throw Exception("Failed to fetch sensor.");
      }

  }
}