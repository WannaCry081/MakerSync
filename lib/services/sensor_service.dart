import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:frontend/models/Sensor.dart';
import 'package:frontend/services/api_constants.dart';


Future<Sensor> fetchSensor() async {
  final response = await http.get(Uri.parse("$SENSOR_URL/$MACHINE_CODE"));

  switch (response.statusCode) {
    case 200:
      return Sensor.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    case 400:
      throw Exception("Invalid sensor request.");
    case 404:
      throw Exception("Sensor not found.");
    case 500:
      throw Exception("Internal server error");
    default:
      throw Exception("Failed to fetch sensor. Status code: ${response.statusCode}");
  }
}
