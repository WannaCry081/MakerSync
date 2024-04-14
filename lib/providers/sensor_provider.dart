import "package:flutter/material.dart";
import "package:frontend/models/sensor_model.dart";
import "package:frontend/services/sensor_service.dart";

class SensorProvider with ChangeNotifier {
  final SensorService _sensorService = SensorService();

  SensorModel? _sensor;

  SensorProvider() {
    _sensor = null;
  
    notifyListeners();
    return;
  }

  void setSensorData(SensorModel data) {
    _sensor = data;
  }

  
  Future<void> fetchSensor() async {
    final SensorModel sensor = await _sensorService.fetchSensor();

    setSensorData(sensor);
    notifyListeners();
  }

}