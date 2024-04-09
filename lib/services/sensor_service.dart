import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:frontend/models/sensor_model.dart';
import 'package:frontend/services/api_constants.dart';


class SensorService {

  Future<List> fetchSensors() async {
    final response = await http.get(Uri.parse(SENSOR_URL));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List;
    } else if (response.statusCode == 500) {
      throw Exception("Internal Server Error.");
    } else {
      throw Exception("Failed to fetch sensors.");
    }
  }

  Future<SensorModel> fetchSensor() async {

    final response = await http.get(Uri.parse("$SENSOR_URL/$MACHINE_CODE"));

    if (response.statusCode == 200) {
         return SensorModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
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


  Future<SensorModel> updateSensor({
    int? counter,
    int? timer,
    double? temperature,
    bool? isInitialized,
    bool? isStart,
    bool? isStop,
  }) async {
      
      final response = await http.get(Uri.parse("$SENSOR_URL/$MACHINE_CODE"));

      if (response.statusCode != 200) { throw Exception("Failed to fetch sensor data."); }

      final sensorData = SensorModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

      final updatedSensorData = SensorModel(
        counter: counter ?? sensorData.counter,
        timer: timer ?? sensorData.timer,
        temperature: temperature ?? sensorData.temperature,
        isInitialized: isInitialized ?? sensorData.isInitialized,
        isStart: isStart ?? sensorData.isStart,
        isStop: isStop ?? sensorData.isStop
      );

      final updatedResponse = await http.put(
        Uri.parse("$SENSOR_URL/$MACHINE_CODE"),
        body: jsonEncode(updatedSensorData.toJson()),
        headers: <String, String> {
          "Content-Type" : "application/json; charset=UTF-8"
        }
      );

      if (updatedResponse.statusCode == 200) {
         return updatedSensorData;
      } else if (updatedResponse.statusCode == 400) {
        throw Exception("Invalid sensor request.");
      } else if (updatedResponse.statusCode == 404) {
        throw Exception("Sensor not found.");
      } else if (updatedResponse.statusCode == 500) {
        throw Exception("Internal Server Error.");
      } else {
        throw Exception("Failed to update sensor.");
      }

  }
}