import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:frontend/models/Sensor.dart';
import 'package:frontend/services/api_constants.dart';


class SensorService {

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



  Future<Sensor> updateSensor({
    int? counter,
    int? timer,
    double? temperature,
    bool? isInitialized,
    bool? isStart,
    bool? isStop,
  }) async {
    try {
      final response = await http.get(Uri.parse("$SENSOR_URL/$MACHINE_CODE"));

      if (response.statusCode != 200) throw Exception("Failed to fetch sensor data.");

      final sensorData = Sensor.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

      final updatedSensorData = Sensor(
        counter: counter ?? sensorData.counter,
        timer: timer ?? sensorData.timer,
        temperature: temperature ?? sensorData.temperature,
        isInitialized: isInitialized ?? sensorData.isInitialized,
        isStart: isStart ?? sensorData.isStart,
        isStop: isStop ?? sensorData.isStop
      );

      final updatedResponse = await http.put (
        Uri.parse("$SENSOR_URL/$MACHINE_CODE"),
        body: jsonEncode(updatedSensorData.toJson()),
        headers: {
          "Content-Type" : "application/json"
        }
      );

      switch (updatedResponse.statusCode) {
        case 200:
          return Sensor.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
        case 400:
          throw Exception("Invalid sensor request.");
        case 404:
          throw Exception("Sensor not found.");
        case 500:
          throw Exception("Internal server error");
        default:
          throw Exception("Failed to update sensor. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}