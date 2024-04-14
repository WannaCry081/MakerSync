import "package:flutter/material.dart";
import "package:frontend/models/sensor_model.dart";
import "package:frontend/services/sensor_service.dart";

class SensorProvider with ChangeNotifier {
  final SensorService _sensorService = SensorService();

  SensorModel? _sensor;

  SensorProvider() {
    _sensor = null;
    fetchSensor().then((_) {
      notifyListeners();
    });
  }

  void setSensorData(SensorModel data) {
    _sensor = data;
  }

  
  Future<void> fetchSensor() async {
    final SensorModel sensor = await _sensorService.fetchSensor();

    setSensorData(sensor);
    notifyListeners();
  }

  Future<void> updateSensor({
    int? counter,
    int? timer,
    double? temperature,
    bool? isInitialized,
    bool? isStart,
    bool? isStop,
  }) async {

    await _sensorService.updateSensor(
      counter: counter,
      timer: timer,
      temperature: temperature,
      isInitialized: isInitialized,
      isStart: isStart,
      isStop: isStop
    );

    await fetchSensor();
  }

  SensorModel? getSensorData(){
    return _sensor;
  }


}